# Running SITL
```Bash
  $ cd Firmware
  $ make posix_sitl_default jmavsim
```


# ULog system-wide Replay
  
Firmware를 빌드하고 SITL을 실행시킨 후, Ulog 파일 (*.ulg)을 replay 해주는 기능
ULog를 읽어서 DATA를 mavlink로 변환한 후, UDP로 전송한다. 전달받은 QGroundControl는 실제 비행한 이력대로 동작한다.

#### References  
- [How to](https://dev.px4.io/en/advanced-replay.html)
- [Replay Feature Commit](https://github.com/PX4/Firmware/pull/4817)
- [About SITL](/Users/junhohan/dev/px4/log/ulog)

#### How to Build

```Bash
  $ export replay=<absolute_path_to_log_file.ulg>
  $ make posix_sitl_default
```

#### Settings

빌드가 완료되면 `build_posix_sitl_default_replay` 디렉토리가 생성된다.

`orb_publisher.rules` 파일을 생성하고

```
 [YOUR_PATH]/Firmware/build_posix_sitl_default_replay/tmp/rootfs/orb_publisher.rules
```

파일에 아래 내용을 적고 저장한다.

```
  restrict_topics: sensor_combined, vehicle_gps_position, vehicle_land_detected
  module: replay
  ignore_others: true
```

`replay_params.txt` 파일에는 셋팅할 파라메터를 담을 수 있다. 별다른 내용을 넣지 않으면 Log File에 있는 모든 파라메터가 그대로 적용한다. 또한 실제 비행 중간에 변경한 파라메터가 있는 로그파일을 Replay한다면 동일한 시점에 변경 내용이 적용된다. 하지만, `replay_params.txt`에서 셋팅한 파라메터의 우선순위가 가장 높다.

```
  [YOUR_PATH]/Firmware/build_posix_sitl_default_replay/tmp/rootfs/replay_params.txt
```

#### How to start

위의 설정에 문제가 없다면 SITL을 실행하면 잠시 후, Replay가 자동 시작된다.

```Bash
  $ make posix_sitl_default jmavsim
```

```
  BUILD SUCCESSFUL
  Total time: 0 seconds
  Options parsed, starting Sim.
  Starting GUI...
  3D [dev] 1.6.0-pre12-daily-experimental daily
  Init MAVLink
  INFO  [simulator] Got initial simuation data, running sim..
  Sleeping for 1 s; (1000000 us).
  INFO  [mavlink] mode: Normal, data rate: 4000000 B/s on udp port 14556 remote port 14550
  INFO  [mavlink] mode: Onboard, data rate: 4000000 B/s on udp port 14557 remote port 14540
  INFO  [mavlink] MAVLink only on localhost (set param MAV_BROADCAST = 1 to enable network)
  INFO  [logger] logger started (mode=all)
  INFO  [replay] Applying params from ULog file...
  INFO  [logger] Start file log
  INFO  [replay] Applying override params from rootfs/replay_params.txt...
```