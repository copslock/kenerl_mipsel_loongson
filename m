Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 03:14:56 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:15853 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133900AbWCNDOr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 03:14:47 +0000
Received: (qmail 6941 invoked from network); 14 Mar 2006 03:23:50 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 14 Mar 2006 03:23:50 -0000
Message-ID: <441636D6.80500@ru.mvista.com>
Date:	Tue, 14 Mar 2006 06:21:58 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] Alchemy: make OSS I2S driver build
Content-Type: multipart/mixed;
 boundary="------------000004080707010906010208"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000004080707010906010208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Alchemy OSS I2S driver (sound/oss/au1550_i2s.c) doesn't build if I2C 
driver (drivers/i2c/busses/i2c_au1550.c) is not enabled because 
pb1550_wm_codec_write() is defined there (a dirty hack). So, mark that 
dependency in drivers/i2c/busses/Kconfig.

WBR, Sergei

PS: Also, I've noticed that both I2S and I2C drivers depend solely on
SOC_AU1550. Shouldn't they also work on Au1200?

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------000004080707010906010208
Content-Type: text/plain;
 name="Au1550-I2S-depends-on-I2C.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1550-I2S-depends-on-I2C.patch"

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index b7bd8ab..07eb4a7 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -242,6 +242,9 @@ config SOUND_AU1550_AC97
 config SOUND_AU1550_I2S
 	tristate "Au1550 I2S Sound"
 	depends on SOUND_PRIME && SOC_AU1550
+	# Weird I2S driver needs I2C driver to talk to the codec...
+	select I2C
+	select I2C_AU1550
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"


--------------000004080707010906010208--
