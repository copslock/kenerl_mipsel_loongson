Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2008 15:13:53 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:48818 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20033960AbYF1ONr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2008 15:13:47 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KCbBR-0007he-00
	for linux-mips@linux-mips.org; Sat, 28 Jun 2008 16:13:45 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 244FFDE51A; Sat, 28 Jun 2008 16:13:37 +0200 (CEST)
Date:	Sat, 28 Jun 2008 16:13:37 +0200
To:	linux-mips@linux-mips.org
Subject: Re: SGI O2 sound driver
Message-ID: <20080628141336.GA17727@alpha.franken.de>
References: <20080628000916.GA22049@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080628000916.GA22049@alpha.franken.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Jun 28, 2008 at 02:09:16AM +0200, Thomas Bogendoerfer wrote:
> the dma ring buffer instead of using get_free_pages(). The driver
> is still missing cleanups and features.

v2 is now checkpatch clean and I switched over to use a platform device.
The next step is now to get capture and 2nd playback going.

Thomas.


 arch/mips/sgi-ip32/ip32-platform.c |   18 +
 include/sound/ad1843.h             |   47 +++
 sound/mips/Kconfig                 |    6 +
 sound/mips/Makefile                |    2 +
 sound/mips/ad1843.c                |  644 ++++++++++++++++++++++++++++++++
 sound/mips/sgio2audio.c            |  714 ++++++++++++++++++++++++++++++++++++
 6 files changed, 1431 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 89a71f4..8b624b9 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -65,6 +65,24 @@ static __init int meth_devinit(void)
 
 device_initcall(meth_devinit);
 
+static __init int sgio2audio_devinit(void)
+{
+	struct platform_device *pd;
+	int ret;
+
+	pd = platform_device_alloc("sgio2audio", -1);
+	if (!pd)
+		return -ENOMEM;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		platform_device_put(pd);
+
+	return ret;
+}
+
+device_initcall(sgio2audio_devinit);
+
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
diff --git a/include/sound/ad1843.h b/include/sound/ad1843.h
new file mode 100644
index 0000000..492d10c
--- /dev/null
+++ b/include/sound/ad1843.h
@@ -0,0 +1,47 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
+ */
+
+#ifndef __SOUND_AD1843_H
+#define __SOUND_AD1843_H
+
+struct snd_ad1843 {
+	void *chip;
+	int (*read)(void *chip, int reg);
+	int (*write)(void *chip, int reg, int val);
+};
+
+#define AD1843_GAIN_RECLEV 0
+#define AD1843_GAIN_LINE   1
+#define AD1843_GAIN_CD     2
+#define AD1843_GAIN_MIC    3
+#define AD1843_GAIN_PCM_0  4
+#define AD1843_GAIN_PCM_1  5
+#define AD1843_GAIN_SIZE   (AD1843_GAIN_PCM_1+1)
+
+int ad1843_get_gain(struct snd_ad1843 *ad1843, int id);
+int ad1843_set_gain(struct snd_ad1843 *ad1843, int id, int newval);
+int ad1843_get_recsrc(struct snd_ad1843 *ad1843);
+void ad1843_set_resample_mode(struct snd_ad1843 *ad1843, int onoff);
+int ad1843_set_recsrc(struct snd_ad1843 *ad1843, int newsrc);
+int ad1843_get_outsrc(struct snd_ad1843 *ad1843);
+int ad1843_set_outsrc(struct snd_ad1843 *ad1843, int mask);
+void ad1843_setup_dac(struct snd_ad1843 *ad1843,
+		      unsigned int id,
+		      unsigned int framerate,
+		      snd_pcm_format_t fmt,
+		      unsigned int channels);
+void ad1843_shutdown_dac(struct snd_ad1843 *ad1843,
+			 unsigned int id);
+void ad1843_setup_adc(struct snd_ad1843 *ad1843,
+		      unsigned int framerate,
+		      snd_pcm_format_t fmt,
+		      unsigned int channels);
+void ad1843_shutdown_adc(struct snd_ad1843 *ad1843);
+int ad1843_init(struct snd_ad1843 *ad1843);
+
+#endif /* __SOUND_AD1843_H */
diff --git a/sound/mips/Kconfig b/sound/mips/Kconfig
index 531f8ba..a3e202e 100644
--- a/sound/mips/Kconfig
+++ b/sound/mips/Kconfig
@@ -11,5 +11,11 @@ config SND_AU1X00
 	help
 	  ALSA Sound driver for the Au1x00's AC97 port.
 
+config SND_SGI_O2
+	tristate "SGI O2 Audio"
+	depends on  SND && SGI_IP32
+        help
+                Sound support for the SGI O2 Workstation. 
+
 endmenu
 
diff --git a/sound/mips/Makefile b/sound/mips/Makefile
index 47afed9..55624d8 100644
--- a/sound/mips/Makefile
+++ b/sound/mips/Makefile
@@ -2,7 +2,9 @@
 # Makefile for ALSA
 #
 
+snd-sgi-o2-objs := sgio2audio.o ad1843.o
 snd-au1x00-objs := au1x00.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AU1X00) += snd-au1x00.o
