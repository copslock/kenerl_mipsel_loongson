Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 15:45:06 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:41419
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225425AbTIROpD> convert rfc822-to-8bit; Thu, 18 Sep 2003 15:45:03 +0100
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1A001m-0006KJ-00
	for linux-mips@linux-mips.org; Thu, 18 Sep 2003 16:45:02 +0200
Received: from [80.129.140.189] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1A001l-00053J-00
	for linux-mips@linux-mips.org; Thu, 18 Sep 2003 16:45:01 +0200
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
Organization: 4G Mobile Systeme
To: linux-mips@linux-mips.org
Subject: 2.4.22 pci on au1500
Date: Thu, 18 Sep 2003 16:45:00 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309181645.00676.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello!

i just tried 2.4.22 on my au1500 (mtx-1) board and it seems like pci is 
broken. is there anything that has changed for the board initialization, 
which i might have missed?

it woked fine with 2.4.21, there i got:

Autoconfig PCI channel 0x802eaf28
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
00:00.0 Class 0280: 1260:3873 (rev 01)
        Mem at 0x40000000 [size=0x1000]

with 2.4.22 and debugging output enabled, i get:

Autoconfig PCI channel 0x802f0e88
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
config_access: 0 bus 0 device 0 at 0 *data 18000057, conf 0
config_access: 0 bus 0 device 1 at 0 *data 18000057, conf 0
config_access: 0 bus 0 device 2 at 0 *data 180000d7, conf 0
config_access: 0 bus 0 device 3 at 0 *data 18000157, conf 0
config_access: 0 bus 0 device 4 at 0 *data 18000257, conf 0
config_access: 0 bus 0 device 5 at 0 *data 18000457, conf 0
config_access: 0 bus 0 device 6 at 0 *data 18000857, conf 0
config_access: 0 bus 0 device 7 at 0 *data 18001057, conf 0
config_access: 0 bus 0 device 8 at 0 *data 18002057, conf 0
config_access: 0 bus 0 device 9 at 0 *data 18004057, conf 0
config_access: 0 bus 0 device 10 at 0 *data 18008057, conf 0
config_access: 0 bus 0 device 11 at 0 *data 18010057, conf 0
config_access: 0 bus 0 device 12 at 0 *data 18020057, conf 0
config_access: 0 bus 0 device 13 at 0 *data 18040057, conf 0
config_access: 0 bus 0 device 14 at 0 *data 18080057, conf 0
config_access: 0 bus 0 device 15 at 0 *data 18100057, conf 0
config_access: 0 bus 0 device 16 at 0 *data 18200057, conf 0
config_access: 0 bus 0 device 17 at 0 *data 18400057, conf 0
config_access: 0 bus 0 device 18 at 0 *data 18800057, conf 0
config_access: 0 bus 0 device 0 at e *data 18000057, conf c
config_access: 0 bus 0 device 1 at e *data 18000057, conf c
config_access: 0 bus 0 device 2 at e *data 180000d7, conf c
config_access: 0 bus 0 device 3 at e *data 18000157, conf c
config_access: 0 bus 0 device 4 at e *data 18000257, conf c
config_access: 0 bus 0 device 5 at e *data 18000457, conf c
config_access: 0 bus 0 device 6 at e *data 18000857, conf c
config_access: 0 bus 0 device 7 at e *data 18001057, conf c
config_access: 0 bus 0 device 8 at e *data 18002057, conf c
config_access: 0 bus 0 device 9 at e *data 18004057, conf c
config_access: 0 bus 0 device 10 at e *data 18008057, conf c
config_access: 0 bus 0 device 11 at e *data 18010057, conf c
config_access: 0 bus 0 device 12 at e *data 18020057, conf c
config_access: 0 bus 0 device 13 at e *data 18040057, conf c
config_access: 0 bus 0 device 14 at e *data 18080057, conf c
config_access: 0 bus 0 device 15 at e *data 18100057, conf c
config_access: 0 bus 0 device 16 at e *data 18200057, conf c
config_access: 0 bus 0 device 17 at e *data 18400057, conf c
config_access: 0 bus 0 device 18 at e *data 18800057, conf c
config_access: 0 bus 0 device 19 at e *data 19000057, conf c

thanks for your help - again :)

bruno
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/acTsfg2jtUL97G4RAv22AJ4ir4H2D0mTLN157b1c23B65hRDSgCbB41e
mazx3zPs6Pgpwn5H5B1gmSU=
=N4jq
-----END PGP SIGNATURE-----
