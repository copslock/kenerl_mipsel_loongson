Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 20:48:06 +0000 (GMT)
Received: from prahad-5-64.dialup.vol.cz ([IPv6:::ffff:212.20.121.196]:260
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8226179AbTAJUsF>;
	Fri, 10 Jan 2003 20:48:05 +0000
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 18X5zl-0000Bm-00; Fri, 10 Jan 2003 21:43:13 +0100
Date: Fri, 10 Jan 2003 21:43:13 +0100
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Ulf Karlsson <md1ulfc@mdstud.chalmers.se>
Subject: [PATCH] HAL2: fix LE stream playback
Message-ID: <20030110204313.GA712@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@psi.cz>
Return-Path: <ladis@psi.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@psi.cz
Precedence: bulk
X-list: linux-mips

Hi,

several people complained about it on IRC, so here is a patch against
linux_2_4 branch. Please apply.

Side note: recording still doesn't work. while ago i tried to play with
PBUS configuration and found following (refer to hpc3.ps):
1) writing 0x08248844 (ie. 16bit DMA stream) into pbus_dmacfgs produces
   noise at output.
2) writing 0x082c8844 (ie. 16bit with EVEN_HIGH bit set) make playback
   two times faster.
3) writing 0x08248844 (ie. 8 bit stream) works as expected. That is
   strange, because I still believe that HAL2 is 16bit device. I'd guess
   that there are two bugs in driver which neutralizes each other.
In all cases DMA stream wasn't started for recording.


--- XXX/drivers/sound/hal2.c	Mon Aug  5 19:40:50 2002
+++ linux/drivers/sound/hal2.c	Fri Jan 10 21:06:27 2003
@@ -1,6 +1,6 @@
 /*
  *  Driver for HAL2 sound processors
- *  Copyright (c) 2001, 2002 Ladislav Michl <ladis@psi.cz>
+ *  Copyright (c) 2001-2003 Ladislav Michl <ladis@linux-mips.org>
  *  
  *  Based on Ulf Carlsson's code.
  *
@@ -394,7 +394,8 @@
 	fifobeg = 0;				/* playback is first */
 	fifoend = (sample_size * 4) >> 3;	/* doublewords */
 	pbus->ctrl = HPC3_PDMACTRL_RT | HPC3_PDMACTRL_LD |
-		     (highwater << 8) | (fifobeg << 16) | (fifoend << 24);
+		     (highwater << 8) | (fifobeg << 16) | (fifoend << 24) |
+		     (hal2->dac.format & AFMT_S16_LE ? HPC3_PDMACTRL_SEL : 0);
 	/* We disable everything before we do anything at all */
 	pbus->pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
 	hal2_i_clearbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECTX);
@@ -420,7 +421,8 @@
 	fifobeg = (4 * 4) >> 3;				/* record is second */
 	fifoend = (4 * 4 + sample_size * 4) >> 3;	/* doublewords */
 	pbus->ctrl = HPC3_PDMACTRL_RT | HPC3_PDMACTRL_RCV | HPC3_PDMACTRL_LD | 
-		     (highwater << 8) | (fifobeg << 16) | (fifoend << 24);
+		     (highwater << 8) | (fifobeg << 16) | (fifoend << 24) |
+		     (hal2->adc.format & AFMT_S16_LE ? HPC3_PDMACTRL_SEL : 0);
 	pbus->pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
 	hal2_i_clearbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECR);
 	hal2_i_clearbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
