Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2006 17:16:31 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:4260 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133593AbWDBQQW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2006 17:16:22 +0100
Received: (qmail 31622 invoked from network); 2 Apr 2006 20:28:02 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 2 Apr 2006 20:28:02 -0000
Message-ID: <442FFB08.7060002@ru.mvista.com>
Date:	Sun, 02 Apr 2006 20:25:44 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] Au1550: make OSS drivers look pretty on loading
Content-Type: multipart/mixed;
 boundary="------------000109080604040901020208"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000109080604040901020208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Calls to pr_info() without newlines caused the OSS drivers' load time 
messages to be printed w/o any spacing...

WBR, Sergei

PS: Forgot the signoff line again when posting the patch on Friday:

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

--------------000109080604040901020208
Content-Type: text/plain;
 name="Au1550-OSS-print-newlines.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1550-OSS-print-newlines.patch"

diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index f38e082..0ca90a0 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -1950,7 +1950,7 @@ au1550_probe(void)
 		goto err_dma2;
 	}
 
-	pr_info("DAC: DMA%d, ADC: DMA%d", DBDMA_AC97_TX_CHAN, DBDMA_AC97_RX_CHAN);
+	pr_info("DAC: DMA%d, ADC: DMA%d\n", DBDMA_AC97_TX_CHAN, DBDMA_AC97_RX_CHAN);
 
 	/* register devices */
 
@@ -2031,7 +2031,7 @@ au1550_probe(void)
 
 	s->codec_base_caps = rdcodec(s->codec, AC97_RESET);
 	s->codec_ext_caps = rdcodec(s->codec, AC97_EXTENDED_ID);
-	pr_info("AC'97 Base/Extended ID = %04x/%04x",
+	pr_info("AC'97 Base/Extended ID = %04x/%04x\n",
 	     s->codec_base_caps, s->codec_ext_caps);
 
 	if (!(s->codec_ext_caps & AC97_EXTID_VRA)) {
@@ -2047,7 +2047,7 @@ au1550_probe(void)
 		s->no_vra = 1;
 	}
 	if (s->no_vra)
-		pr_info("no VRA, interpolating and decimating");
+		pr_info("no VRA, interpolating and decimating\n");
 
 	/* set mic to be the recording source */
 	val = SOUND_MASK_MIC;
diff --git a/sound/oss/au1550_i2s.c b/sound/oss/au1550_i2s.c
index 529b625..9907ac0 100644
--- a/sound/oss/au1550_i2s.c
+++ b/sound/oss/au1550_i2s.c
@@ -1897,7 +1897,7 @@ au1550_probe(void)
 		goto err_dma2;
 	}
 
-	pr_info("DAC: DMA%d, ADC: DMA%d", DBDMA_I2S_TX_CHAN, DBDMA_I2S_RX_CHAN);
+	pr_info("DAC: DMA%d, ADC: DMA%d\n", DBDMA_I2S_TX_CHAN, DBDMA_I2S_RX_CHAN);
 
 	/* register devices */
 

--------------000109080604040901020208--
