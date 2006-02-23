Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:37:14 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:56128 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133747AbWBWPgp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:36:45 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFhdt16508
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:43:39 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-7EhHYXDKocJ63RYUp16H"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:43:40 +0300
Message-Id: <1140709420.5741.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-7EhHYXDKocJ63RYUp16H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-7EhHYXDKocJ63RYUp16H
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_sound_fix.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_sound_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc.
MR: 14926
Type: Defect Fix
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Aleksey Makarov <makarov@ru.mvista.com>
Description:
    Fixes bug with sound on 11025 and 22050 rates on NEC vr5701.

Index: linux-2.6.10/include/linux/lsppatchlevel.h
===================================================================
--- linux-2.6.10.orig/include/linux/lsppatchlevel.h
+++ linux-2.6.10/include/linux/lsppatchlevel.h
@@ -6,4 +6,4 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#define LSP_PATCH_LEVEL "11"
+#define LSP_PATCH_LEVEL "12"
Index: linux-2.6.10/mvl_patches/pro-0012.c
===================================================================
--- /dev/null
+++ linux-2.6.10/mvl_patches/pro-0012.c
@@ -0,0 +1,16 @@
+/*
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/mvl_patch.h>
+
+static __init int regpatch(void)
+{
+        return mvl_register_patch(12);
+}
+module_init(regpatch);
Index: linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.c
===================================================================
--- linux-2.6.10.orig/sound/pci/vr5701/nec_vr5701_sg2.c
+++ linux-2.6.10/sound/pci/vr5701/nec_vr5701_sg2.c
@@ -89,6 +89,28 @@ static int snd_vr5701_ac97(vr5701_t *chi
 	return snd_ac97_mixer(bus, &ac97, &chip->ac97);
 }
 
+static int set_constraints(snd_pcm_substream_t *substream)
+{
+	int err;
+
+	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 0x10);
+	if( err < 0 )
+		return err;
+
+	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 0x40);
+	if( err < 0 )
+		return err;
+
+	err = snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
+	if( err < 0 )
+		return err;
+
+	return 0;
+}
+
 /* open callback */
 static int snd_vr5701_playback_open(snd_pcm_substream_t *substream)
 {
@@ -97,8 +119,7 @@ static int snd_vr5701_playback_open(snd_
 	substream->runtime->hw = snd_vr5701_playback_hw;
 	chip->next_playback = 0;
 
-	return (snd_pcm_hw_constraint_list(substream->runtime, 0,
-		SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates) < 0); 
+	return set_constraints( substream );
 }
 
 
@@ -110,8 +131,7 @@ static int snd_vr5701_capture_open(snd_p
 	substream->runtime->hw = snd_vr5701_capture_hw;
 	chip->next_capture = 0;
 
-	return (snd_pcm_hw_constraint_list(substream->runtime, 0,
-		SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates) < 0);
+	return set_constraints( substream );
 }
 
 /* hw_params callback */
@@ -215,6 +235,42 @@ static int snd_vr5701_capture_close(snd_
 	return 0;
 }
 
+static inline void playback_next_position(snd_pcm_substream_t *substream, vr5701_t *chip)
+{
+	chip->next_playback = chip->next_playback ? 0 :
+		frames_to_bytes(substream->runtime, substream->runtime->period_size);
+}
+
+static inline void capture_next_position(snd_pcm_substream_t *substream, vr5701_t *chip)
+{
+	chip->next_capture = chip->next_capture ? 0 :
+		frames_to_bytes(substream->runtime, substream->runtime->period_size);
+}
+
+static inline void playback_setup_next(snd_pcm_substream_t *substream, vr5701_t *chip)
+{
+	u32 ch2_offset = (substream->runtime->channels == 1) ? 0 :
+		substream->runtime->dma_bytes/2;
+
+	outl(substream->runtime->dma_addr + chip->next_playback,
+			chip->port + vr5701_DAC1_BADDR);
+	outl(substream->runtime->dma_addr + chip->next_playback + ch2_offset,
+			chip->port + vr5701_DAC2_BADDR);
+}
+
+static inline void capture_setup_next(snd_pcm_substream_t *substream, vr5701_t *chip)
+{
+	if (substream->runtime->channels == 1) {
+		outl(substream->runtime->dma_addr + chip->next_capture,
+					chip->port + vr5701_ADC1_BADDR);
+	} else {
+		outl(substream->runtime->dma_addr+ chip->next_capture,
+					chip->port + vr5701_ADC1_BADDR);
+		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2
+				+ chip->next_capture, chip->port + vr5701_ADC2_BADDR);
+	}
+}
+
 static void vr5701_dma_start_playback(snd_pcm_substream_t *substream)
 {
 	u32 temp;
@@ -230,18 +286,7 @@ static void vr5701_dma_start_playback(sn
 	temp |= vr5701_INT_MASK_DAC1END | vr5701_INT_MASK_DAC2END;
 	outl(temp, chip->port + vr5701_INT_MASK);
 
-	/* setup dma base addr */
-	if (substream->runtime->channels == 1) {
-		outl(substream->runtime->dma_addr + chip->next_playback, 
-						chip->port + vr5701_DAC1_BADDR);
-		outl(substream->runtime->dma_addr + chip->next_playback, 
-						chip->port + vr5701_DAC2_BADDR);
-	} else {
-		outl(substream->runtime->dma_addr + chip->next_playback, 
-						chip->port + vr5701_DAC1_BADDR);
-		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2 
-				+ chip->next_playback, chip->port + vr5701_DAC2_BADDR);
-	}
+	playback_setup_next( substream, chip );
 
 	/* set dma length, in the unit of 0x10 bytes */
 	period_size = (frames_to_bytes(substream->runtime, 
@@ -258,27 +303,10 @@ static void vr5701_dma_start_playback(sn
 	temp |= (vr5701_CTRL_DAC1ENB | vr5701_CTRL_DAC2ENB);
 	outl(temp, chip->port + vr5701_CTRL);
 
-	/* it is time to setup next dma transfer */
-	temp = chip->next_playback + frames_to_bytes(substream->runtime, 
-			substream->runtime->period_size);
+	playback_next_position( substream, chip );
+	playback_setup_next( substream, chip );
+	playback_next_position( substream, chip );
 
-	if (substream->runtime->channels == 1) {
-		if (temp >= substream->runtime->dma_bytes) {
-			temp = 0;
-		}
-		outl(substream->runtime->dma_addr + temp, 
-				chip->port + vr5701_DAC1_BADDR);
-		outl(substream->runtime->dma_addr + temp, 
-				chip->port + vr5701_DAC2_BADDR);
-	} else {
-		if (temp >= substream->runtime->dma_bytes/2) {
-			temp = 0;
-		}
-		outl(substream->runtime->dma_addr + temp, 
-				chip->port + vr5701_DAC1_BADDR);
-		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2
-						+ temp, chip->port + vr5701_DAC2_BADDR);
-	}
 	return ;
 }
 
@@ -297,16 +325,7 @@ static void vr5701_dma_start_capture(snd
 	temp |= vr5701_INT_MASK_ADC1END | vr5701_INT_MASK_ADC2END;
 	outl(temp, chip->port + vr5701_INT_MASK);
 
-	/* setup dma base addr */
-	if (substream->runtime->channels == 1) {
-		outl(substream->runtime->dma_addr + chip->next_capture, 
-					chip->port + vr5701_ADC1_BADDR);
-	} else {
-		outl(substream->runtime->dma_addr+ chip->next_capture, 
-					chip->port + vr5701_ADC1_BADDR);
-		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2 
-				+ chip->next_capture, chip->port + vr5701_ADC2_BADDR);
-	}
+	capture_setup_next( substream, chip );
 
 	/* set dma length, in the unit of 0x10 bytes */
 	period_size = (frames_to_bytes(substream->runtime, 
@@ -331,24 +350,10 @@ static void vr5701_dma_start_capture(snd
 	temp |= (vr5701_CTRL_ADC1ENB | vr5701_CTRL_ADC2ENB);
 	outl(temp, chip->port + vr5701_CTRL);
 
-	/* it is time to setup next dma transfer */
-	temp = chip->next_capture + frames_to_bytes(substream->runtime, 
-			substream->runtime->period_size);
-	if (substream->runtime->channels == 1) {
-		if (temp >= substream->runtime->dma_bytes) {
-			temp = 0;
-		}
-		outl(substream->runtime->dma_addr + temp, 
-				chip->port + vr5701_ADC1_BADDR);
-	} else {
-		if (temp >= substream->runtime->dma_bytes/2) {
-			temp = 0;
-		}
-		outl(substream->runtime->dma_addr + temp, 
-				chip->port + vr5701_ADC1_BADDR);
-		outl(substream->runtime->dma_addr + substream->runtime->dma_bytes/2
-						+ temp,	chip->port + vr5701_ADC2_BADDR);
-	}
+	capture_next_position( substream, chip );
+	capture_setup_next( substream, chip );
+	capture_next_position( substream, chip );
+
 	return ;
 }
 
@@ -474,91 +479,20 @@ static int snd_vr5701_dev_free(snd_devic
 	vr5701_t *chip = device->device_data;
 	return snd_vr5701_free(chip);
 }
-static void vr5701_ac97_adc_interrupt(struct snd_vr5701 *chip)
+static inline void vr5701_ac97_adc_interrupt(struct snd_vr5701 *chip)
 {
-	unsigned temp;
-
-	/* set the base addr for next DMA transfer */
-	temp = chip->next_capture + 2*(frames_to_bytes(chip->substream[CAPTURE]->runtime, 
-			chip->substream[CAPTURE]->runtime->period_size));
-	if (chip->substream[CAPTURE]->runtime->channels == 1) {
-		if (temp >= chip->substream[CAPTURE]->runtime->dma_bytes) {
-			temp -= chip->substream[CAPTURE]->runtime->dma_bytes;
-		}
-	} else {
-		if (temp >= chip->substream[CAPTURE]->runtime->dma_bytes/2) {
-			temp -= chip->substream[CAPTURE]->runtime->dma_bytes/2;
-		}
-	}
-
-	if (chip->substream[CAPTURE]->runtime->channels == 1) {
-		outl(chip->substream[CAPTURE]->runtime->dma_addr 
-				+ temp, chip->port + vr5701_ADC1_BADDR);
-	} else {
-		outl(chip->substream[CAPTURE]->runtime->dma_addr 
-				+ temp, chip->port + vr5701_ADC1_BADDR);
-		outl(chip->substream[CAPTURE]->runtime->dma_addr 
-		+ chip->substream[CAPTURE]->runtime->dma_bytes/2+ temp, 
-						chip->port + vr5701_ADC2_BADDR);
-	}
-
-	/* adjust next pointer */
-	chip->next_capture += frames_to_bytes(chip->substream[CAPTURE]->runtime, 
-					chip->substream[CAPTURE]->runtime->period_size);
-	if (chip->substream[CAPTURE]->runtime->channels == 1) {
-		if (chip->next_capture >= chip->substream[CAPTURE]->runtime->dma_bytes){
-			chip->next_capture = 0;
-		}
-	} else {
-		if (chip->next_capture >= chip->substream[CAPTURE]->runtime->dma_bytes/2){
-			chip->next_capture = 0;
-		}
-	}
+	snd_pcm_substream_t * substream = chip->substream[CAPTURE];
+	capture_setup_next( substream, chip );
+	capture_next_position( substream, chip );
 }
 
-static void vr5701_ac97_dac_interrupt(struct snd_vr5701 *chip)
+static inline void vr5701_ac97_dac_interrupt(struct snd_vr5701 *chip)
 {
-	unsigned temp;
-
-	/* let us set for next next DMA transfer */
-	temp = chip->next_playback + 2*(frames_to_bytes(chip->substream[PLAYBACK]->runtime, 
-			chip->substream[PLAYBACK]->runtime->period_size));
-	if (chip->substream[PLAYBACK]->runtime->channels == 1) {
-		if (temp >= chip->substream[PLAYBACK]->runtime->dma_bytes) {
-			temp -= chip->substream[PLAYBACK]->runtime->dma_bytes;
-		}
-	} else {
-		if (temp >= chip->substream[PLAYBACK]->runtime->dma_bytes/2) {
-			temp -= chip->substream[PLAYBACK]->runtime->dma_bytes/2;
-		}
-	}
-
-	if (chip->substream[PLAYBACK]->runtime->channels == 1) {
-		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
-				+ temp, chip->port + vr5701_DAC1_BADDR);
-		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
-				+ temp, chip->port + vr5701_DAC2_BADDR);
-	} else {
-		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
-				+ temp, chip->port + vr5701_DAC1_BADDR);
-		outl(chip->substream[PLAYBACK]->runtime->dma_addr 
-			+ chip->substream[PLAYBACK]->runtime->dma_bytes/2
-				+ temp,	chip->port + vr5701_DAC2_BADDR);
-	}
-
-	/* adjust next pointer */
-	chip->next_playback += frames_to_bytes(chip->substream[PLAYBACK]->runtime, 
-					chip->substream[PLAYBACK]->runtime->period_size);
-	if (chip->substream[PLAYBACK]->runtime->channels == 1) {
-		if (chip->next_playback >= chip->substream[PLAYBACK]->runtime->dma_bytes){
-			chip->next_playback = 0;
-		}
-	} else {
-		if (chip->next_playback >= chip->substream[PLAYBACK]->runtime->dma_bytes/2){
-			chip->next_playback = 0;
-		}
-	}
+	snd_pcm_substream_t * substream = chip->substream[PLAYBACK];
+	playback_setup_next( substream, chip );
+	playback_next_position( substream, chip );
 }
+
 static irqreturn_t snd_vr5701_interrupt(int irq, void *dev_id,
                                           struct pt_regs *regs)
 {

--=-7EhHYXDKocJ63RYUp16H--
