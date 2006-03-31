Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2006 22:11:43 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:57223 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133468AbWCaVLd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Mar 2006 22:11:33 +0100
Received: (qmail 19113 invoked from network); 1 Apr 2006 01:22:40 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 1 Apr 2006 01:22:40 -0000
Message-ID: <442D9D24.4010507@ru.mvista.com>
Date:	Sat, 01 Apr 2006 01:20:36 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] Au1550: make OSS drivers look pretty on loading
References: <20060327074352.GC4781@dusktilldawn.nl> <4427A31F.9080801@ru.mvista.com>
In-Reply-To: <4427A31F.9080801@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------020401070307060305000003"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020401070307060305000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Calls to pr_info() without newlines caused the OSS drivers' load time 
messages to be printed w/o any spacing...

WBR, Sergei


--------------020401070307060305000003
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
 



--------------020401070307060305000003--
