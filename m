Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 23:03:58 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:29344 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133593AbVL3XDk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Dec 2005 23:03:40 +0000
Received: (qmail 774 invoked from network); 30 Dec 2005 23:05:37 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 30 Dec 2005 23:05:37 -0000
Message-ID: <43B5BDCF.7010900@ru.mvista.com>
Date:	Sat, 31 Dec 2005 02:07:59 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Andrew Morton <akpm@osdl.org>
CC:	Linux MIPS Development <linux-mips@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: [PATCH] Au1xx0: replace casual readl() with au_readl() in the drivers
References: <43452054.2090305@ru.mvista.com> <436FB1DE.6010405@ru.mvista.com>
In-Reply-To: <436FB1DE.6010405@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------060507020306000301020709"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060507020306000301020709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I wrote:

>>     We have found some issues with Au1550 AC'97 OSS driver in 2.6
>> (sound/oss/au1550_ac97.c), though it also should concern 2.4 driver
>> (drivers/sound/au1550_psc.c).
>>     First, we don't think that using readl() calls instead of 
>> au_readl() is
>> correct -- readl() is subject to byte-swapping etc., so may not work in
>> BE mode anymore and au_readl() is intended for embedded Au1550 devices
>> for which the byte swapping issue is resolved automagically,  and BTW the same
>> PSC_AC97STAT register is read "both ways" in the driver.

[skipped]

     Additionally, I've found one unjustified call to readl() in the Au1xx0 USB
code, so adding the fix for it to the patch. Andrew, I'm sending the patch to
you as was advised by Ralf and Jordan...

WBR, Sergei


--------------060507020306000301020709
Content-Type: text/plain;
 name="Au1xx0-use-au_readl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-use-au_readl.patch"

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 486202d..0fc728e 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -66,7 +66,7 @@ static void au1xxx_stop_hc(struct platfo
 	       ": stopping Au1xxx OHCI USB Controller\n");
 
 	/* Disable clock */
-	au_writel(readl((void *)USB_HOST_CONFIG) & ~USBH_ENABLE_CE, USB_HOST_CONFIG);
+	au_writel(au_readl(USB_HOST_CONFIG) & ~USBH_ENABLE_CE, USB_HOST_CONFIG);
 }
 
 
diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index f70effd..64e2e46 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -463,7 +463,7 @@ stop_dac(struct au1550_state *s)
 	/* Wait for Transmit Busy to show disabled.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_TB) != 0);
 
@@ -492,7 +492,7 @@ stop_adc(struct au1550_state *s)
 	/* Wait for Receive Busy to show disabled.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_RB) != 0);
 
@@ -542,7 +542,7 @@ set_xmit_slots(int num_channels)
 	/* Wait for Device ready.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
@@ -574,7 +574,7 @@ set_recv_slots(int num_channels)
 	/* Wait for Device ready.
 	*/
 	do {
-		stat = readl((void *)PSC_AC97STAT);
+		stat = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
@@ -1996,7 +1996,7 @@ au1550_probe(void)
 	/* Wait for PSC ready.
 	*/
 	do {
-		val = readl((void *)PSC_AC97STAT);
+		val = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((val & PSC_AC97STAT_SR) == 0);
 
@@ -2019,7 +2019,7 @@ au1550_probe(void)
 	/* Wait for Device ready.
 	*/
 	do {
-		val = readl((void *)PSC_AC97STAT);
+		val = au_readl(PSC_AC97STAT);
 		au_sync();
 	} while ((val & PSC_AC97STAT_DR) == 0);
 

--------------060507020306000301020709--
