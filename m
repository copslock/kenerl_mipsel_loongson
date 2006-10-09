Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 17:03:35 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:17446 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039692AbWJIQDd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 17:03:33 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1D0DA3ECC; Mon,  9 Oct 2006 09:03:03 -0700 (PDT)
Message-ID: <452A72B9.80109@ru.mvista.com>
Date:	Mon, 09 Oct 2006 20:03:05 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] Alchemy: make OSS I2S driver build (resend)
Content-Type: multipart/mixed;
 boundary="------------010205050805090509000102"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010205050805090509000102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alchemy OSS I2S driver (sound/oss/au1550_i2s.c) doesn't build if I2C
driver (drivers/i2c/busses/i2c_au1550.c) is not enabled because
pb1550_wm_codec_write() is defined there (a dirty hack). So, mark that
dependency in sound/oss/Kconfig...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------010205050805090509000102
Content-Type: text/plain;
 name="Au1550-I2S-depends-on-I2C.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1550-I2S-depends-on-I2C.patch"

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index b7bd8ab..07eb4a7 100644
Index: linux-mips/sound/oss/Kconfig
===================================================================
--- linux-mips.orig/sound/oss/Kconfig
+++ linux-mips/sound/oss/Kconfig
@@ -121,6 +121,9 @@ config SOUND_AU1550_AC97
 config SOUND_AU1550_I2S
 	tristate "Au1550 I2S Sound"
 	depends on SOUND_PRIME && SOC_AU1550
+	# Weird I2S driver needs I2C driver to talk to the codec...
+	select I2C
+	select I2C_AU1550
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"

--------------010205050805090509000102--