+obj-$(CONFIG_SND_SGI_O2) += snd-sgi-o2.o
diff --git a/sound/mips/ad1843.c b/sound/mips/ad1843.c
new file mode 100644
index 0000000..fca21d2
--- /dev/null
+++ b/sound/mips/ad1843.c
@@ -0,0 +1,644 @@
+/*
+ *   AD1843 low level driver
+ *
+ *   Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
+ *
+ *   inspired from vwsnd.c (SGI VW audio driver)
+ *     Copyright 1999 Silicon Graphics, Inc.  All rights reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/slab.h>
+
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/ad1843.h>
+
+/* TEMP: OSS stuff */
+#include <linux/soundcard.h>
+
+/*
+ * AD1843 bitfield definitions.  All are named as in the AD1843 data
+ * sheet, with ad1843_ prepended and individual bit numbers removed.
+ *
+ * E.g., bits LSS0 through LSS2 become ad1843_LSS.
+ *
+ * Only the bitfields we need are defined.
+ */
+
+struct ad1843_bitfield {
+	char reg;
+	char lo_bit;
+	char nbits;
+};
+
+static const struct ad1843_bitfield
+	ad1843_PDNO   = {  0, 14,  1 },	/* Converter Power-Down Flag */
+	ad1843_INIT   = {  0, 15,  1 },	/* Clock Initialization Flag */
+	ad1843_RIG    = {  2,  0,  4 },	/* Right ADC Input Gain */
+	ad1843_RMGE   = {  2,  4,  1 },	/* Right ADC Mic Gain Enable */
+	ad1843_RSS    = {  2,  5,  3 },	/* Right ADC Source Select */
+	ad1843_LIG    = {  2,  8,  4 },	/* Left ADC Input Gain */
+	ad1843_LMGE   = {  2, 12,  1 },	/* Left ADC Mic Gain Enable */
+	ad1843_LSS    = {  2, 13,  3 },	/* Left ADC Source Select */
+	ad1843_RX1M   = {  4,  0,  5 },	/* Right Aux 1 Mix Gain/Atten */
+	ad1843_RX1MM  = {  4,  7,  1 },	/* Right Aux 1 Mix Mute */
+	ad1843_LX1M   = {  4,  8,  5 },	/* Left Aux 1 Mix Gain/Atten */
+	ad1843_LX1MM  = {  4, 15,  1 },	/* Left Aux 1 Mix Mute */
+	ad1843_RX2M   = {  5,  0,  5 },	/* Right Aux 2 Mix Gain/Atten */
+	ad1843_RX2MM  = {  5,  7,  1 },	/* Right Aux 2 Mix Mute */
+	ad1843_LX2M   = {  5,  8,  5 },	/* Left Aux 2 Mix Gain/Atten */
+	ad1843_LX2MM  = {  5, 15,  1 },	/* Left Aux 2 Mix Mute */
+	ad1843_RMCM   = {  7,  0,  5 },	/* Right Mic Mix Gain/Atten */
+	ad1843_RMCMM  = {  7,  7,  1 },	/* Right Mic Mix Mute */
+	ad1843_LMCM   = {  7,  8,  5 },	/* Left Mic Mix Gain/Atten */
+	ad1843_LMCMM  = {  7, 15,  1 },	/* Left Mic Mix Mute */
+	ad1843_HPOS   = {  8,  4,  1 },	/* Headphone Output Voltage Swing */
+	ad1843_HPOM   = {  8,  5,  1 },	/* Headphone Output Mute */
+	ad1843_MPOM   = {  8,  6,  1 },	/* Mono Output Mute */
+	ad1843_RDA1G  = {  9,  0,  6 },	/* Right DAC1 Analog/Digital Gain */
+	ad1843_RDA1GM = {  9,  7,  1 },	/* Right DAC1 Analog Mute */
+	ad1843_LDA1G  = {  9,  8,  6 },	/* Left DAC1 Analog/Digital Gain */
+	ad1843_LDA1GM = {  9, 15,  1 },	/* Left DAC1 Analog Mute */
+	ad1843_RDA2G  = {  9,  0,  6 },	/* Right DAC2 Analog/Digital Gain */
+	ad1843_RDA2GM = {  9,  7,  1 },	/* Right DAC2 Analog Mute */
+	ad1843_LDA2G  = {  9,  8,  6 },	/* Left DAC2 Analog/Digital Gain */
+	ad1843_LDA2GM = {  9, 15,  1 },	/* Left DAC2 Analog Mute */
+	ad1843_RDA1AM = { 11,  7,  1 },	/* Right DAC1 Digital Mute */
+	ad1843_LDA1AM = { 11, 15,  1 },	/* Left DAC1 Digital Mute */
+	ad1843_RDA2AM = { 11,  7,  1 },	/* Right DAC1 Digital Mute */
+	ad1843_LDA2AM = { 11, 15,  1 },	/* Left DAC1 Digital Mute */
+	ad1843_ADLC   = { 15,  0,  2 },	/* ADC Left Sample Rate Source */
+	ad1843_ADRC   = { 15,  2,  2 },	/* ADC Right Sample Rate Source */
+	ad1843_DA1C   = { 15,  8,  2 },	/* DAC1 Sample Rate Source */
+	ad1843_DA2C   = { 15, 10,  2 },	/* DAC2 Sample Rate Source */
+	ad1843_C1C    = { 17,  0, 16 },	/* Clock 1 Sample Rate Select */
+	ad1843_C2C    = { 20,  0, 16 },	/* Clock 2 Sample Rate Select */
+	ad1843_C3C    = { 23,  0, 16 },	/* Clock 3 Sample Rate Select */
+	ad1843_DAADL  = { 25,  4,  2 },	/* Digital ADC Left Source Select */
+	ad1843_DAADR  = { 25,  6,  2 },	/* Digital ADC Right Source Select */
+	ad1843_DRSFLT = { 25, 15,  1 },	/* Digital Reampler Filter Mode */
+	ad1843_ADLF   = { 26,  0,  2 }, /* ADC Left Channel Data Format */
+	ad1843_ADRF   = { 26,  2,  2 }, /* ADC Right Channel Data Format */
+	ad1843_ADTLK  = { 26,  4,  1 },	/* ADC Transmit Lock Mode Select */
+	ad1843_SCF    = { 26,  7,  1 },	/* SCLK Frequency Select */
+	ad1843_DA1F   = { 26,  8,  2 },	/* DAC1 Data Format Select */
+	ad1843_DA2F   = { 26, 10,  2 },	/* DAC2 Data Format Select */
+	ad1843_DA1SM  = { 26, 14,  1 },	/* DAC1 Stereo/Mono Mode Select */
+	ad1843_DA2SM  = { 26, 15,  1 },	/* DAC2 Stereo/Mono Mode Select */
+	ad1843_ADLEN  = { 27,  0,  1 },	/* ADC Left Channel Enable */
+	ad1843_ADREN  = { 27,  1,  1 },	/* ADC Right Channel Enable */
+	ad1843_AAMEN  = { 27,  4,  1 },	/* Analog to Analog Mix Enable */
+	ad1843_ANAEN  = { 27,  7,  1 },	/* Analog Channel Enable */
+	ad1843_DA1EN  = { 27,  8,  1 },	/* DAC1 Enable */
+	ad1843_DA2EN  = { 27,  9,  1 },	/* DAC2 Enable */
+	ad1843_C1EN   = { 28, 11,  1 },	/* Clock Generator 1 Enable */
+	ad1843_C2EN   = { 28, 12,  1 },	/* Clock Generator 2 Enable */
+	ad1843_C3EN   = { 28, 13,  1 },	/* Clock Generator 3 Enable */
+	ad1843_PDNI   = { 28, 15,  1 };	/* Converter Power Down */
+
+/*
+ * The various registers of the AD1843 use three different formats for
+ * specifying gain.  The ad1843_gain structure parameterizes the
+ * formats.
+ */
+
+struct ad1843_gain {
+	int	negative;		/* nonzero if gain is negative. */
+	const struct ad1843_bitfield *lfield;
+	const struct ad1843_bitfield *rfield;
+};
+
+const struct ad1843_gain ad1843_gain_RECLEV = {
+	0, &ad1843_LIG,   &ad1843_RIG
+};
+const struct ad1843_gain ad1843_gain_LINE = {
+	1, &ad1843_LX1M,  &ad1843_RX1M
+};
+const struct ad1843_gain ad1843_gain_CD = {
+	1, &ad1843_LX2M,  &ad1843_RX2M
+};
+const struct ad1843_gain ad1843_gain_MIC = {
+	1, &ad1843_LMCM,  &ad1843_RMCM
+};
+const struct ad1843_gain ad1843_gain_PCM_0 = {
+	1, &ad1843_LDA1G, &ad1843_RDA1G
+};
+const struct ad1843_gain ad1843_gain_PCM_1 = {
+	1, &ad1843_LDA2G, &ad1843_RDA2G
+};
+
+const struct ad1843_gain *ad1843_gain[AD1843_GAIN_SIZE] =
+{
+	&ad1843_gain_RECLEV,
+	&ad1843_gain_LINE,
+	&ad1843_gain_CD,
+	&ad1843_gain_MIC,
+	&ad1843_gain_PCM_0,
+	&ad1843_gain_PCM_1,
+};
+
+/* read the current value of an AD1843 bitfield. */
+
+static int ad1843_read_bits(struct snd_ad1843 *ad1843,
+			    const struct ad1843_bitfield *field)
+{
+	int w = ad1843->read(ad1843->chip, field->reg);
+	int val = w >> field->lo_bit & ((1 << field->nbits) - 1);
+
+	return val;
+}
+
+/*
+ * write a new value to an AD1843 bitfield and return the old value.
+ */
+
+static int ad1843_write_bits(struct snd_ad1843 *ad1843,
+			     const struct ad1843_bitfield *field,
+			     int newval)
+{
+	int w = ad1843->read(ad1843->chip, field->reg);
+	int mask = ((1 << field->nbits) - 1) << field->lo_bit;
+	int oldval = (w & mask) >> field->lo_bit;
+	int newbits = (newval << field->lo_bit) & mask;
+	w = (w & ~mask) | newbits;
+	(void) ad1843->write(ad1843->chip, field->reg, w);
+
+	return oldval;
+}
+
+/*
+ * ad1843_read_multi reads multiple bitfields from the same AD1843
+ * register.  It uses a single read cycle to do it.  (Reading the
+ * ad1843 requires 256 bit times at 12.288 MHz, or nearly 20
+ * microseconds.)
+ *
+ * Called like this.
+ *
+ *  ad1843_read_multi(ad1843, nfields,
+ *		      &ad1843_FIELD1, &val1,
+ *		      &ad1843_FIELD2, &val2, ...);
+ */
+
+static void ad1843_read_multi(struct snd_ad1843 *ad1843, int argcount, ...)
+{
+	va_list ap;
+	const struct ad1843_bitfield *fp;
+	int w = 0, mask, *value, reg = -1;
+
+	va_start(ap, argcount);
+	while (--argcount >= 0) {
+		fp = va_arg(ap, const struct ad1843_bitfield *);
+		value = va_arg(ap, int *);
+		if (reg == -1) {
+			reg = fp->reg;
+			w = ad1843->read(ad1843->chip, reg);
+		}
+
+		mask = (1 << fp->nbits) - 1;
+		*value = w >> fp->lo_bit & mask;
+	}
+	va_end(ap);
+}
+
+/*
+ * ad1843_write_multi stores multiple bitfields into the same AD1843
+ * register.  It uses one read and one write cycle to do it.
+ *
+ * Called like this.
+ *
+ *  ad1843_write_multi(ad1843, nfields,
+ *		       &ad1843_FIELD1, val1,
+ *		       &ad1843_FIELF2, val2, ...);
+ */
+
+static void ad1843_write_multi(struct snd_ad1843 *ad1843, int argcount, ...)
+{
+	va_list ap;
+	int reg;
+	const struct ad1843_bitfield *fp;
+	int value;
+	int w, m, mask, bits;
+
+	mask = 0;
+	bits = 0;
+	reg = -1;
+
+	va_start(ap, argcount);
+	while (--argcount >= 0) {
+		fp = va_arg(ap, const struct ad1843_bitfield *);
+		value = va_arg(ap, int);
+		if (reg == -1)
+			reg = fp->reg;
+
+		m = ((1 << fp->nbits) - 1) << fp->lo_bit;
+		mask |= m;
+		bits |= (value << fp->lo_bit) & m;
+	}
+	va_end(ap);
+
+	if (~mask & 0xFFFF)
+		w = ad1843->read(ad1843->chip, reg);
+	else
+		w = 0;
+	w = (w & ~mask) | bits;
+	(void) ad1843->write(ad1843->chip, reg, w);
+}
+
+/*
+ * ad1843_get_gain reads the specified register and extracts the gain value
+ * using the supplied gain type.  It returns the gain in OSS format.
+ */
+
+int ad1843_get_gain(struct snd_ad1843 *ad1843, int id)
+{
+	int lg, rg;
+	const struct ad1843_gain *gp = ad1843_gain[id];
+	unsigned short mask = (1 << gp->lfield->nbits) - 1;
+
+	ad1843_read_multi(ad1843, 2, gp->lfield, &lg, gp->rfield, &rg);
+	if (gp->negative) {
+		lg = mask - lg;
+		rg = mask - rg;
+	}
+	lg = (lg * 100 + (mask >> 1)) / mask;
+	rg = (rg * 100 + (mask >> 1)) / mask;
+	return lg << 0 | rg << 8;
+}
+
+/*
+ * Set an audio channel's gain. Converts from OSS format to AD1843's
+ * format.
+ *
+ * Returns the new gain, which may be lower than the old gain.
+ */
+
+int ad1843_set_gain(struct snd_ad1843 *ad1843, int id, int newval)
+{
+	const struct ad1843_gain *gp = ad1843_gain[id];
+	unsigned short mask = (1 << gp->lfield->nbits) - 1;
+
+	int lg = newval >> 0 & 0xFF;
+	int rg = newval >> 8;
+	if (lg < 0 || lg > 100 || rg < 0 || rg > 100)
+		return -EINVAL;
+	lg = (lg * mask + (mask >> 1)) / 100;
+	rg = (rg * mask + (mask >> 1)) / 100;
+	if (gp->negative) {
+		lg = mask - lg;
+		rg = mask - rg;
+	}
+	ad1843_write_multi(ad1843, 2, gp->lfield, lg, gp->rfield, rg);
+	return ad1843_get_gain(ad1843, id);
+}
+
+/* Returns the current recording source, in OSS format. */
+
+int ad1843_get_recsrc(struct snd_ad1843 *ad1843)
+{
+	int ls = ad1843_read_bits(ad1843, &ad1843_LSS);
+
+	switch (ls) {
+	case 1:
+		return SOUND_MASK_MIC;
+	case 2:
+		return SOUND_MASK_LINE;
+	case 3:
+		return SOUND_MASK_CD;
+	case 6:
+		return SOUND_MASK_PCM;
+	default:
+		return -1;
+	}
+}
+
+/*
+ * Enable/disable digital resample mode in the AD1843.
+ *
+ * The AD1843 requires that ADL, ADR, DA1 and DA2 be powered down
+ * while switching modes.  So we save DA's state, power them down,
+ * switch into/out of resample mode, power them up, and restore state.
+ *
+ * This will cause audible glitches if D/A or A/D is going on, so the
+ * driver disallows that (in mixer_write_ioctl()).
+ *
+ * The open question is, is this worth doing?  I'm leaving it in,
+ * because it's written, but...
+ */
+
+void ad1843_set_resample_mode(struct snd_ad1843 *ad1843, int onoff)
+{
+	/* Save DA's mute and gain (addr 9/10 is analog gain/attenuation) */
+	int save_da1 = ad1843->read(ad1843->chip, 9);
+	int save_da2 = ad1843->read(ad1843->chip, 10);
+
+	/* Power down A/D and D/A. */
+	ad1843_write_multi(ad1843, 4,
+			   &ad1843_DA1EN, 0,
+			   &ad1843_DA2EN, 0,
+			   &ad1843_ADLEN, 0,
+			   &ad1843_ADREN, 0);
+
+	/* Switch mode */
+	ad1843_write_bits(ad1843, &ad1843_DRSFLT, onoff);
+
+	/* Power up A/D and D/A. */
+	ad1843_write_multi(ad1843, 3,
+			   &ad1843_DA1EN, 1,
+			   &ad1843_DA2EN, 1,
+			   &ad1843_ADLEN, 1,
+			   &ad1843_ADREN, 1);
+
+	/* Restore DA's mute and gain. */
+	ad1843->write(ad1843->chip, 9, save_da1);
+	ad1843->write(ad1843->chip, 10, save_da2);
+}
+
+/*
+ * Set recording source.  Arg newsrc specifies an OSS channel mask.
+ *
+ * The complication is that when we switch into/out of loopback mode
+ * (i.e., src = SOUND_MASK_PCM), we change the AD1843 into/out of
+ * digital resampling mode.
+ *
+ * Returns newsrc on success, -errno on failure.
+ */
+
+int ad1843_set_recsrc(struct snd_ad1843 *ad1843, int newsrc)
+{
+	int bits;
+	int oldbits;
+
+	switch (newsrc) {
+	case SOUND_MASK_PCM:
+		bits = 6;
+		break;
+
+	case SOUND_MASK_MIC:
+		bits = 1;
+		break;
+
+	case SOUND_MASK_LINE:
+		bits = 2;
+		break;
+
+	case SOUND_MASK_CD:
+		bits = 3;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	oldbits = ad1843_read_bits(ad1843, &ad1843_LSS);
+	if (newsrc == SOUND_MASK_PCM && oldbits != 6) {
+
+		ad1843_set_resample_mode(ad1843, 1);
+		ad1843_write_multi(ad1843, 2,
+				   &ad1843_DAADL, 2,
+				   &ad1843_DAADR, 2);
+	} else if (newsrc != SOUND_MASK_PCM && oldbits == 6) {
+
+		ad1843_set_resample_mode(ad1843, 0);
+		ad1843_write_multi(ad1843, 2,
+				   &ad1843_DAADL, 0,
+				   &ad1843_DAADR, 0);
+	}
+	ad1843_write_multi(ad1843, 2, &ad1843_LSS, bits, &ad1843_RSS, bits);
+	return newsrc;
+}
+
+/*
+ * Return current output sources, in OSS format.
+ */
+
+int ad1843_get_outsrc(struct snd_ad1843 *ad1843)
+{
+	int pcm, line, mic, cd;
+
+	pcm  = ad1843_read_bits(ad1843, &ad1843_LDA1GM) ? 0 : SOUND_MASK_PCM;
+	line = ad1843_read_bits(ad1843, &ad1843_LX1MM)  ? 0 : SOUND_MASK_LINE;
+	cd   = ad1843_read_bits(ad1843, &ad1843_LX2MM)  ? 0 : SOUND_MASK_CD;
+	mic  = ad1843_read_bits(ad1843, &ad1843_LMCMM)  ? 0 : SOUND_MASK_MIC;
+
+	return pcm | line | cd | mic;
+}
+
+/*
+ * Set output sources.  Arg is a mask of active sources in OSS format.
+ *
+ * Returns source mask on success, -errno on failure.
+ */
+
+int ad1843_set_outsrc(struct snd_ad1843 *ad1843, int mask)
+{
+	int pcm, line, mic, cd;
+
+	if (mask & ~(SOUND_MASK_PCM | SOUND_MASK_LINE |
+		     SOUND_MASK_CD | SOUND_MASK_MIC))
+		return -EINVAL;
+	pcm  = (mask & SOUND_MASK_PCM)  ? 0 : 1;
+	line = (mask & SOUND_MASK_LINE) ? 0 : 1;
+	mic  = (mask & SOUND_MASK_MIC)  ? 0 : 1;
+	cd   = (mask & SOUND_MASK_CD)   ? 0 : 1;
+
+	ad1843_write_multi(ad1843, 2, &ad1843_LDA1GM, pcm, &ad1843_RDA1GM, pcm);
+	ad1843_write_multi(ad1843, 2, &ad1843_LX1MM, line, &ad1843_RX1MM, line);
+	ad1843_write_multi(ad1843, 2, &ad1843_LX2MM, cd,   &ad1843_RX2MM, cd);
+	ad1843_write_multi(ad1843, 2, &ad1843_LMCMM, mic,  &ad1843_RMCMM, mic);
+
+	return mask;
+}
+
+/* Setup ad1843 for D/A conversion. */
+
+void ad1843_setup_dac(struct snd_ad1843 *ad1843,
+		      unsigned int id,
+		      unsigned int framerate,
+		      snd_pcm_format_t fmt,
+		      unsigned int channels)
+{
+	int ad_fmt = 0, ad_mode = 0;
+
+	switch (fmt) {
+	case SNDRV_PCM_FORMAT_S8:
+		ad_fmt = 0;
+		break;
+	case SNDRV_PCM_FORMAT_U8:
+		ad_fmt = 0;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		ad_fmt = 1;
+		break;
+	case SNDRV_PCM_FORMAT_MU_LAW:
+		ad_fmt = 2;
+		break;
+	case SNDRV_PCM_FORMAT_A_LAW:
+		ad_fmt = 3;
+		break;
+	default:
+		break;
+	}
+
+	switch (channels) {
+	case 2:
+		ad_mode = 0;
+		break;
+	case 1:
+		ad_mode = 1;
+		break;
+	default:
+		break;
+	}
+
+	if (id) {
+		ad1843_write_bits(ad1843, &ad1843_C2C, framerate);
+		ad1843_write_multi(ad1843, 2,
+				   &ad1843_DA2SM, ad_mode,
+				   &ad1843_DA2F, ad_fmt);
+	} else {
+		ad1843_write_bits(ad1843, &ad1843_C1C, framerate);
+		ad1843_write_multi(ad1843, 2,
+				   &ad1843_DA1SM, ad_mode,
+				   &ad1843_DA1F, ad_fmt);
+	}
+}
+
+void ad1843_shutdown_dac(struct snd_ad1843 *ad1843, unsigned int id)
+{
+	if (id)
+		ad1843_write_bits(ad1843, &ad1843_DA2F, 1);
+	else
+		ad1843_write_bits(ad1843, &ad1843_DA1F, 1);
+}
+
+void ad1843_setup_adc(struct snd_ad1843 *ad1843,
+		      unsigned int framerate,
+		      snd_pcm_format_t fmt,
+		      unsigned int channels)
+{
+	int da_fmt = 0;
+
+	switch (fmt) {
+	case SNDRV_PCM_FORMAT_S8:	da_fmt = 0; break;
+	case SNDRV_PCM_FORMAT_U8:	da_fmt = 0; break;
+	case SNDRV_PCM_FORMAT_S16_LE:	da_fmt = 1; break;
+	case SNDRV_PCM_FORMAT_MU_LAW:	da_fmt = 2; break;
+	case SNDRV_PCM_FORMAT_A_LAW:	da_fmt = 3; break;
+	default:		break;
+	}
+
+	ad1843_write_bits(ad1843, &ad1843_C3C, framerate);
+	ad1843_write_multi(ad1843, 2,
+			   &ad1843_ADLF, da_fmt, &ad1843_ADRF, da_fmt);
+}
+
+void ad1843_shutdown_adc(struct snd_ad1843 *ad1843)
+{
+	/* nothing to do */
+}
+
+/*
+ * Fully initialize the ad1843.  As described in the AD1843 data
+ * sheet, section "START-UP SEQUENCE".  The numbered comments are
+ * subsection headings from the data sheet.  See the data sheet, pages
+ * 52-54, for more info.
+ *
+ * return 0 on success, -errno on failure.  */
+
+int ad1843_init(struct snd_ad1843 *ad1843)
+{
+	unsigned long later;
+
+	if (ad1843_read_bits(ad1843, &ad1843_INIT) != 0) {
+		printk(KERN_ERR "ad1843: AD1843 won't initialize\n");
+		return -EIO;
+	}
+
+	ad1843_write_bits(ad1843, &ad1843_SCF, 1);
+
+	/* 4. Put the conversion resources into standby. */
+	ad1843_write_bits(ad1843, &ad1843_PDNI, 0);
+	later = jiffies + HZ / 2;	/* roughly half a second */
+
+	while (ad1843_read_bits(ad1843, &ad1843_PDNO)) {
+		if (time_after(jiffies, later)) {
+			printk(KERN_ERR
+			       "ad1843: AD1843 won't power up\n");
+			return -EIO;
+		}
+		schedule();
+	}
+
+	/* 5. Power up the clock generators and enable clock output pins. */
+	ad1843_write_multi(ad1843, 3,
+			   &ad1843_C1EN, 1,
+			   &ad1843_C2EN, 1,
+			   &ad1843_C3EN, 1);
+
+	/* 6. Configure conversion resources while they are in standby. */
+
+	/* DAC1/2 use clock 1/2 as source, ADC uses clock 3.  Always. */
+	ad1843_write_multi(ad1843, 3,
+			   &ad1843_DA1C, 1,
+			   &ad1843_DA1C, 2,
+			   &ad1843_ADLC, 3,
+			   &ad1843_ADRC, 3);
+
+	/* 7. Enable conversion resources. */
+	ad1843_write_bits(ad1843, &ad1843_ADTLK, 1);
+	ad1843_write_multi(ad1843, 5,
+			   &ad1843_ANAEN, 1,
+			   &ad1843_AAMEN, 1,
+			   &ad1843_DA1EN, 1,
+			   &ad1843_DA2EN, 1,
+			   &ad1843_ADLEN, 1,
+			   &ad1843_ADREN, 1);
+
+	/* 8. Configure conversion resources while they are enabled. */
+	ad1843_write_bits(ad1843, &ad1843_DA1C, 1);
+	ad1843_write_bits(ad1843, &ad1843_DA2C, 1);
+
+	/* Unmute all channels. */
+
+	ad1843_set_outsrc(ad1843,
+			  (SOUND_MASK_PCM | SOUND_MASK_LINE |
+			   SOUND_MASK_MIC | SOUND_MASK_CD));
+	ad1843_write_multi(ad1843, 4,
+			   &ad1843_LDA1AM, 0,
+			   &ad1843_RDA1AM, 0,
+			   &ad1843_LDA2AM, 0,
+			   &ad1843_RDA2AM, 0);
+
+	/* Set default recording source to Line In and set
+	 * mic gain to +20 dB.
+	 */
+	ad1843_set_recsrc(ad1843, SOUND_MASK_LINE);
+	ad1843_write_multi(ad1843, 2, &ad1843_LMGE, 1, &ad1843_RMGE, 1);
+
+	/* Set Speaker Out level to +/- 4V and unmute it. */
+	ad1843_write_multi(ad1843, 3,
+			   &ad1843_HPOS, 1,
+			   &ad1843_HPOM, 0,
+			   &ad1843_MPOM, 0);
+
+	return 0;
+}
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
new file mode 100644
index 0000000..dea229b
--- /dev/null
+++ b/sound/mips/sgio2audio.c
@@ -0,0 +1,714 @@
+/*
+ *   Sound driver for Silicon Graphics O2 Workstations A/V board audio.
+ *
+ *   Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
+ *
+ *   INCOMPLETE:
+ *        - finish PCM,
+ *            . finish/test 2nd DAC
+ *            . recording
+ *        - mixer and controls
+ *        - /proc interface
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <asm/ip32/ip32_ints.h>
+#include <asm/ip32/mace.h>
+
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#define SNDRV_GET_ID
+#include <sound/initval.h>
+#include <sound/ad1843.h>
+
+
+MODULE_AUTHOR("Vivien Chappelier <vivien.chappelier@linux-mips.org>");
+MODULE_DESCRIPTION("SGI O2 Audio");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{Silicon Graphics, O2 Audio}}");
+
+
+#define SGIO2AUDIO_MAX_VOLUME 1000
+
+#define AUDIO_CONTROL_RESET              BIT(0) /* 1: reset audio interface */
+#define AUDIO_CONTROL_CODEC_PRESENT      BIT(1) /* 1: codec detected */
+/*  2-8  : channel 1 write ptr alias */
+/*  9-15 : channel 2 read ptr alias */
+/* 16-22 : channel 3 read ptr alias */
+#define AUDIO_CONTROL_VOLUME_BUTTON_UP   BIT(23) /* latched volume button */
+#define AUDIO_CONTROL_VOLUME_BUTTON_DOWN BIT(24) /* latched volume button */
+
+#define CODEC_CONTROL_WORD_SHIFT 0
+#define CODEC_CONTROL_WORD_MASK ((1 << 16) - 1)
+#define CODEC_CONTROL_READ BIT(16)
+#define CODEC_CONTROL_ADDRESS_SHIFT 17
+#define CODEC_CONTROL_ADDRESS_MASK ((1 << 7) - 1)
+
+#define CHANNEL_PTR_SHIFT     5
+#define CHANNEL_PTR_MASK      ((1 << 6) - 1)
+#define CHANNEL_CONTROL_RESET BIT(10) /* 1: reset channel */
+#define CHANNEL_DMA_ENABLE    BIT(9)  /* 1: enable DMA transfer */
+#define CHANNEL_INT_THRESHOLD_DISABLED  (0 << 5) /* interrupt disabled */
+#define CHANNEL_INT_THRESHOLD_25        (1 << 5) /* int on buffer >25% full */
+#define CHANNEL_INT_THRESHOLD_50        (2 << 5) /* int on buffer >50% full */
+#define CHANNEL_INT_THRESHOLD_75        (3 << 5) /* int on buffer >75% full */
+#define CHANNEL_INT_THRESHOLD_EMPTY     (4 << 5) /* int on buffer empty */
+#define CHANNEL_INT_THRESHOLD_NOT_EMPTY (5 << 5) /* int on buffer !empty */
+#define CHANNEL_INT_THRESHOLD_FULL      (6 << 5) /* int on buffer empty */
+#define CHANNEL_INT_THRESHOLD_NOT_FULL  (7 << 5) /* int on buffer !empty */
+
+#define CHANNEL_IN_BASE   (0 << 12)
+#define CHANNEL_OUT1_BASE (1 << 12)
+#define CHANNEL_OUT2_BASE (2 << 12)
+
+#define CHANNEL_RING_SHIFT 12
+#define CHANNEL_RING_SIZE (1 << CHANNEL_RING_SHIFT)
+#define CHANNEL_RING_MASK (CHANNEL_RING_SIZE - 1)
+
+#define CHANNEL_LEFT_SHIFT 40
+#define CHANNEL_RIGHT_SHIFT 8
+
+/* definition of the chip-specific record */
+struct snd_sgio2audio {
+	struct snd_card *card;
+
+	struct snd_pcm *pcm;
+
+	/* codec */
+	struct snd_ad1843 *ad1843;
+	spinlock_t ad1843_lock;
+
+	/* channels */
+	struct {
+		struct snd_pcm_substream *substream;
+		void *buffer;
+		unsigned int pos;
+		snd_pcm_uframes_t size;
+		spinlock_t lock;
+	} channel[3];
+
+	/* properties */
+	int volume;
+	snd_pcm_format_t format;
+
+	/* resources */
+	void *ring_base;
+	dma_addr_t ring_base_dma;
+	int irq_start;
+	int irq_end;
+};
+
+/* PCM hardware definition */
+static struct snd_pcm_hardware snd_sgio2audio_playback_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats =          SNDRV_PCM_FMTBIT_S16_BE,
+	.rates =            SNDRV_PCM_RATE_8000_48000,
+	.rate_min =         8000,
+	.rate_max =         48000,
+	.channels_min =     2,
+	.channels_max =     2,
+	.buffer_bytes_max = 65536,
+	.period_bytes_min = 32768,
+	.period_bytes_max = 65536,
+	.periods_min =      1,
+	.periods_max =      1024,
+};
+
+/* AD1843 access */
+
+/*
+ * read_ad1843_reg returns the current contents of a 16 bit AD1843 register.
+ *
+ * Returns unsigned register value on success, -errno on failure.
+ */
+static int read_ad1843_reg(void *priv, int reg)
+{
+	struct snd_sgio2audio *chip = priv;
+	int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->ad1843_lock, flags);
+
+	writeq((reg << CODEC_CONTROL_ADDRESS_SHIFT) |
+	       CODEC_CONTROL_READ, &mace->perif.audio.codec_control);
+	wmb();
+	val = readq(&mace->perif.audio.codec_control); /* flush bus */
+	udelay(200);
+
+	val = readq(&mace->perif.audio.codec_read);
+
+	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
+	return val;
+}
+
+/*
+ * write_ad1843_reg writes the specified value to a 16 bit AD1843 register.
+ */
+static int write_ad1843_reg(void *priv, int reg, int word)
+{
+	struct snd_sgio2audio *chip = priv;
+	int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->ad1843_lock, flags);
+
+	writeq((reg << CODEC_CONTROL_ADDRESS_SHIFT) |
+	       (word << CODEC_CONTROL_WORD_SHIFT),
+	       &mace->perif.audio.codec_control);
+	wmb();
+	val = readq(&mace->perif.audio.codec_control); /* flush bus */
+	udelay(200);
+
+	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
+	return 0;
+}
+
+static struct snd_ad1843 ad1843_ops = {
+	NULL, /* initialized in snd_sgio2_audio_create */
+	read_ad1843_reg,
+	write_ad1843_reg,
+};
+
+/* low-level audio interface DMA */
+
+/* put some DMA data in bounce buffer, count must be a multiple of 32 */
+/* returns 1 if a period has elapsed */
+static int snd_sgio2audio_dma_push_frag(struct snd_sgio2audio *chip,
+					unsigned int ch, unsigned int count)
+{
+	int ret;
+	s64 l, r;
+	unsigned long dst_base, dst_pos;
+	unsigned long src_base, src_pos, src_mask;
+	u64 *dst;
+	s16 *src;
+	unsigned long flags;
+	struct snd_pcm_runtime *runtime = chip->channel[ch].substream->runtime;
+
+	spin_lock_irqsave(&chip->channel[ch].lock, flags);
+
+	dst_base = (unsigned long) chip->ring_base | (ch << CHANNEL_RING_SHIFT);
+	dst_pos = (unsigned long) readq(&mace->perif.audio.chan[ch].write_ptr);
+	src_base = (unsigned long) chip->channel[ch].buffer;
+	src_pos = (unsigned long) chip->channel[ch].pos;
+	src_mask = frames_to_bytes(runtime, runtime->buffer_size) - 1;
+
+	/* check if a period has elapsed */
+	chip->channel[ch].size += (count >> 3); /* in frames */
+	ret = chip->channel[ch].size >= runtime->period_size;
+	chip->channel[ch].size %= runtime->period_size;
+
+	while (count) {
+		src = (s16 *)(src_base + src_pos);
+		dst = (u64 *)(dst_base + dst_pos);
+
+		l = src[0]; /* sign extend */
+		r = src[1]; /* sign extend */
+
+		*dst = ((l & 0x00ffffff) << CHANNEL_LEFT_SHIFT) |
+			((r & 0x00ffffff) << CHANNEL_RIGHT_SHIFT);
+
+		dst_pos = (dst_pos + sizeof(u64)) & CHANNEL_RING_MASK;
+		src_pos = (src_pos + 2 * sizeof(s16)) & src_mask;
+		count -= sizeof(u64);
+	}
+
+	writeq(dst_pos, &mace->perif.audio.chan[ch].write_ptr); /* in bytes */
+	chip->channel[ch].pos = src_pos;
+
+	spin_unlock_irqrestore(&chip->channel[ch].lock, flags);
+	return ret;
+}
+
+static int snd_sgio2audio_dma_start(struct snd_pcm_substream *substream)
+{
+	struct snd_sgio2audio *chip = snd_pcm_substream_chip(substream);
+	unsigned int index = 1 + substream->number;
+
+	/* reset DMA channel */
+	writeq(CHANNEL_CONTROL_RESET, &mace->perif.audio.chan[index].control);
+	udelay(10);
+	writeq(0, &mace->perif.audio.chan[index].control);
+
+	/* push a full buffer */
+	snd_sgio2audio_dma_push_frag(chip, index, CHANNEL_RING_SIZE - 32);
+
+	/* set DMA to wake on 50% empty and enable interrupt */
+	writeq(CHANNEL_DMA_ENABLE | CHANNEL_INT_THRESHOLD_50,
+	       &mace->perif.audio.chan[index].control);
+	return 0;
+}
+
+static int snd_sgio2audio_dma_stop(struct snd_pcm_substream *substream)
+{
+	unsigned int index = 1 + substream->number;
+
+	writeq(0, &mace->perif.audio.chan[index].control);
+	return 0;
+}
+
+static void snd_sgio2audio_dma_interrupt(struct snd_sgio2audio *chip, int ch)
+{
+	struct snd_pcm_substream *substream = chip->channel[ch].substream;
+	int count;
+
+	/* fill the ring */
+	count = CHANNEL_RING_SIZE -
+		readq(&mace->perif.audio.chan[ch].depth) - 32;
+	if (snd_sgio2audio_dma_push_frag(chip, ch, count))
+		snd_pcm_period_elapsed(substream);
+}
+
+static irqreturn_t snd_sgio2audio_interrupt(int irq, void *dev_id)
+{
+	struct snd_sgio2audio *chip = dev_id;
+	unsigned long status;
+
+	switch (irq) {
+		/* volume changed */
+	case MACEISA_AUDIO_SC_IRQ:
+		status = readq(&mace->perif.audio.control);
+		if (status & AUDIO_CONTROL_VOLUME_BUTTON_UP) {
+			status &= ~AUDIO_CONTROL_VOLUME_BUTTON_UP;
+			writeq(status, &mace->perif.audio.control);
+			if (chip->volume < SGIO2AUDIO_MAX_VOLUME)
+				chip->volume++;
+		}
+		if (status & AUDIO_CONTROL_VOLUME_BUTTON_DOWN) {
+			status &= ~AUDIO_CONTROL_VOLUME_BUTTON_DOWN;
+			writeq(status, &mace->perif.audio.control);
+			if (chip->volume > 0)
+				chip->volume--;
+		}
+		/* program AD1843 with the new volume */
+		ad1843_set_gain(chip->ad1843, AD1843_GAIN_PCM_0,
+				chip->volume / 10);
+		ad1843_set_gain(chip->ad1843, AD1843_GAIN_PCM_1,
+				chip->volume / 10);
+		break;
+
+		/* dma ring ready */
+	case MACEISA_AUDIO1_DMAT_IRQ:
+		snd_sgio2audio_dma_interrupt(chip, 0);
+		break;
+	case MACEISA_AUDIO2_DMAT_IRQ:
+		snd_sgio2audio_dma_interrupt(chip, 1);
+		break;
+	case MACEISA_AUDIO3_DMAT_IRQ:
+		snd_sgio2audio_dma_interrupt(chip, 2);
+		break;
+	default:
+		printk(KERN_ERR "sgio2audio: unhandled interrupt %d\n", irq);
+		/* TEMP : stop DMA */
+		writeq(0, &mace->perif.audio.chan[0].control);
+		writeq(0, &mace->perif.audio.chan[1].control);
+		writeq(0, &mace->perif.audio.chan[2].control);
+		break;
+	}
+	return IRQ_HANDLED;
+}
+
+/* PCM part */
+
+/* PCM playback open callback */
+static int snd_sgio2audio_playback_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw = snd_sgio2audio_playback_hw;
+	return 0;
+}
+
+/* PCM playback close callback */
+static int snd_sgio2audio_playback_close(struct snd_pcm_substream *substream)
+{
+	/* TODO: hardware code */
+	return 0;
+}
+
+/* PCM capture open callback */
+static int snd_sgio2audio_capture_open(struct snd_pcm_substream *substream)
+{
+	struct snd_sgio2audio *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw = snd_sgio2audio_playback_hw;
+
+	/* initialize AD1843 */
+	ad1843_init(chip->ad1843);
+
+	return 0;
+}
+
+/* PCM capture close callback */
+static int snd_sgio2audio_capture_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+
+/* hw_params callback */
+static int snd_sgio2audio_pcm_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *hw_params)
+{
+	/* alloc virtual 'dma' area */
+	if (substream->runtime->dma_area)
+		vfree(substream->runtime->dma_area);
+	substream->runtime->dma_area = vmalloc(params_buffer_bytes(hw_params));
+	if (substream->runtime->dma_area == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/* hw_free callback */
+static int snd_sgio2audio_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	if (substream->runtime->dma_area)
+		vfree(substream->runtime->dma_area);
+	substream->runtime->dma_area = NULL;
+	return 0;
+}
+
+/* prepare callback */
+static int snd_sgio2audio_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_sgio2audio *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int index = 1 + substream->number;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->channel[index].lock, flags);
+
+	/* Setup the pseudo-dma transfer pointers.  */
+	chip->channel[index].buffer = runtime->dma_area;
+	chip->channel[index].pos = 0;
+	chip->channel[index].size = 0;
+	chip->channel[index].substream = substream;
+
+	/* set AD1843 format */
+	/* hardware format is always S16_LE */
+	if (index) {
+		/* playback */
+		ad1843_setup_dac(chip->ad1843,
+				 index - 1,
+				 runtime->rate,
+				 SNDRV_PCM_FORMAT_S16_LE,
+				 runtime->channels);
+	} else {
+		/* capture */
+		ad1843_setup_adc(chip->ad1843,
+				 runtime->rate,
+				 SNDRV_PCM_FORMAT_S16_LE,
+				 runtime->channels);
+	}
+
+	spin_unlock_irqrestore(&chip->channel[index].lock, flags);
+	return 0;
+}
+
+/* trigger callback */
+static int snd_sgio2audio_pcm_trigger(struct snd_pcm_substream *substream,
+				      int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* start the PCM engine */
+		snd_sgio2audio_dma_start(substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* stop the PCM engine */
+		snd_sgio2audio_dma_stop(substream);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* pointer callback */
+static snd_pcm_uframes_t
+snd_sgio2audio_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_sgio2audio *chip = snd_pcm_substream_chip(substream);
+	unsigned int index = 1 + substream->number;
+	snd_pcm_uframes_t current_ptr;
+
+	/* get the current hardware pointer */
+	current_ptr = bytes_to_frames(substream->runtime,
+				      chip->channel[index].pos);
+
+	return current_ptr;
+}
+
+/* get the physical page pointer on the given offset */
+static struct page *snd_sgio2audio_page(struct snd_pcm_substream *substream,
+					unsigned long offset)
+{
+	return vmalloc_to_page(substream->runtime->dma_area + offset);
+}
+
+/* operators */
+static struct snd_pcm_ops snd_sgio2audio_playback_ops = {
+	.open =        snd_sgio2audio_playback_open,
+	.close =       snd_sgio2audio_playback_close,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_sgio2audio_pcm_hw_params,
+	.hw_free =     snd_sgio2audio_pcm_hw_free,
+	.prepare =     snd_sgio2audio_pcm_prepare,
+	.trigger =     snd_sgio2audio_pcm_trigger,
+	.pointer =     snd_sgio2audio_pcm_pointer,
+	.page =        snd_sgio2audio_page,
+};
+
+static struct snd_pcm_ops snd_sgio2audio_capture_ops = {
+	.open =        snd_sgio2audio_capture_open,
+	.close =       snd_sgio2audio_capture_close,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_sgio2audio_pcm_hw_params,
+	.hw_free =     snd_sgio2audio_pcm_hw_free,
+	.prepare =     snd_sgio2audio_pcm_prepare,
+	.trigger =     snd_sgio2audio_pcm_trigger,
+	.pointer =     snd_sgio2audio_pcm_pointer,
+	.page =        snd_sgio2audio_page,
+};
+
+/*
+ *  definitions of capture are omitted here...
+ */
+
+/* create a pcm device */
+static int __devinit snd_sgio2audio_new_pcm(struct snd_sgio2audio *chip)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	/* create a new pcm device with two outputs and one input */
+	err = snd_pcm_new(chip->card, "SGI O2 Audio", 0, 2, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	pcm->private_data = chip;
+	strcpy(pcm->name, "SGI O2 Audio");
+	chip->pcm = pcm;
+
+	/* set operators */
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_sgio2audio_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_sgio2audio_capture_ops);
+	return 0;
+}
+
+/* ALSA driver */
+
+static int snd_sgio2audio_free(struct snd_sgio2audio *chip)
+{
+	int irq;
+
+	/* reset interface */
+	writeq(AUDIO_CONTROL_RESET, &mace->perif.audio.control);
+	udelay(1);
+	writeq(0, &mace->perif.audio.control);
+
+	/* release IRQ's */
+	for (irq = MACEISA_AUDIO_SW_IRQ; irq <= MACEISA_AUDIO3_MERR_IRQ; irq++)
+		free_irq(irq, chip);
+
+	dma_free_coherent(NULL, MACEISA_RINGBUFFERS_SIZE,
+			  chip->ring_base, chip->ring_base_dma);
+
+	/* release card data */
+	kfree(chip);
+	return 0;
+}
+
+static int snd_sgio2audio_dev_free(struct snd_device *device)
+{
+	struct snd_sgio2audio *chip = device->device_data;
+	/* TODO: component destructor */
+	return snd_sgio2audio_free(chip);
+}
+
+static struct snd_device_ops ops = {
+	.dev_free = snd_sgio2audio_dev_free,
+};
+
+static int __devinit snd_sgio2audio_create(struct snd_card *card,
+					   struct snd_sgio2audio **rchip)
+{
+	struct snd_sgio2audio *chip;
+	int i, err, irq;
+
+	*rchip = NULL;
+
+	/* check if a codec is attached to the interface */
+	/* (Audio or Audio/Video board present) */
+	if (!(readq(&mace->perif.audio.control) & AUDIO_CONTROL_CODEC_PRESENT))
+		return -ENOENT;
+
+	chip = kzalloc(sizeof(struct snd_sgio2audio), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	chip->card = card;
+	chip->irq_start = MACEISA_AUDIO_SW_IRQ;
+	chip->irq_end = MACEISA_AUDIO3_MERR_IRQ;
+
+	chip->ring_base = dma_alloc_coherent(NULL, MACEISA_RINGBUFFERS_SIZE,
+					     &chip->ring_base_dma, GFP_USER);
+	if (chip->ring_base == NULL) {
+		printk(KERN_ERR
+		       "sgio2audio: could not allocate ring buffers\n");
+		kfree(chip);
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&chip->ad1843_lock);
+
+	chip->volume = SGIO2AUDIO_MAX_VOLUME;
+
+	/* initialize channels */
+	for (i = 0; i < 3; i++) {
+		spin_lock_init(&chip->channel[i].lock);
+		chip->channel[i].substream = NULL;
+		chip->channel[i].buffer = NULL;
+		chip->channel[i].pos = 0;
+		chip->channel[i].size = 0;
+	}
+
+	/* allocate IRQs */
+	for (irq = chip->irq_start; irq <= chip->irq_end; irq++) {
+		if (request_irq(irq, snd_sgio2audio_interrupt,
+				IRQF_SHARED, "SGI O2 Audio",
+				(void *)chip)) {
+			snd_sgio2audio_free(chip);
+			printk(KERN_ERR
+			       "sgio2audio: cannot allocate irq %d\n", irq);
+			return -EBUSY;
+		}
+	}
+
+	/* reset the interface */
+	writeq(AUDIO_CONTROL_RESET, &mace->perif.audio.control);
+	udelay(1);
+	writeq(0, &mace->perif.audio.control);
+
+	/* set ring base */
+	writeq(chip->ring_base_dma, &mace->perif.ctrl.ringbase);
+
+	/* attach the AD1843 codec */
+	chip->ad1843 = &ad1843_ops;
+	chip->ad1843->chip = (void *) chip;
+
+	/* initialize the AD1843 codec */
+	err = ad1843_init(chip->ad1843);
+	if (err < 0) {
+		snd_sgio2audio_free(chip);
+		return err;
+	}
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
+		snd_sgio2audio_free(chip);
+		return err;
+	}
+	*rchip = chip;
+	return 0;
+}
+
+static int __devinit snd_sgio2audio_probe(struct platform_device *pdev)
+{
+	struct snd_card *card;
+	struct snd_sgio2audio *chip;
+	int err;
+
+	card = snd_card_new(0, 0, THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+
+	err = snd_sgio2audio_create(card, &chip);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	/* TODO : finish PCM, do mixer and /proc */
+	err = snd_sgio2audio_new_pcm(chip);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	strcpy(card->driver, "SGI O2 Audio");
+	strcpy(card->shortname, "SGI O2 Audio");
+	sprintf(card->longname, "%s irq %i-%i",
+		card->shortname,
+		chip->irq_start, chip->irq_end);
+
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	platform_set_drvdata(pdev, card);
+	return 0;
+}
+
+static int __exit snd_sgio2audio_remove(struct platform_device *pdev)
+{
+	struct snd_card *card = platform_get_drvdata(pdev);
+
+	snd_card_free(card);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver sgio2audio_driver = {
+	.probe	= snd_sgio2audio_probe,
+	.remove	= __devexit_p(snd_sgio2audio_remove),
+	.driver = {
+		.name	= "sgio2audio",
+		.owner	= THIS_MODULE,
+	}
+};
+
+static int __init alsa_card_sgio2audio_init(void)
+{
+	return platform_driver_register(&sgio2audio_driver);
+}
+
+static void __exit alsa_card_sgio2audio_exit(void)
+{
+	platform_driver_unregister(&sgio2audio_driver);
+}
+
+module_init(alsa_card_sgio2audio_init)
+module_exit(alsa_card_sgio2audio_exit)


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
