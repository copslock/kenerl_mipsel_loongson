Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2005 20:01:49 +0100 (BST)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:12704
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225930AbVC2TBc>;
	Tue, 29 Mar 2005 20:01:32 +0100
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 29 Mar 2005 11:01:25 -0800
  id 0000846F.4249A605.00001381
Message-ID: <4249A5EE.9070006@jg555.com>
Date:	Tue, 29 Mar 2005 11:01:02 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: 64bit compile of tulip driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Under 32bit the tulip driver works fine, but under 64 bit it gives me a 
lot of grief.

First off it continually sends data out the network interface and never 
negotiates is speed and duplex.
Second in the log files all I see is an uninformative message 
0000:00:07.0: tulip_stop_rxtx() failed

Here is all the bootup information differences I can find on the driver
64 bit
Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!
32 bit
Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809 
advertising 01e1
Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809 
advertising 01e1.

Complete boot log
Under a 64 bit compile
Dec 31 16:01:29 lfs Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 31 16:01:29 lfs PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
Dec 31 16:01:29 lfs tulip0: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:29 lfs tulip0:  EEPROM default media type Autosense.
Dec 31 16:01:29 lfs tulip0:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
Dec 31 16:01:29 lfs eth0: Digital DS21143 Tulip rev 65 at 
ffffffffb0001400, 00:10:E0:00:32:DE, IRQ 19.
Dec 31 16:01:29 lfs PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
Dec 31 16:01:29 lfs tulip1: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:29 lfs tulip1:  EEPROM default media type Autosense.
Dec 31 16:01:29 lfs tulip1:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!
Dec 31 16:01:29 lfs eth1: Digital DS21143 Tulip rev 65 at 
ffffffffb0001480, 00:10:E0:00:32:DF, IRQ 20.
Dec 31 16:01:29 lfs bootlog:  Bringing up the eth0 interface...[  OK  ]
Dec 31 16:01:30 lfs bootlog:  Adding IPv4 address 172.16.0.99 to the 
eth0 interface...[  OK  ]
Dec 31 16:01:31 lfs bootlog:  Setting up default gateway...[  OK  ]
Dec 31 16:01:32 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:38 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:44 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:50 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:56 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:02:02 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:02:08 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:02:12 lfs bootlog:  Setting time via pool.ntp.org...[ FAIL ]

Under 32 bit
Dec 31 16:01:16 lfs Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 31 16:01:16 lfs PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
Dec 31 16:01:16 lfs tulip0: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:16 lfs tulip0:  EEPROM default media type Autosense.
Dec 31 16:01:16 lfs tulip0:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809 
advertising 01e1.
Dec 31 16:01:16 lfs eth0: Digital DS21143 Tulip rev 65 at b0001400, 
00:10:E0:00:32:DE, IRQ 19.
Dec 31 16:01:16 lfs tulip1: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:16 lfs tulip1:  EEPROM default media type Autosense.
Dec 31 16:01:16 lfs tulip1:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809 
advertising 01e1.
Dec 31 16:01:16 lfs eth1: Digital DS21143 Tulip rev 65 at b0001480, 
00:10:E0:00:32:DF, IRQ 20.
Dec 31 16:01:17 lfs bootlog:  Bringing up the eth0 interface...[  OK  ]
Dec 31 16:01:17 lfs bootlog:  Adding IPv4 address 172.16.0.99 to the 
eth0 interface...[  OK  ]
Dec 31 16:01:18 lfs bootlog:  Setting up default gateway...[  OK  ]
Dec 31 16:01:20 lfs eth0: Setting full-duplex based on MII#1 link 
partner capability of 45e1.
Mar 28 08:27:35 lfs bootlog:  Setting time via pool.ntp.org...[  OK  ]
Mar 28 08:27:35 lfs syslog-ng[1457]: STATS: dropped 0

-- 
----
Jim Gifford
maillist@jg555.com
