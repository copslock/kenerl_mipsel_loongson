Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 06:14:47 +0100 (BST)
Received: from post1.wesleyan.edu ([129.133.6.131]:54463 "EHLO
	post1.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022685AbXGKFOl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 06:14:41 +0100
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier1.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l6B5E8Vs020092;
	Wed, 11 Jul 2007 01:14:08 -0400
Received: from pony2.wesleyan.edu (pony2.wesleyan.edu [127.0.0.1])
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11) with ESMTP id l6B5E8SJ022809;
	Wed, 11 Jul 2007 01:14:08 -0400
Received: (from apache@localhost)
	by pony2.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l6B5E7Iu022807;
	Wed, 11 Jul 2007 01:14:07 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 10 Jul 2007 22:14:07 -0700 (PDT)
Message-ID: <47304.129.133.92.31.1184130847.squirrel@webmail.wesleyan.edu>
In-Reply-To: <6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
    <s5hejjpaiwa.wl%tiwai@suse.de>
    <6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
Date:	Tue, 10 Jul 2007 22:14:07 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC] SGI O2 MACE audio ALSA module
From:	sknauert@wesleyan.edu
To:	"TJ" <tj.trevelyan@gmail.com>
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"ALSA Dev List" <alsa-devel@alsa-project.org>
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

Thanks for the quick work. Gave it a try.

Shiva:/usr/src/linux-2.6.21.6# make CROSS_COMPILE=mips-linux-gnu- all
...
  Building modules, stage 2.
  MODPOST 3 modules
WARNING: "snd_pcm_period_elapsed" [sound/mips/snd-mace-audio.ko] undefined!
WARNING: "snd_pcm_set_ops" [sound/mips/snd-mace-audio.ko] undefined!
WARNING: "snd_pcm_lib_ioctl" [sound/mips/snd-mace-audio.ko] undefined!
WARNING: "snd_pcm_new" [sound/mips/snd-mace-audio.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Surprisingly, make modules before trying to compile the kernel didn't give
an error, but these warnings:

Shiva:/usr/src/linux-2.6.21.6# make CROSS_COMPILE=mips-linux-gnu- modules
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  CC      arch/mips/kernel/asm-offsets.s
  GEN     include/asm-mips/asm-offsets.h
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  CC [M]  sound/sound_core.o
  LD [M]  sound/soundcore.o
  CC [M]  sound/core/sound.o
  CC [M]  sound/core/init.o
  CC [M]  sound/core/memory.o
  CC [M]  sound/core/info.o
  CC [M]  sound/core/control.o
  CC [M]  sound/core/misc.o
  CC [M]  sound/core/device.o
  LD [M]  sound/core/snd.o
  CC [M]  sound/mips/mace_audio.o
sound/mips/mace_audio.c: In function ‘sma_pcm_open’:
sound/mips/mace_audio.c:398: warning: unused variable ‘chi’
sound/mips/mace_audio.c: In function ‘sma_gain_put’:
sound/mips/mace_audio.c:893: warning: unused variable ‘flags’
sound/mips/mace_audio.c: In function ‘sma_proc_mace_read’:
sound/mips/mace_audio.c:1023: warning: format ‘%lX’ expects type ‘long
unsigned int’, but argument 3 has type ‘unsigned char *’
sound/mips/mace_audio.c:1023: warning: format ‘%lu’ expects type ‘long
unsigned int’, but argument 4 has type ‘unsigned char *’
sound/mips/mace_audio.c: In function ‘sma_create’:
sound/mips/mace_audio.c:1169: warning: passing argument 2 of ‘request_irq’
from incompatible pointer type
sound/mips/mace_audio.c:1136: warning: unused variable ‘mringbase’
sound/mips/mace_audio.c: At top level:
sound/mips/mace_audio.c:1060: warning: ‘sma_proc_debug_append’ defined but
not used
sound/mips/mace_audio.c:372: warning: ‘print_pointers’ defined but not used
  CC [M]  sound/mips/ad1843.o
  LD [M]  sound/mips/snd-mace-audio.o
  Building modules, stage 2.
  MODPOST 3 modules
  CC      sound/core/snd.mod.o
  LD [M]  sound/core/snd.ko
  CC      sound/mips/snd-mace-audio.mod.o
  LD [M]  sound/mips/snd-mace-audio.ko
  CC      sound/soundcore.mod.o
  LD [M]  sound/soundcore.ko

This seems like a minor oversight like a patch from the wrong directory.

However, if this is a real bug, I'm using gcc 4.1.1-21 with the MIPS
cross-compiler and build system from people.debian.org. I haven't tried
native compilation on the O2 yet. Let me know what you're using to get
something working and I can be more helpful.

I applied the patch -p1 < (let me know if it needs something extra) and
tried both the Linux-MIPS 2.6.21.6 (which isn't linked on the homepage for
some reason) and mainline from kernel.org with my working .config from
2.6.21.3 with make oldconfig.

Again thanks for all the hard work on this driver. I can't wait to get it
working on my O2.

> Hi,
>
> Here is another patch that moves towards addressing some of the issues
> raised about the last patch. Also I had trouble mailing the last patch
> to the linux mips list, mainly because I attached the patch as opposed
> to putting inline, so this time its pasted in. (I guess we'll find out
> if thats safe with Gmail).
>
> This patch was built against Linux-mips.org 2.6.21.6
>
> On 03/07/07, Takashi Iwai <tiwai@suse.de> wrote:
>> At Mon, 2 Jul 2007 12:27:58 +0100,
>> The patch includes old typdefed structs which were already removed
>> from the upstream, such as, snd_card_t.  Please replace them
>> appropriately.  You can find the replacement in
>> include/sound/typedefs.h (in the old kernel tree).
>
> Fixed, does not use typedefs for ALSA structs.
>
>> Similarly, I'd recommend to avoid typedefs in your own code, too.
>
> I still have two typedef structs of my own. However these aren't used
> outside the single C source file.
>
>>
>> Other things I noticed through a quick glance:
>>
>> - Follow the standard coding style, e.g. 80 chars in a line, don't put
>>   if-block in a single line, etc.
>
> I tidily hard wrapped lines that i spotted over 80. How many people
> still using 80 column terminals? Maybe 132 would be a better choice
> these days?
>
> Is something like:
> if (0 > err) goto ERROR_EXIT;
> really that bad? In two lines it isn't much clearer and just user more
> space.
>
>> - Avoid non-ASCII letters, especially outside the comments
>
> Outside of the umlaut in my own name, I think the only place I had
> UTF-8 chars was in ad1843_dump_reg strings, I have fixed this, please
> let me know if there are more.
>
>> - You don't need *_irqsave() in get/put callbacks of the control API.
>>   It's always schedulable, so, spin_lock_irq() suffices.
>
> Done
>
>> - ad1843_lock could be better implemented with mutex if you have long
>>   delays inside the spinlock (except for the calls from irq handler)
>
> Doing this would be something new to me, so it's on my research list/todo
> list.
>
>> - please remove uneeded debug printks.  If they are useful, keep it in
>>   another macro form.
>
> Substituted for snd_printd (which requires CONFIG_SND_DEBUG), but
> still with no indentation so I can find and delete them in future.
>
>> Could you fix these and repost?
> Yes =)
>
> It still plays audio too fast.
> Please let me know about your experience with it, and
> tips/sugestions/bug fixes/etc you have.
>
> Regards,
>
> Thorben
>
> Patch can also be found here:
>
> http://www.linux-mips.org/pub/linux/mips/people/trevelyan/mace_audio/mace_audio-20070709.patch
>
> -------------------------------------
>
> --- linux-2.6.21.6-b/include/sound/ad1843.h	1970-01-01 01:00:00.000000000
> +0100
> +++ linux-2.6.21.6/include/sound/ad1843.h	2007-07-09 19:14:18.000000000
> +0100
> @@ -0,0 +1,48 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General
> Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
> + */
> +
> +#ifndef __SOUND_AD1843_H
> +#define __SOUND_AD1843_H
> +
> +typedef struct {
> +  void *chip;
> +  int (* read)(void *chip, int reg);
> +  int (* write)(void *chip, int reg, int val);
> +} ad1843_t;
> +
> +#define AD1843_GAIN_RECLEV 0
> +#define AD1843_GAIN_LINE   1
> +#define AD1843_GAIN_CD     2
> +#define AD1843_GAIN_MIC    3
> +#define AD1843_GAIN_PCM_0  4
> +#define AD1843_GAIN_PCM_1  5
> +#define AD1843_GAIN_SIZE   AD1843_GAIN_PCM_1+1
> +
> +int ad1843_get_gain(ad1843_t *ad1843, int id);
> +int ad1843_set_gain(ad1843_t *ad1843, int id, int newval);
> +int ad1843_get_recsrc(ad1843_t *ad1843);
> +void ad1843_set_resample_mode(ad1843_t *ad1843, int onoff);
> +int ad1843_set_recsrc(ad1843_t *ad1843, int newsrc);
> +int ad1843_get_outsrc(ad1843_t *ad1843);
> +int ad1843_set_outsrc(ad1843_t *ad1843, int mask);
> +void ad1843_setup_dac(ad1843_t *ad1843,
> +                      unsigned int id,
> +                      unsigned int framerate,
> +                      snd_pcm_format_t fmt,
> +                      unsigned int channels);
> +void ad1843_shutdown_dac(ad1843_t *ad1843,
> +                         unsigned int id);
> +void ad1843_setup_adc(ad1843_t *ad1843,
> +                      unsigned int framerate,
> +                      snd_pcm_format_t fmt,
> +                      unsigned int channels);
> +void ad1843_shutdown_adc(ad1843_t *ad1843);
> +int ad1843_init(ad1843_t *ad1843);
> +char *ad1843_dump_reg(ad1843_t *ad1843, int reg);
> +
> +#endif /* __SOUND_AD1843_H */
> --- linux-2.6.21.6-b/sound/mips/ad1843.c	1970-01-01 01:00:00.000000000
> +0100
> +++ linux-2.6.21.6/sound/mips/ad1843.c	2007-07-09 20:09:15.000000000 +0100
> @@ -0,0 +1,911 @@
> +/*
> + *   AD1843 low level driver
> + *
> + *   Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
> + *
> + *   inspired from vwsnd.c (SGI VW audio driver)
> + *     Copyright 1999 Silicon Graphics, Inc.  All rights reserved.
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program; if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> USA
> + *
> + */
> +
> +
> +#include <linux/slab.h>
> +
> +#include <linux/init.h>
> +#include <linux/jiffies.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/vmalloc.h>
> +#include <sound/driver.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/ad1843.h>
> +
> +// find and remove any OSS stuff
> +#include <linux/soundcard.h>
> +
> +/*
> + * AD1843 bitfield definitions.  All are named as in the AD1843 data
> + * sheet, with ad1843_ prepended and individual bit numbers removed.
> + *
> + * E.g., bits LSS0 through LSS2 become ad1843_LSS.
> + *
> + * Only the bitfields we need are defined.
> + */
> +
> +typedef struct ad1843_bitfield {
> +       char reg;
> +       char lo_bit;
> +       char nbits;
> +} ad1843_bitfield_t;
> +
> +static const ad1843_bitfield_t
> +	ad1843_PDNO   = {  0, 14,  1 }, /* Converter Power-Down Flag */
> +	ad1843_INIT   = {  0, 15,  1 }, /* Clock Initialization Flag */
> +	ad1843_RIG    = {  2,  0,  4 }, /* Right ADC Input Gain */
> +	ad1843_RMGE   = {  2,  4,  1 }, /* Right ADC Mic Gain Enable */
> +	ad1843_RSS    = {  2,  5,  3 }, /* Right ADC Source Select */
> +	ad1843_LIG    = {  2,  8,  4 }, /* Left ADC Input Gain */
> +	ad1843_LMGE   = {  2, 12,  1 }, /* Left ADC Mic Gain Enable */
> +	ad1843_LSS    = {  2, 13,  3 }, /* Left ADC Source Select */
> +	ad1843_RX1M   = {  4,  0,  5 }, /* Right Aux 1 Mix Gain/Atten */
> +	ad1843_RX1MM  = {  4,  7,  1 }, /* Right Aux 1 Mix Mute */
> +	ad1843_LX1M   = {  4,  8,  5 }, /* Left Aux 1 Mix Gain/Atten */
> +	ad1843_LX1MM  = {  4, 15,  1 }, /* Left Aux 1 Mix Mute */
> +	ad1843_RX2M   = {  5,  0,  5 }, /* Right Aux 2 Mix Gain/Atten */
> +	ad1843_RX2MM  = {  5,  7,  1 }, /* Right Aux 2 Mix Mute */
> +	ad1843_LX2M   = {  5,  8,  5 }, /* Left Aux 2 Mix Gain/Atten */
> +	ad1843_LX2MM  = {  5, 15,  1 }, /* Left Aux 2 Mix Mute */
> +	ad1843_RMCM   = {  7,  0,  5 }, /* Right Mic Mix Gain/Atten */
> +	ad1843_RMCMM  = {  7,  7,  1 }, /* Right Mic Mix Mute */
> +	ad1843_LMCM   = {  7,  8,  5 }, /* Left Mic Mix Gain/Atten */
> +	ad1843_LMCMM  = {  7, 15,  1 }, /* Left Mic Mix Mute */
> +	ad1843_HPOS   = {  8,  4,  1 }, /* Headphone Output Voltage Swing */
> +	ad1843_HPOM   = {  8,  5,  1 }, /* Headphone Output Mute */
> +	ad1843_MPOM   = {  8,  6,  1 }, /* Mono Output Mute */
> +	ad1843_RDA1G  = {  9,  0,  6 }, /* Right DAC1 Analog/Digital Gain */
> +	ad1843_RDA1GM = {  9,  7,  1 }, /* Right DAC1 Analog Mute */
> +	ad1843_LDA1G  = {  9,  8,  6 }, /* Left DAC1 Analog/Digital Gain */
> +	ad1843_LDA1GM = {  9, 15,  1 }, /* Left DAC1 Analog Mute */
> +	ad1843_RDA2G  = { 10,  0,  6 }, /* Right DAC2 Analog/Digital Gain */
> +	ad1843_RDA2GM = { 10,  7,  1 }, /* Right DAC2 Analog Mute */
> +	ad1843_LDA2G  = { 10,  8,  6 }, /* Left DAC2 Analog/Digital Gain */
> +	ad1843_LDA2GM = { 10, 15,  1 }, /* Left DAC2 Analog Mute */
> +	ad1843_RDA1AM = { 11,  7,  1 }, /* Right DAC1 Digital Mute */
> +	ad1843_LDA1AM = { 11, 15,  1 }, /* Left DAC1 Digital Mute */
> +	ad1843_RDA2AM = { 12,  7,  1 }, /* Right DAC1 Digital Mute */
> +	ad1843_LDA2AM = { 12, 15,  1 }, /* Left DAC1 Digital Mute */
> +	ad1843_ADLC   = { 15,  0,  2 }, /* ADC Left Sample Rate Source */
> +	ad1843_ADRC   = { 15,  2,  2 }, /* ADC Right Sample Rate Source */
> +	ad1843_DA1C   = { 15,  8,  2 }, /* DAC1 Sample Rate Source */
> +	ad1843_DA2C   = { 15, 10,  2 }, /* DAC2 Sample Rate Source */
> +	ad1843_C1M    = { 16,  0,  8 }, /* Clock 1 Rate Modifier */
> +	ad1843_C1C128 = { 16, 10,  1 }, /* Clock 1 CONV1 Freq select */
> +	ad1843_C1C    = { 17,  0, 16 }, /* Clock 1 Sample Rate Select */
> +	ad1843_C2M    = { 19,  0,  8 }, /* Clock 2 Rate Modifier */
> +	ad1843_C2C    = { 20,  0, 16 }, /* Clock 2 Sample Rate Select */
> +	ad1843_C3M    = { 22,  0,  8 }, /* Clock 3 Rate Modifier */
> +	ad1843_C3C    = { 23,  0, 16 }, /* Clock 3 Sample Rate Select */
> +	ad1843_DAADL  = { 25,  4,  2 }, /* Digital ADC Left Source Select */
> +	ad1843_DAADR  = { 25,  6,  2 }, /* Digital ADC Right Source Select */
> +	ad1843_DRSFLT = { 25, 15,  1 }, /* Digital Reampler Filter Mode */
> +	ad1843_ADLF   = { 26,  0,  2 }, /* ADC Left Channel Data Format */
> +	ad1843_ADRF   = { 26,  2,  2 }, /* ADC Right Channel Data Format */
> +	ad1843_ADTLK  = { 26,  4,  1 }, /* ADC Transmit Lock Mode Select */
> +	ad1843_FRS    = { 26,  6,  1 }, /* Frame size select */
> +	ad1843_SCF    = { 26,  7,  1 }, /* SCLK Frequency Select */
> +	ad1843_DA1F   = { 26,  8,  2 }, /* DAC1 Data Format Select */
> +	ad1843_DA2F   = { 26, 10,  2 }, /* DAC2 Data Format Select */
> +	ad1843_DA1SM  = { 26, 14,  1 }, /* DAC1 Stereo/Mono Mode Select */
> +	ad1843_DA2SM  = { 26, 15,  1 }, /* DAC2 Stereo/Mono Mode Select */
> +	ad1843_ADLEN  = { 27,  0,  1 }, /* ADC Left Channel Enable */
> +	ad1843_ADREN  = { 27,  1,  1 }, /* ADC Right Channel Enable */
> +	ad1843_AAMEN  = { 27,  4,  1 }, /* Analog to Analog Mix Enable */
> +	ad1843_ANAEN  = { 27,  7,  1 }, /* Analog Channel Enable */
> +	ad1843_DA1EN  = { 27,  8,  1 }, /* DAC1 Enable */
> +	ad1843_DA2EN  = { 27,  9,  1 }, /* DAC2 Enable */
> +	ad1843_ENBT1  = { 28,  2,  1 }, /* BIT1 Pin Enable */
> +	ad1843_ENCV1  = { 28,  3,  1 }, /* CONV1 Pin Enable */
> +	ad1843_ENBT2  = { 28,  4,  1 }, /* BIT2 Pin Enable */
> +	ad1843_ENCV2  = { 28,  5,  1 }, /* CONV2 Pin Enable */
> +	ad1843_ENBT3  = { 28,  6,  1 }, /* BIT3 Pin Enable */
> +	ad1843_ENCV3  = { 28,  7,  1 }, /* CONV3 Pin Enable */
> +	ad1843_ENCLKO = { 28, 10,  1 }, /* ClockOut Pin Enable */
> +	ad1843_C1EN   = { 28, 11,  1 }, /* Clock Generator 1 Enable */
> +	ad1843_C2EN   = { 28, 12,  1 }, /* Clock Generator 2 Enable */
> +	ad1843_C3EN   = { 28, 13,  1 }, /* Clock Generator 3 Enable */
> +	ad1843_ACEN   = { 28, 14,  1 }, /* Autocalibration enable */
> +	ad1843_PDNI   = { 28, 15,  1 }; /* Converter Power Down */
> +
> +
> +/*
> + * The various registers of the AD1843 use three different formats for
> + * specifying gain.  The ad1843_gain structure parameterizes the
> + * formats.
> + */
> +
> +typedef struct ad1843_gain {
> +       int     negative;               /* nonzero if gain is negative. */
> +       const ad1843_bitfield_t *lfield;
> +       const ad1843_bitfield_t *rfield;
> +} ad1843_gain_t;
> +
> +const ad1843_gain_t ad1843_gain_RECLEV
> +                               = { 0, &ad1843_LIG,   &ad1843_RIG };
> +const ad1843_gain_t ad1843_gain_LINE
> +                               = { 1, &ad1843_LX1M,  &ad1843_RX1M };
> +const ad1843_gain_t ad1843_gain_CD
> +                               = { 1, &ad1843_LX2M,  &ad1843_RX2M };
> +const ad1843_gain_t ad1843_gain_MIC
> +                               = { 1, &ad1843_LMCM,  &ad1843_RMCM };
> +const ad1843_gain_t ad1843_gain_PCM_0
> +                               = { 1, &ad1843_LDA1G, &ad1843_RDA1G };
> +const ad1843_gain_t ad1843_gain_PCM_1
> +                               = { 1, &ad1843_LDA2G, &ad1843_RDA2G };
> +
> +const ad1843_gain_t *ad1843_gain[AD1843_GAIN_SIZE] = {
> +  &ad1843_gain_RECLEV,
> +  &ad1843_gain_LINE,
> +  &ad1843_gain_CD,
> +  &ad1843_gain_MIC,
> +  &ad1843_gain_PCM_0,
> +  &ad1843_gain_PCM_1,
> +};
> +
> +/* read the current value of an AD1843 bitfield. */
> +
> +static int ad1843_read_bits(ad1843_t *ad1843, const ad1843_bitfield_t
> *field)
> +{
> +       int w = ad1843->read(ad1843->chip, field->reg);
> +       int val = w >> field->lo_bit & ((1 << field->nbits) - 1);
> +
> +       return val;
> +}
> +
> +/*
> + * write a new value to an AD1843 bitfield and return the old value.
> + */
> +
> +static int ad1843_write_bits(ad1843_t *ad1843,
> +                            const ad1843_bitfield_t *field,
> +                            int newval)
> +{
> +       int w = ad1843->read(ad1843->chip, field->reg);
> +       int mask = ((1 << field->nbits) - 1) << field->lo_bit;
> +       int oldval = (w & mask) >> field->lo_bit;
> +       int newbits = (newval << field->lo_bit) & mask;
> +       w = (w & ~mask) | newbits;
> +       (void) ad1843->write(ad1843->chip, field->reg, w);
> +
> +       return oldval;
> +}
> +
> +/*
> + * ad1843_read_multi reads multiple bitfields from the same AD1843
> + * register.  It uses a single read cycle to do it.  (Reading the
> + * ad1843 requires 256 bit times at 12.288 MHz, or nearly 20
> + * microseconds.)
> + *
> + * Called like this.
> + *
> + *  ad1843_read_multi(ad1843, nfields,
> + *                   &ad1843_FIELD1, &val1,
> + *                   &ad1843_FIELD2, &val2, ...);
> + */
> +
> +static void ad1843_read_multi(ad1843_t *ad1843, int argcount, ...)
> +{
> +       va_list ap;
> +       const ad1843_bitfield_t *fp;
> +       int w = 0, mask, *value, reg = -1;
> +
> +       va_start(ap, argcount);
> +       while (--argcount >= 0) {
> +               fp = va_arg(ap, const ad1843_bitfield_t *);
> +               value = va_arg(ap, int *);
> +
> +               if (reg == -1) {
> +                       reg = fp->reg;
> +                       w = ad1843->read(ad1843->chip, reg);
> +               }
> +
> +               mask = (1 << fp->nbits) - 1;
> +               *value = w >> fp->lo_bit & mask;
> +       }
> +       va_end(ap);
> +
> +}
> +
> +/*
> + * ad1843_write_multi stores multiple bitfields into the same AD1843
> + * register.  It uses one read and one write cycle to do it.
> + *
> + * Called like this.
> + *
> + *  ad1843_write_multi(ad1843, nfields,
> + *                    &ad1843_FIELD1, val1,
> + *                    &ad1843_FIELF2, val2, ...);
> + */
> +
> +static void ad1843_write_multi(ad1843_t *ad1843, int argcount, ...)
> +{
> +       va_list ap;
> +       int reg;
> +       const ad1843_bitfield_t *fp;
> +       int value;
> +       int w, m, mask, bits;
> +
> +       mask = 0;
> +       bits = 0;
> +       reg = -1;
> +
> +       va_start(ap, argcount);
> +       while (--argcount >= 0) {
> +               fp = va_arg(ap, const ad1843_bitfield_t *);
> +               value = va_arg(ap, int);
> +               if (reg == -1)
> +                       reg = fp->reg;
> +
> +               m = ((1 << fp->nbits) - 1) << fp->lo_bit;
> +               mask |= m;
> +               bits |= (value << fp->lo_bit) & m;
> +       }
> +       va_end(ap);
> +
> +       if (~mask & 0xFFFF)
> +               w = ad1843->read(ad1843->chip, reg);
> +       else
> +               w = 0;
> +       w = (w & ~mask) | bits;
> +       (void) ad1843->write(ad1843->chip, reg, w);
> +}
> +
> +/*
> + * ad1843_get_gain reads the specified register and extracts the gain
> value
> + * using the supplied gain type.  It returns the gain in OSS format.
> + */
> +
> +int ad1843_get_gain(ad1843_t *ad1843, int id)
> +{
> +       int lg, rg;
> +        const ad1843_gain_t *gp = ad1843_gain[id];
> +       unsigned short mask = (1 << gp->lfield->nbits) - 1;
> +
> +       ad1843_read_multi(ad1843, 2, gp->lfield, &lg, gp->rfield, &rg);
> +       if (gp->negative) {
> +               lg = mask - lg;
> +               rg = mask - rg;
> +       }
> +       lg = (lg * 100 + (mask >> 1)) / mask;
> +       rg = (rg * 100 + (mask >> 1)) / mask;
> +       return lg << 0 | rg << 8;
> +}
> +
> +/*
> + * Set an audio channel's gain. Converts from OSS format to AD1843's
> + * format.
> + *
> + * Returns the new gain, which may be lower than the old gain.
> + */
> +
> +int ad1843_set_gain(ad1843_t *ad1843,
> +                    int id,
> +                    int newval)
> +{
> +        const ad1843_gain_t *gp = ad1843_gain[id];
> +       unsigned short mask = (1 << gp->lfield->nbits) - 1;
> +
> +       int lg = newval >> 0 & 0xFF;
> +       int rg = newval >> 8;
> +       if (lg < 0 || lg > 100 || rg < 0 || rg > 100)
> +               return -EINVAL;
> +       lg = (lg * mask + (mask >> 1)) / 100;
> +       rg = (rg * mask + (mask >> 1)) / 100;
> +       if (gp->negative) {
> +               lg = mask - lg;
> +               rg = mask - rg;
> +       }
> +       ad1843_write_multi(ad1843, 2, gp->lfield, lg, gp->rfield, rg);
> +       return ad1843_get_gain(ad1843, id);
> +}
> +
> +/* Returns the current recording source, in OSS format. */
> +
> +int ad1843_get_recsrc(ad1843_t *ad1843)
> +{
> +       int ls = ad1843_read_bits(ad1843, &ad1843_LSS);
> +
> +       switch (ls) {
> +       case 1:
> +               return SOUND_MASK_MIC;
> +       case 2:
> +               return SOUND_MASK_LINE;
> +       case 3:
> +               return SOUND_MASK_CD;
> +       case 6:
> +               return SOUND_MASK_PCM;
> +       default:
> +               return -1;
> +       }
> +}
> +
> +/*
> + * Enable/disable digital resample mode in the AD1843.
> + *
> + * The AD1843 requires that ADL, ADR, DA1 and DA2 be powered down
> + * while switching modes.  So we save DA's state, power them down,
> + * switch into/out of resample mode, power them up, and restore state.
> + *
> + * This will cause audible glitches if D/A or A/D is going on, so the
> + * driver disallows that (in mixer_write_ioctl()).
> + *
> + * The open question is, is this worth doing?  I'm leaving it in,
> + * because it's written, but...
> + */
> +
> +void ad1843_set_resample_mode(ad1843_t *ad1843, int onoff)
> +{
> +       /* Save DA's mute and gain (addr 9/10 is analog gain/attenuation)
> */
> +       int save_da1 = ad1843->read(ad1843->chip, 9);
> +       int save_da2 = ad1843->read(ad1843->chip, 10);
> +
> +       /* Power down A/D and D/A. */
> +       ad1843_write_multi(ad1843, 4,
> +                          &ad1843_DA1EN, 0,
> +                          &ad1843_DA2EN, 0,
> +                          &ad1843_ADLEN, 0,
> +                          &ad1843_ADREN, 0);
> +
> +       /* Switch mode */
> +       ad1843_write_bits(ad1843, &ad1843_DRSFLT, onoff);
> +
> +       /* Power up A/D and D/A. */
> +       ad1843_write_multi(ad1843, 3,
> +                          &ad1843_DA1EN, 1,
> +                          &ad1843_DA2EN, 1,
> +                          &ad1843_ADLEN, 1,
> +                          &ad1843_ADREN, 1);
> +
> +       /* Restore DA's mute and gain. */
> +       ad1843->write(ad1843->chip, 9, save_da1);
> +       ad1843->write(ad1843->chip, 10, save_da2);
> +}
> +
> +/*
> + * Set recording source.  Arg newsrc specifies an OSS channel mask.
> + *
> + * The complication is that when we switch into/out of loopback mode
> + * (i.e., src = SOUND_MASK_PCM), we change the AD1843 into/out of
> + * digital resampling mode.
> + *
> + * Returns newsrc on success, -errno on failure.
> + */
> +
> +int ad1843_set_recsrc(ad1843_t *ad1843, int newsrc)
> +{
> +       int bits;
> +       int oldbits;
> +
> +       switch (newsrc) {
> +       case SOUND_MASK_PCM:
> +               bits = 6;
> +               break;
> +
> +       case SOUND_MASK_MIC:
> +               bits = 1;
> +               break;
> +
> +       case SOUND_MASK_LINE:
> +               bits = 2;
> +               break;
> +
> +       case SOUND_MASK_CD:
> +               bits = 3;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +       oldbits = ad1843_read_bits(ad1843, &ad1843_LSS);
> +       if (newsrc == SOUND_MASK_PCM && oldbits != 6) {
> +
> +               ad1843_set_resample_mode(ad1843, 1);
> +               ad1843_write_multi(ad1843, 2,
> +                                  &ad1843_DAADL, 2,
> +                                  &ad1843_DAADR, 2);
> +       } else if (newsrc != SOUND_MASK_PCM && oldbits == 6) {
> +
> +               ad1843_set_resample_mode(ad1843, 0);
> +               ad1843_write_multi(ad1843, 2,
> +                                  &ad1843_DAADL, 0,
> +                                  &ad1843_DAADR, 0);
> +       }
> +       ad1843_write_multi(ad1843, 2, &ad1843_LSS, bits, &ad1843_RSS,
> bits);
> +       return newsrc;
> +}
> +
> +/*
> + * Return current output sources, in OSS format.
> + */
> +
> +int ad1843_get_outsrc(ad1843_t *ad1843)
> +{
> +       int pcm, line, mic, cd;
> +
> +       pcm  = ad1843_read_bits(ad1843, &ad1843_LDA1GM) ? 0 :
> SOUND_MASK_PCM;
> +       line = ad1843_read_bits(ad1843, &ad1843_LX1MM)  ? 0 :
> SOUND_MASK_LINE;
> +       cd   = ad1843_read_bits(ad1843, &ad1843_LX2MM)  ? 0 :
> SOUND_MASK_CD;
> +       mic  = ad1843_read_bits(ad1843, &ad1843_LMCMM)  ? 0 :
> SOUND_MASK_MIC;
> +
> +       return pcm | line | cd | mic;
> +}
> +
> +/*
> + * Set output sources.  Arg is a mask of active sources in OSS format.
> + *
> + * Returns source mask on success, -errno on failure.
> + */
> +
> +int ad1843_set_outsrc(ad1843_t *ad1843, int mask)
> +{
> +       int pcm, line, mic, cd;
> +
> +       if (mask & ~(SOUND_MASK_PCM | SOUND_MASK_LINE |
> +                    SOUND_MASK_CD | SOUND_MASK_MIC))
> +               return -EINVAL;
> +       pcm  = (mask & SOUND_MASK_PCM)  ? 0 : 1;
> +       line = (mask & SOUND_MASK_LINE) ? 0 : 1;
> +       mic  = (mask & SOUND_MASK_MIC)  ? 0 : 1;
> +       cd   = (mask & SOUND_MASK_CD)   ? 0 : 1;
> +
> +       ad1843_write_multi(ad1843, 2, &ad1843_LDA1GM, pcm, &ad1843_RDA1GM,
> pcm);
> +       ad1843_write_multi(ad1843, 2, &ad1843_LX1MM, line, &ad1843_RX1MM,
> line);
> +       ad1843_write_multi(ad1843, 2, &ad1843_LX2MM, cd,   &ad1843_RX2MM,
> cd);
> +       ad1843_write_multi(ad1843, 2, &ad1843_LMCMM, mic,  &ad1843_RMCMM,
> mic);
> +
> +       return mask;
> +}
> +
> +/* Setup ad1843 for D/A conversion. */
> +
> +void ad1843_setup_dac(ad1843_t *ad1843,
> +                      unsigned int id,
> +                      unsigned int framerate,
> +                      snd_pcm_format_t fmt,
> +                      unsigned int channels)
> +{
> +       int ad_fmt = 1, ad_mode = 0;
> +
> +       switch (fmt) {
> +       case SNDRV_PCM_FORMAT_S8:       ad_fmt = 0; break;
> +       case SNDRV_PCM_FORMAT_U8:       ad_fmt = 0; break;
> +       case SNDRV_PCM_FORMAT_S16_BE:   ad_fmt = 1; break;
> +       case SNDRV_PCM_FORMAT_S24_BE:   ad_fmt = 1; break;
> +       case SNDRV_PCM_FORMAT_MU_LAW:   ad_fmt = 2; break;
> +       case SNDRV_PCM_FORMAT_A_LAW:    ad_fmt = 3; break;
> +       default: printk("errk!\n"); break;
> +       }
> +
> +       switch (channels) {
> +       case 2:                 ad_mode = 0; break;
> +       case 1:                 ad_mode = 1; break;
> +       default: printk("errk!\n"); break;
> +       }
> +
> +        if(1 == id) {
> +		ad1843_write_bits(ad1843, &ad1843_C1C, framerate);
> +		//ad1843_write_bits(ad1843, &ad1843_C1M, 0x00);
> +		//ad1843_write_bits(ad1843, &ad1843_C1C128, 1);
> +		//ad1843_write_bits(ad1843, &ad1843_FRS, 0);
> +		ad1843_write_multi(ad1843, 2,
> +			&ad1843_DA1SM, ad_mode,
> +			&ad1843_DA1F, ad_fmt);
> +		//ad1843_write_bits(ad1843, &ad1843_DA1EN, 1);
> +
> +        } else {
> +		ad1843_write_bits(ad1843, &ad1843_C3C, framerate);
> +		ad1843_write_multi(ad1843, 2,
> +			&ad1843_DA2SM, ad_mode,
> +			&ad1843_DA2F, ad_fmt);
> +		//ad1843_write_bits(ad1843, &ad1843_DA2EN, 1);
> +       }
> +
> +/*FIXME Debugging, will remove */
> +ad1843_write_bits(ad1843, &ad1843_C1C, framerate);
> +ad1843_write_bits(ad1843, &ad1843_C2C, framerate);
> +ad1843_write_bits(ad1843, &ad1843_C3C, framerate);
> +//ad1843_write_bits(ad1843, &ad1843_C1M, 0x00);
> +//ad1843_write_bits(ad1843, &ad1843_C2M, 0x00);
> +//ad1843_write_bits(ad1843, &ad1843_C3M, 0x00);
> +
> +}
> +
> +void ad1843_shutdown_dac(ad1843_t *ad1843, unsigned int id)
> +{
> +       if(id)
> +               ad1843_write_bits(ad1843, &ad1843_DA2F, 1);
> +        else
> +               ad1843_write_bits(ad1843, &ad1843_DA1F, 1);
> +}
> +
> +void ad1843_setup_adc(ad1843_t *ad1843,
> +                      unsigned int framerate,
> +                      snd_pcm_format_t fmt,
> +                      unsigned int channels)
> +{
> +       int da_fmt = 0;
> +
> +       switch (fmt) {
> +       case SNDRV_PCM_FORMAT_S8:       da_fmt = 0; break;
> +       case SNDRV_PCM_FORMAT_U8:       da_fmt = 0; break;
> +       case SNDRV_PCM_FORMAT_S16_BE:   da_fmt = 1; break;
> +       case SNDRV_PCM_FORMAT_MU_LAW:   da_fmt = 2; break;
> +       case SNDRV_PCM_FORMAT_A_LAW:    da_fmt = 3; break;
> +       default: printk("errk!\n"); break;
> +       }
> +
> +       ad1843_write_bits(ad1843, &ad1843_C3C, framerate);
> +       ad1843_write_multi(ad1843, 2,
> +                          &ad1843_ADLF, da_fmt, &ad1843_ADRF, da_fmt);
> +}
> +
> +void ad1843_shutdown_adc(ad1843_t *ad1843)
> +{
> +       /* nothing to do */
> +}
> +
> +/*
> + * Fully initialize the ad1843.  As described in the AD1843 data
> + * sheet, section "START-UP SEQUENCE".  The numbered comments are
> + * subsection headings from the data sheet.  See the data sheet, pages
> + * 52-54, for more info.
> + *
> + * return 0 on success, -errno on failure.  */
> +
> +int ad1843_init(ad1843_t *ad1843)
> +{
> +       unsigned long later;
> +
> +	/* 1. Power up in hardware */
> +
> +	/* 2. Assert ^RESET^ to 0, wait 100ns
> +	 * 3. Deassert ^RESET^ _400 to 800us, poll INIT to see when ready
> +	 * Done in calling driver */
> +	udelay(800);
> +
> +	/* 3. Check that the clocks are stable */
> +	if (ad1843_read_bits(ad1843, &ad1843_INIT) != 0) {
> +		printk(KERN_ERR "ad1843: AD1843 Clocks not yet stable\n");
> +		return -EIO;
> +	}
> +
> +	/*set serial bus speed */
> +	ad1843_write_bits(ad1843, &ad1843_SCF, 0);
> +
> +	/* Power down conv resources */
> +	/*ad1843_write_bits(ad1843, &ad1843_PDNI, 1);
> +	udelay(800);*/
> +
> +	/* 4. Put the conversion resources into standby PDNI to 0
> +	 * Force Enable auto calibrate ACEN to 1 */
> +	ad1843_write_multi(ad1843, 2,
> +		&ad1843_PDNI, 0, &ad1843_ACEN, 1);
> +	later = jiffies + HZ / 2;  /* roughly half a second */
> +
> +	/* 5. While in standby
> +	 * Power up the clock generators and enable clock output pins. */
> +	ad1843_write_multi(ad1843, 10, &ad1843_ENCLKO, 1,
> +		&ad1843_C1EN, 1, &ad1843_ENCV1, 1, &ad1843_ENBT1, 1,
> +		&ad1843_C2EN, 1, &ad1843_ENCV2, 1, &ad1843_ENBT2, 1,
> +		&ad1843_C3EN, 1, &ad1843_ENCV3, 1, &ad1843_ENBT3, 1);
> +
> +	/* 6. Configure conversion resources while they are in standby. */
> +
> +
> +
> +	/* Did we come out of standby ? */
> +	while (ad1843_read_bits(ad1843, &ad1843_PDNO)) {
> +		if (time_after(jiffies, later)) {
> +			printk(KERN_ERR "ad1843: AD1843 won't power up\n");
> +                       return -EIO;
> +		}
> +		schedule();
> +	}
> +
> +
> +	/* DAC1 = Clock1, ADC = Clock2, DAC2 = Clock3  Always.
> +	 * Based an ad1843 state from startup jingle */
> +	ad1843_write_multi(ad1843, 4,
> +		&ad1843_DA1C, 1, &ad1843_DA2C, 3,
> +		&ad1843_ADLC, 2, &ad1843_ADRC, 2);
> +
> +	/* 7. Enable conversion resources. */
> +	ad1843_write_bits(ad1843, &ad1843_ADTLK, 1);
> +	ad1843_write_multi(ad1843, 6,
> +		&ad1843_ANAEN, 1, &ad1843_AAMEN, 1,
> +		&ad1843_DA1EN, 1, &ad1843_DA2EN, 1,
> +		&ad1843_ADLEN, 1, &ad1843_ADREN, 1);
> +
> +       /* 8. Configure conversion resources while they are enabled. */
> +
> +
> +       /* Unmute all channels. */
> +
> +       ad1843_set_outsrc(ad1843,
> +                         (SOUND_MASK_PCM | SOUND_MASK_LINE |
> +                          SOUND_MASK_MIC | SOUND_MASK_CD));
> +       ad1843_write_multi(ad1843, 2,
> +		&ad1843_LDA1AM, 0, &ad1843_RDA1AM, 0);
> +
> +	ad1843_write_multi(ad1843, 2,
> +		&ad1843_LDA2AM, 0, &ad1843_RDA2AM, 0);
> +
> +	ad1843_write_multi(ad1843, 2,
> +		&ad1843_LDA1GM, 0, &ad1843_RDA1GM, 0);
> +
> +       /* Set default recording source to Line In and set
> +        * mic gain to +20 dB.
> +        */
> +       ad1843_set_recsrc(ad1843, SOUND_MASK_LINE);
> +       ad1843_write_multi(ad1843, 2, &ad1843_LMGE, 1, &ad1843_RMGE, 1);
> +
> +       /* Set Speaker Out level to +/- 4V and unmute it. */
> +       ad1843_write_multi(ad1843, 3,
> +                           &ad1843_HPOS, 1,
> +                           &ad1843_HPOM, 0,
> +                           &ad1843_MPOM, 0);
> +
> +       return 0;
> +}
> +
> +char *ad1843_dump_reg(ad1843_t *ad1843, int reg)
> +{
> +	static const char *reg_fmt[32] = {
> +		"Reg  0: Codec Status and Revision Identification\n"
> +		"|INIT   %u |PDNO   %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|ID3    %u ,ID2    %u ,ID1    %u ,ID0    %u | (%u)\n",
> +		/*reg 1*/
> +		"Reg  1: Channel Status Flags\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |SU2    %u |SU1    %u | (%u)\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|OVR1   %u ,OVR0   %u |OVL1   %u ,OVL0   %u | (%u)\n",
> +		/*reg 2*/
> +		"Reg  2: Input Control - ADC Source and Gain/Attenuation\n"
> +		"|LSS2   %u ,LSS1   %u ,LSS0   %u |LMGE   %u "
> +		"|LIG3   %u ,LIG2   %u ,LIG1   %u ,LIG0   %u | (%u)\n"
> +		"|RSS2   %u ,RSS1   %u ,RSS0   %u |RMGE   %u "
> +		"|RIG3   %u ,RIG2   %u ,RIG1   %u ,RIG0   %u | (%u)\n",
> +		/*reg 3*/
> +		"Reg  3: Mix Control - DAC2 to Mixer\n"
> +		"|LD2MM  %u |RES    %u |RES    %u |LD2M4  %u "
> +		",LD2M3  %u ,LD2M2  %u ,LD2M1  %u ,LD2M0  %u | (%u)\n"
> +		"|RD2MM  %u |RES    %u |RES    %u |RD2M4  %u "
> +		",RD2M3  %u ,RD2M2  %u ,RD2M1  %u ,RD2M0  %u | (%u)\n",
> +		/*reg 4*/
> +		"Reg  4: Auxiliary 1 to DAC1\n"
> +		"|LX1MM  %u |RES    %u |RES    %u |LX1M4  %u "
> +		",LX1M3  %u ,LX1M2  %u ,LX1M1  %u ,LX1M0  %u | (%u)\n"
> +		"|RX1MM  %u |RES    %u |RES    %u |RX1M4  %u "
> +		",RX1M3  %u ,RX1M2  %u ,RX1M1  %u ,RX1M0  %u | (%u)\n",
> +		/*reg 5 */
> +		"Reg  5: Mix Control - Auxiliary 2 to Mixer\n"
> +		"|LX2MM  %u |RES    %u |RES    %u |LX2M4  %u "
> +		",LX2M3  %u ,LX2M2  %u ,LX2M1  %u ,LX2M0  %u | (%u)\n"
> +		"|RX2MM  %u |RES    %u |RES    %u |RX2M4  %u "
> +		",RX2M3  %u ,RX2M2  %u ,RX2M1  %u ,RX2M0  %u | (%u)\n",
> +		/*reg 6*/
> +		"Reg  6: Mix Control - Auxiliary 3 to Mixer\n"
> +		"|LX3MM  %u |RES    %u |RES    %u |LX3M4  %u "
> +		",LX3M3  %u ,LX3M2  %u ,LX3M1  %u ,LX3M0  %u | (%u)\n"
> +		"|RX3MM  %u |RES    %u |RES    %u |RX3M4  %u "
> +		",RX3M3  %u ,RX3M2  %u ,RX3M1  %u ,RX3M0  %u | (%u)\n",
> +		/*reg 7*/
> +		"Reg  7: Mix Control - Mic to Mixer\n"
> +		"|LMCMM  %u |RES    %u |RES    %u |LMCM4  %u "
> +		",LMCM3  %u ,LMCM2  %u ,LMCM1  %u ,LMCM0  %u | (%u)\n"
> +		"|RMCMM  %u |RES    %u |RES    %u |RMCM4  %u "
> +		",RMCM3  %u ,RMCM2  %u ,RMCM1  %u ,RMCM0  %u | (%u)\n",
> +		/*reg 8*/
> +		"Reg  8: Mix/Misc Control - "
> +			"Mono In to Mixer and Misc Settings\n"
> +		"|MNMM   %u |RES    %u |RES    %u |MNM4   %u "
> +		",MNM3   %u ,MNM2   %u ,MNM1   %u ,MNM0   %u | (%u)\n"
> +		"|ALLMM  %u |MNOM   %u |HPOM   %u |HPOS   %u "
> +		"|SUMM   %u |RES    %u |DAC2T  %u |DAC1T  %u | (%u)\n",
> +		/*reg 9*/
> +		"Reg  9: Output Control - DAC1 Analog Gain/Attenuation\n"
> +		"|LDA1GM %u |RES    %u |LDA1G5 %u ,LDA1G4 %u "
> +		",LDA1G3 %u ,LDA1G2 %u ,LDA1G1 %u ,LDA1G0 %u | (%u)\n"
> +		"|RDA1GM %u |RES    %u |RDA1G5 %u ,RDA1G4 %u "
> +		",RDA1G3 %u ,RDA1G2 %u ,RDA1G1 %u ,RDA1G0 %u | (%u)\n",
> +		/*reg 10*/
> +		"Reg 10: Output Control - DAC2 Analog Gain/Attenuation\n"
> +		"|LDA2GM %u |RES    %u |LDA2G5 %u ,LDA2G4 %u "
> +		",LDA2G3 %u ,LDA2G2 %u ,LDA2G1 %u ,LDA2G0 %u | (%u)\n"
> +		"|RDA2GM %u |RES    %u |RDA2G5 %u ,RDA2G4 %u "
> +		",RDA2G3 %u ,RDA2G2 %u ,RDA2G1 %u ,RDA2G0 %u | (%u)\n",
> +		/*reg 11*/
> +		"Reg 11: Output Control - DAC1 Digital Attenuation\n"
> +		"|LDA1AM %u |RES    %u |LDA1A5 %u ,LDA1A4 %u "
> +		",LDA1A3 %u ,LDA1A2 %u ,LDA1A1 %u ,LDA1A0 %u | (%u)\n"
> +		"|RDA1AM %u |RES    %u |RDA1A5 %u ,RDA1A4 %u "
> +		",RDA1A3 %u ,RDA1A2 %u ,RDA1A1 %u ,RDA1A0 %u | (%u)\n",
> +		/*reg 12*/
> +		"Reg 12: Output Control - DAC2 Digital Attenuation\n"
> +		"|LDA2AM %u |RES    %u |LDA2A5 %u ,LDA2A4 %u "
> +		",LDA2A3 %u ,LDA2A2 %u ,LDA2A1 %u ,LDA2A0 %u | (%u)\n"
> +		"|RDA2AM %u |RES    %u |RDA2A5 %u ,RDA2A4 %u "
> +		",RDA2A3 %u ,RDA2A2 %u ,RDA2A1 %u ,RDA2A0 %u | (%u)\n",
> +		/*reg 13*/
> +		"Reg 13: Digital Mix Control - ADC to DAC1\n"
> +		"|LAD1MM %u |RES    %u |LAD1M5 %u ,LAD1M4 %u "
> +		",LAD1M3 %u ,LAD1M2 %u ,LAD1M1 %u ,LAD1M0 %u | (%u)\n"
> +		"|RAD1MM %u |RES    %u |RAD1M5 %u ,RAD1M4 %u "
> +		",RAD1M3 %u ,RAD1M2 %u ,RAD1M1 %u ,RAD1M0 %u | (%u)\n",
> +		/*reg 14*/
> +		"Reg 14: Digital Mix Control - ADC to DAC2\n"
> +		"|LAD2MM %u |RES    %u |LAD2M5 %u ,LAD2M4 %u "
> +		",LAD2M3 %u ,LAD2M2 %u ,LAD2M1 %u ,LAD2M0 %u | (%u)\n"
> +		"|RAD2MM %u |RES    %u |RAD2M5 %u ,RAD2M4 %u "
> +		",RAD2M3 %u ,RAD2M2 %u ,RAD2M1 %u ,RAD2M0 %u | (%u)\n",
> +		/*reg 15*/
> +		"Reg 15: Codec Configuration - "
> +			"Channel Sample Rate Source Select\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|DA2C1  %u ,DA2C0  %u |DA1C1  %u ,DA1C0  %u | (%u)\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|ADRC1  %u ,ADRC0  %u |ADLC1  %u ,ADLC0  %u | (%u)\n",
> +		/*reg 16*/
> +		"Reg 16: Clock Generator 1 Control - Mode\n"
> +		"|C1REF  %u |C1VID  %u |C1PLLG %u |C1P200 %u "
> +		"|C1X8/7 %u |C1C128 %u |RES    %u |RES    %u | (%u)\n"
> +		"|C1M7   %u ,C1M6   %u ,C1M5   %u ,C1M4   %u "
> +		",C1M3   %u ,C1M2   %u ,C1M1   %u ,C1M0   %u | (%u)\n",
> +		/*reg 17*/
> +		"Reg 17: Clock Generator 1 Control - Sample Rate\n"
> +		"|C1C15  %u ,C1C14  %u ,C1C13  %u ,C2C12  %u "
> +		",C1C11  %u ,C1C10  %u ,C1C9   %u ,C1C8   %u , (%u)\n"
> +		",C1C7   %u ,C1C6   %u ,C1C5   %u ,C1C4   %u "
> +		",C1C3   %u ,C1C2   %u ,C1C1   %u ,C1C0   %u | (%u)\n",
> +		/*reg 18*/
> +		"Reg 18: Clock Generator 1 Control - Sample Phase Shift\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |C1PD   %u | (%u)\n"
> +		"|C1P7   %u ,C1P6   %u ,C1P5   %u ,C1P4   %u "
> +		",C1P3   %u ,C1P2   %u ,C1P1   %u ,C1P0   %u | (%u)\n",
> +		/*reg 19*/
> +		"Reg 19: Clock Generator 2 Control - Mode\n"
> +		"|C2REF  %u |C2VID  %u |C2PLLG %u |C2P200 %u "
> +		"|C2X8/7 %u |C2C128 %u |RES    %u |RES    %u | (%u)\n"
> +		"|C2M7   %u ,C2M6   %u ,C2M5   %u ,C2M4   %u "
> +		",C2M3   %u ,C2M2   %u ,C2M1   %u ,C2M0   %u | (%u)\n",
> +		/*reg 20*/
> +		"Reg 20: Clock Generator 2 Control - Sample Rate\n"
> +		"|C2C15  %u ,C2C14  %u ,C2C13  %u ,C2C12  %u "
> +		",C2C11  %u ,C2C10  %u ,C2C9   %u ,C2C8   %u , (%u)\n"
> +		",C2C7   %u ,C2C6   %u ,C2C5   %u ,C2C4   %u "
> +		",C2C3   %u ,C2C2   %u ,C2C1   %u ,C2C0   %u | (%u)\n",
> +		/*reg 21*/
> +		"Reg 21: Clock Generator 2 Control - Sample Phase Shift\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |C2PD   %u | (%u)\n"
> +		"|C2P7   %u ,C2P6   %u ,C2P5   %u ,C2P4   %u "
> +		",C2P3   %u ,C2P2   %u ,C2P1   %u ,C2P0   %u | (%u)\n",
> +		/*reg 22*/
> +		"Reg 22: Clock Generator 3 Control - Mode\n"
> +		"|C3REF  %u |C3VID  %u |C3PLLG %u |C3P200 %u "
> +		"|C3X8/7 %u |C3C128 %u |RES    %u |RES    %u | (%u)\n"
> +		"|C3M7   %u ,C3M6   %u ,C3M5   %u ,C3M4   %u "
> +		",C3M3   %u ,C3M2   %u ,C3M1   %u ,C3M0   %u | (%u)\n",
> +		/*reg 23*/
> +		"Reg 23: Clock Generator 3 Control - Sample Rate\n"
> +		"|C3C15  %u ,C3C14  %u ,C3C13  %u ,C3C12  %u "
> +		",C3C11  %u ,C3C10  %u ,C3C9   %u ,C3C8   %u , (%u)\n"
> +		",C3C7   %u ,C3C6   %u ,C3C5   %u ,C3C4   %u "
> +		",C3C3   %u ,C3C2   %u ,C3C1   %u ,C3C0   %u | (%u)\n",
> +		/*reg 24*/
> +		"Reg 24: Clock Generator 3 Control - Sample Phase Shift\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |C3PD   %u | (%u)\n"
> +		"|C3P7   %u ,C3P6   %u ,C3P5   %u ,C3P4   %u "
> +		",C3P3   %u ,C3P2   %u ,C3P1   %u ,C3P0   %u | (%u)\n",
> +		/*reg 25*/
> +		"Reg 25: Codec Configuration - Digital Filter and Mode Select\n"
> +		"|DRSFLT %u |DAMIX  %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |DA2FLT %u |DA1FLT %u | (%u)\n"
> +		"|DAADR1 %u ,DAADR0 %u |DAADL1 %u ,DAADL0 %u "
> +		"|RES    %u |RES    %u |ADRFLT %u |ADLFLT %u | (%u)\n",
> +		/*reg 26*/
> +		"Reg 26: Codec Configuration - Serial Interface\n"
> +		"|DA2SM  %u |DA1SM  %u |RES    %u |RES    %u "
> +		"|DA2F1  %u ,DA2F0  %u |DA1F1  %u ,DA1F0  %u | (%u)\n"
> +		"|SCF    %u |FRS    %u |FRST   %u |ADTLK  %u "
> +		"|ADRF1  %u ,ADRF0  %u |ADLF1  %u ,ADLF0  %u | (%u)\n",
> +		/*reg 27*/
> +		"Reg 27: Codec Configuration - Channel Power Down\n"
> +		"|DFREE  %u |RES    %u |RES    %u |DDMEM  %u "
> +		"|RES    %u |RES    %u |DA2EN  %u |DA1EN  %u | (%u)\n"
> +		"|ANAEN  %u |HPEN   %u |RES    %u |AAMEN  %u "
> +		"|RES    %u |RES    %u |ADREN  %u |ADLEN  %u | (%u)\n",
> +		/*reg 28*/
> +		"Reg 28: Codec Configuration - Fundemental Settings\n"
> +		"|PDNI   %u |ACEN   %u |C3EN   %u |C2EN   %u "
> +		"|C1EN   %u |ENCLKO %u |XCTL1  %u |XCTL0  %u | (%u)\n"
> +		"|ENCV3  %u |ENBT3  %u |ENCV2  %u |ENBT2  %u "
> +		"|ENCV1  %u |ENBT1  %u |LINRSD %u |LINLSD %u | (%u)\n",
> +		/*reg 29*/
> +		"Reg 29: Reserved for Future Expansion\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n",
> +		/*reg 30*/
> +		"Reg 30: Reserved for Future Expansion\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n",
> +		/*reg 31*/
> +		"Reg 31: Reserved for Future Expansion\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n"
> +		"|RES    %u |RES    %u |RES    %u |RES    %u "
> +		"|RES    %u |RES    %u |RES    %u |RES    %u | (%u)\n",
> +		};
> +	unsigned int v1 = 0, v2 = 0;
> +	int w = ad1843->read(ad1843->chip, reg);
> +	char *str = vmalloc_user(255);
> +
> +	if (NULL==str) return NULL;
> +
> +	switch (reg) {
> +	case 0:
> +		v2 = w&0xF;
> +		break;
> +	case 2:
> +		v1 = (w>>8)&0xF; v2 = w&0xF;
> +		break;
> +	case 3: case 4: case 5: case 6: case 7:
> +		v1 = (w>>8)&0x1F; v2 = w&0x1F;
> +		break;
> +	case 8:
> +		v1 = (w>>8)&0x1F;
> +		break;
> +	case 9: case 10: case 11: case 12: case 13: case 14:
> +		v1 = (w>>8)&0x3F; v2 = w&0x3F;
> +		break;
> +	case 16: case 18: case 19: case 21: case 22: case 24:
> +		v2 = w&0xFF;
> +		break;
> +	case 17: case 20: case 23:
> +		v2 = w&0xFFFF;
> +		break;
> +
> +	}
> +
> +	snprintf(str, 255, reg_fmt[reg], (w>>15)&1,
> +		(w>>14)&1, (w>>13)&1, (w>>12)&1, (w>>11)&1, (w>>10)&1,
> +		(w>>9)&1,  (w>>8)&1, v1, (w>>7)&1,  (w>>6)&1,  (w>>5)&1,
> +		(w>>4)&1,  (w>>3)&1,  (w>>2)&1,  (w>>1)&1,  (w>>0)&1, v2);
> +
> +	return str;
> +}
>
> --- linux-2.6.21.6-b/sound/mips/mace_audio.c	1970-01-01 01:00:00.000000000
> +0100
> +++ linux-2.6.21.6/sound/mips/mace_audio.c	2007-07-09 20:29:50.000000000
> +0100
> @@ -0,0 +1,1347 @@
> +/*
> + *   Sound driver for Silicon Graphics O2 Workstations MACE audio board.
> + *
> + *   Copyright 2007 Thorben J�ndling <tj.trevelyan@gmail.com>
> + *   Based/Copied heavily on/from sgio2audio.c:
> + *   Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program; if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> USA
> + *
> + */
> +
> +/*
> + * Notes
> + *
> + * Mace take 24bit audio stored/transfered in 32 bits and converts
> + * it in hardware back to 16/8bit
> + *
> + * AD1843 spec says:
> + * "Data in all four formats is always transfered MSB first"
> + * To me that says big-endian
> + * So tell ALSA we only do SNDRV_PCM_FMTBIT_S24_BE
> + *
> + * Apparently RAD1 similar see IP30 patch set
> + *
> + * Why rewrite? Mostly so that I can understand the code, writing is
> + * better then reading for that purpose I find.
> + */
> +/* channel 0/ADC, 1/DAC1 -> pcm0
> + * channel 2/DAC2 -> pcm1
> + */
> +
> +/*************************** include ******************************/
> +
> +#include <sound/driver.h>
> +#include <linux/init.h>
> +#include <linux/wait.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/gfp.h>
> +#include <linux/vmalloc.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/list.h>
> +#include <linux/dma-mapping.h>
> +#include <asm/io.h>
> +
> +#include <asm/ip32/ip32_ints.h>
> +#include <asm/ip32/mace.h>
> +
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/control.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/info.h>
> +
> +#include <sound/ad1843.h>
> +
> +/**************************** defines *******************************/
> +
> +/* 1: reset audio interface */
> +#define SMA_CTRL_RESET          0x1UL
> +/* 1: codec detected */
> +#define SMA_CTRL_CODEC_PRESENT  0x2UL
> +/*  2-8  : channel 1 write ptr alias */
> +/*  9-15 : channel 2 read ptr alias */
> +/* 16-22 : channel 3 read ptr alias */
> +/* latched volume button */
> +#define SMA_CTRL_VOL_BUTTON_UP   BIT(24)
> +/* latched volume button */
> +#define SMA_CTRL_VOL_BUTTON_DOWN BIT(23)
> +
> +#define SMA_CODEC_READ(reg)  ((reg) <<17) | 0x00010000UL
> +#define SMA_CODEC_WRITE(reg, val) (((reg) <<17)|(val)) & 0x00FEFFFFUL
> +
> +#define SMA_RING_OFFSET(chi) ((chi) << 12)
> +#define SMA_RING_SIZE 0x1000
> +#define SMA_RING_MASK 0x0FFFUL
> +
> +/* int on buffer >50% full */
> +#define SMA_INT_THRESHOLD_50 (2 << 5)
> +/* 1: enable DMA transfer */
> +#define SMA_DMA_ENABLE   BIT(9)
> +
> +/*old, define still inherted from sgio2audio*/
> +
> +#define SMA_CTRL_CHAN_RESET BIT(10) /* 1: reset channel */
> +
> +#define SMA_INT_THRESHOLD_DISABLED  (0 << 5) /* interrupt disabled */
> +#define SMA_INT_THRESHOLD_25 (1 << 5) /* int on buffer >25% full */
> +#define SMA_INT_THRESHOLD_75 (3 << 5) /* int on buffer >75% full */
> +#define SMA_INT_THRESHOLD_EMPTY     (4 << 5) /* int on buffer empty */
> +#define SMA_INT_THRESHOLD_NOT_EMPTY (5 << 5) /* int on buffer !empty */
> +#define SMA_INT_THRESHOLD_FULL      (6 << 5) /* int on buffer empty */
> +#define SMA_INT_THRESHOLD_NOT_FULL  (7 << 5) /* int on buffer !empty */
> +
> +/****************************** structs/types ***********************/
> +
> +/* chip specific record */
> +typedef struct snd_mace_audio {
> +	struct snd_card *card;
> +	struct snd_pcm  *pcm[2];
> +
> +	struct {
> +		struct snd_pcm_substream *substream;
> +		snd_pcm_uframes_t        frames;
> +
> +		int                  ack;
> +		void                *buffer;
> +		u64                  pos;
> +		spinlock_t           lock;
> +	} channel[3];
> +
> +	/* which gain should the O2 vol butons control?*/
> +	unsigned int ext_vol_for;
> +
> +	struct snd_info_entry  *proc_debug,
> +	                  *proc_ad1843,
> +	                  *proc_mace;
> +
> +	ad1843_t   *ad1843;
> +	spinlock_t ad1843_lock;
> +
> +	void        *ring_base;
> +	dma_addr_t   ring_base_handle;
> +	unsigned long maceisa_base;
> +	unsigned int mace_offset;
> +
> +} snd_mace_audio_t;
> +
> +typedef struct sma_proc_debug {
> +	struct list_head link;
> +
> +/* name to display for the entry */
> +	char  *name;
> +
> +/* a string value */
> +	char  *val_str;
> +
> +/* an int val used if val_str is null */
> +	long val_int;
> +} sma_proc_debug_t;
> +
> +/************************** func declaration
> ****************************/
> +/* mace access */
> +static int mace_audio_reg_read(snd_mace_audio_t *chip, int reg);
> +static int mace_audio_reg_write(snd_mace_audio_t *chip, int reg, int
> word);
> +/* pcm */
> +static int sma_pcm_open(struct snd_pcm_substream *substream);
> +static int sma_pcm_close(struct snd_pcm_substream *substream);
> +static int sma_pcm_hwparam
> +	(struct snd_pcm_substream *substream, struct snd_pcm_hw_params
> *hw_params);
> +static int sma_pcm_hwfree(struct snd_pcm_substream *substream);
> +static int sma_pcm_prepare(struct snd_pcm_substream *substream);
> +static int sma_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
> +static snd_pcm_uframes_t sma_pcm_pointer
> +	(struct snd_pcm_substream *substream);
> +static struct page *sma_pcm_page
> +	(struct snd_pcm_substream *substream, unsigned long offset);
> +static int sma_pcm_ack(struct snd_pcm_substream *substream);
> +static int __devinit sma_pcm_new(snd_mace_audio_t *chip);
> +/* interrupt and DMA engine */
> +static int sma_dma_start(struct snd_pcm_substream *substream);
> +static int sma_dma_stop(struct snd_pcm_substream *substream);
> +static void sma_dma_ping(snd_mace_audio_t *chip, int chi);
> +static void sma_dma_refill(snd_mace_audio_t *chip, int chi);
> +static irqreturn_t sma_interrupt
> +	(int irq, snd_mace_audio_t *chip, struct pt_regs *regs);
> +static void sma_adjust_vol(snd_mace_audio_t *chip);
> +/* mixer and controls */
> +static int sma_gain_info
> +	(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
> +static int sma_gain_get
> +	(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
> +static int sma_gain_put
> +	(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
> +static int __devinit sma_control_new(snd_mace_audio_t *chip);
> +/* proc */
> +static void sma_proc_ad1843_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer);
> +static void sma_proc_mace_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer);
> +static void sma_proc_debug_read
> +	(struct snd_info_entry *, struct snd_info_buffer *);
> +static sma_proc_debug_t* sma_proc_debug_append(char *name);
> +static int sma_proc_create(snd_mace_audio_t *chip);
> +/* ALSA Setup */
> +static int sma_free(snd_mace_audio_t *chip);
> +static int __devinit sma_create
> +	(struct snd_card *card, snd_mace_audio_t **rchip);
> +static int __devinit sma_probe(void);
> +/* module setup */
> +static int __init snd_card_mace_audio_init(void);
> +static void __exit snd_card_mace_audio_exit(void);
> +
> +
> +/************************* define psudo-funcs
> ***************************/
> +#define sma_proc_entry_assert(entry,name) \
> +	if (NULL == entry) entry = sma_proc_entry_append(name);
> +
> +/* pcm0 substream0 = channel 1
> + * pcm0 substream1 = channel 0
> + * pcm1 substream0 = channel 2
> + */
> +#define substream_to_channel_index(substream) \
> +
> ((((snd_mace_audio_t*)(substream->private_data))->pcm[0]==substream->pcm)\
> + ?!(substream->number):2)
> +
> +/******************************** globals
> *******************************/
> +
> +/* using same for all */
> +static struct snd_pcm_hardware sma_pcm_hw[2] = {
> +	{ /* Direct */
> +	.info = (SNDRV_PCM_INFO_MMAP |
> +	         SNDRV_PCM_INFO_INTERLEAVED |
> +	         SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +	         SNDRV_PCM_INFO_MMAP_VALID),
> +	.formats =           SNDRV_PCM_FMTBIT_S24_BE,
> +	.rates =             SNDRV_PCM_RATE_8000_48000,
> +	.rate_min =          8000,
> +	.rate_max =          48000,
> +	.channels_min =      2,
> +	.channels_max =      2,
> +        .buffer_bytes_max =  4096,
> +	.period_bytes_min =  32,
> +	.period_bytes_max =  1024,
> +	.periods_min =       4,
> +	.periods_max =       128,
> +
> +	},{ /* inderct bounce buffer */
> +
> +	.info = (SNDRV_PCM_INFO_MMAP |
> +	         SNDRV_PCM_INFO_INTERLEAVED |
> +	         SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +	         SNDRV_PCM_INFO_MMAP_VALID),
> +	.formats =           SNDRV_PCM_FMTBIT_S24_BE,
> +	.rates =             SNDRV_PCM_RATE_8000_48000,
> +	.rate_min =          8000,
> +	.rate_max =          48000,
> +	.channels_min =      2,
> +	.channels_max =      2,
> +        .buffer_bytes_max =  32768,
> +	.period_bytes_min =  32,
> +	.period_bytes_max =  32768,
> +	.periods_min =       1,
> +	.periods_max =       1024,
> +	}
> +};
> +
> +/* pcm operators */
> +static struct snd_pcm_ops sma_pcm_ops[2] = {
> +	{ /* Direct */
> +	.open =       sma_pcm_open,
> +	.close =      sma_pcm_close,
> +	.ioctl =      snd_pcm_lib_ioctl,
> +	.hw_params =  sma_pcm_hwparam,
> +	.hw_free =    sma_pcm_hwfree,
> +	.prepare =    sma_pcm_prepare,
> +	.trigger =    sma_pcm_trigger,
> +	.pointer =    sma_pcm_pointer,
> +	.ack     =    sma_pcm_ack,
> +	.page    =    sma_pcm_page
> +
> +	},{ /* inderct bounce buffer */
> +	.open =       sma_pcm_open,
> +	.close =      sma_pcm_close,
> +	.ioctl =      snd_pcm_lib_ioctl,
> +	.hw_params =  sma_pcm_hwparam,
> +	.hw_free =    sma_pcm_hwfree,
> +	.prepare =    sma_pcm_prepare,
> +	.trigger =    sma_pcm_trigger,
> +	.pointer =    sma_pcm_pointer,
> +	.page    =    sma_pcm_page
> +
> +	}
> +};
> +
> +/* record level mixer control */
> +static struct snd_kcontrol_new sma_ctrl_reclevel __devinitdata = {
> +	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name           = "Capture Volume",
> +	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.private_value  = AD1843_GAIN_RECLEV,
> +	.info           = sma_gain_info,
> +	.get            = sma_gain_get,
> +	.put            = sma_gain_put,
> +};
> +
> +/* line mixer control */
> +static struct snd_kcontrol_new sma_ctrl_line __devinitdata = {
> +	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name           = "Line Volume",
> +	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.private_value  = AD1843_GAIN_LINE,
> +	.info           = sma_gain_info,
> +	.get            = sma_gain_get,
> +	.put            = sma_gain_put,
> +};
> +
> +/* cd mixer control */
> +static struct snd_kcontrol_new sma_ctrl_cd __devinitdata = {
> +	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name           = "CD Volume",
> +	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.private_value  = AD1843_GAIN_CD,
> +	.info           = sma_gain_info,
> +	.get            = sma_gain_get,
> +	.put            = sma_gain_put,
> +};
> +
> +/* mic mixer control */
> +static struct snd_kcontrol_new sma_ctrl_mic __devinitdata = {
> +	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name           = "Mic Volume",
> +	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.private_value  = AD1843_GAIN_MIC,
> +	.info           = sma_gain_info,
> +	.get            = sma_gain_get,
> +	.put            = sma_gain_put,
> +};
> +
> +/* dac1/pcm0 mixer control */
> +static struct snd_kcontrol_new sma_ctrl_pcm0 __devinitdata = {
> +	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name           = "Playback Volume",
> +	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.private_value  = AD1843_GAIN_PCM_0,
> +	.info           = sma_gain_info,
> +	.get            = sma_gain_get,
> +	.put            = sma_gain_put,
> +};
> +
> +/* dac2/pcm1 mixer control */
> +static struct snd_kcontrol_new sma_ctrl_pcm1 __devinitdata = {
> +	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name           = "Playback Aux-out Volume",
> +	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.private_value  = AD1843_GAIN_PCM_1,
> +	.info           = sma_gain_info,
> +	.get            = sma_gain_get,
> +	.put            = sma_gain_put,
> +};
> +
> +
> +LIST_HEAD(sma_proc_debug_list);
> +
> +static int   alsa_index = -1;
> +static char *alsa_id    = NULL;
> +static int   alsa_enable= 1;
> +static int   sma_indirect = 1;
> +
> +/* Global needed for module exit */
> +snd_mace_audio_t *snd_mace_audio_chip = NULL;
> +
> +/******************************* PCM
> ****************************************/
> +
> +/* temp debug func */
> +
> +static void print_pointers(const char *str)
> +{
> +	unsigned long rb, wp, rp, depth;
> +	int chi;
> +
> +	rb = readq(&mace->perif.ctrl.ringbase);
> +	snd_printk ("%s. ringbase=0x%lX,\n", str, rb);
> +
> +	for (chi=0; chi<3; chi++) {
> +
> +		wp = readq(&mace->perif.audio.chan[chi].write_ptr);
> +		rp = readq(&mace->perif.audio.chan[chi].read_ptr);
> +		depth = readq(&mace->perif.audio.chan[chi].depth);
> +
> +		snd_printk("\t%d[ writep=0x%lX (%lu), readp=0x%lX (%lu), "
> +			"depth=0x%lX (%lu) ]\n",
> +			chi, wp, wp, rp, rp, depth, depth);
> +	}
> +
> +}
> +
> +
> +/* play open callback */
> +static int sma_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	//snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int chi = substream_to_channel_index(substream);
> +snd_printd("in pcm open for channel %d\n", chi);
> +
> +	runtime->hw = sma_pcm_hw[sma_indirect];
> +
> +	return 0;
> +}
> +
> +/* play close callback */
> +static int sma_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	//snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	//FIXME code
> +snd_printd("in pcm close\n");
> +
> +	return 0;
> +}
> +
> +/* setup hw for pcm */
> +/* maybe called more then once */
> +static int sma_pcm_hwparam
> +	(struct snd_pcm_substream *substream, struct snd_pcm_hw_params
> *hw_params)
> +{
> +	snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	int chi = substream_to_channel_index(substream);
> +snd_printd("In hw param for channel %d\n", chi);
> +
> +	if (sma_indirect) {
> +
> +		if (NULL != substream->runtime->dma_area)
> +			vfree(substream->runtime->dma_area);
> +
> +		substream->runtime->dma_bytes =
> +			params_buffer_bytes(hw_params);
> +
> +		substream->runtime->dma_addr = 0;
> +
> +		substream->runtime->dma_area =
> +			vmalloc_user(substream->runtime->dma_bytes);
> +
> +	} else {
> +		substream->runtime->dma_bytes = SMA_RING_SIZE;
> +
> +		substream->runtime->dma_addr =
> +			(chip->ring_base_handle + SMA_RING_OFFSET(chi)
> +			/*+ chip->mace_offset*/);
> +			/*chip->maceisa_base + SMA_RING_OFFSET(chi);*/
> +		substream->runtime->dma_area =
> +			(chip->ring_base + SMA_RING_OFFSET(chi)
> +			/*+ chip->mace_offset~*/);
> +	}
> +
> +snd_printd("set alsa dma area=0x%lX (%lu) size=0x%lX (%lu)\n",
> +	(unsigned long) substream->runtime->dma_area,
> +	(unsigned long) substream->runtime->dma_area,
> +	(unsigned long) substream->runtime->dma_bytes,
> +	(unsigned long) substream->runtime->dma_bytes);
> +
> +	if (NULL == substream->runtime->dma_area) {
> +		snd_printk(KERN_ERR "DMA area not allocated!\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 1;
> +}
> +
> +/* free hw for pcm */
> +/* maybe called more then once */
> +static int sma_pcm_hwfree(struct snd_pcm_substream *substream)
> +{
> +	snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	int chi = substream_to_channel_index(substream);
> +snd_printd("In hw free for channel %d\n", chi);
> +
> +	if (sma_indirect && NULL != substream->runtime->dma_area) {
> +		vfree(substream->runtime->dma_area);
> +	}
> +
> +	substream->runtime->dma_bytes = 0;
> +	substream->runtime->dma_addr = 0;
> +	substream->runtime->dma_area = NULL;
> +	chip->channel[chi].buffer = NULL;
> +	chip->channel[chi].pos = 0;
> +	chip->channel[chi].ack = 0;
> +	chip->channel[chi].frames = 0;
> +
> +	return 1;
> +}
> +
> +/* prepare callback */
> +static int sma_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int chi = substream_to_channel_index(substream);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chip->channel[chi].lock, flags);
> +
> +	chip->channel[chi].pos = 0;
> +	chip->channel[chi].frames = 0;
> +	chip->channel[chi].ack = 0;
> +	chip->channel[chi].substream = substream;
> +
> +	if (0 == chi) { /* capture*/
> +snd_printd("in prepare capture for channel %d\n", chi);
> +
> +		ad1843_setup_adc(chip->ad1843,
> +			runtime->rate,
> +			SNDRV_PCM_FORMAT_S24_BE,
> +			runtime->channels);
> +	} else { /* playback */
> +snd_printd("in prepare playback for channel %d, rate %d, sub-channels
> %d\n",
> +	chi, runtime->rate, runtime->channels);
> +
> +		ad1843_setup_dac(chip->ad1843,
> +			chi,
> +			runtime->rate,
> +			SNDRV_PCM_FORMAT_S24_BE,
> +			runtime->channels);
> +	}
> +
> +	spin_unlock_irqrestore(&chip->channel[chi].lock, flags);
> +
> +	return 0;
> +}
> +
> +/* trigger callback */
> +static int sma_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +snd_printd("In pcm trigger\n");
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START: /* start PCM engine */
> +		sma_dma_start(substream);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP: /* stop PCM engine */
> +		sma_dma_stop(substream);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* pointer callback */
> +static snd_pcm_uframes_t sma_pcm_pointer
> +	(struct snd_pcm_substream *substream)
> +{
> +	snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	int chi = substream_to_channel_index(substream);
> +	unsigned long p;
> +
> +	if (sma_indirect) {
> +
> +		p = chip->channel[chi].pos;
> +
> +	} else {
> +
> +		p = readq(&mace->perif.audio.chan[chi].read_ptr);
> +
> +	}
> +
> +//snd_printd("returning pointer 0x%lX (%lu) for channel %d\n", p, p,
> chi);
> +
> +
> +	return  bytes_to_frames(substream->runtime, p);
> +}
> +
> +/* get page callback */
> +static struct page *sma_pcm_page
> +	(struct snd_pcm_substream *substream, unsigned long offset)
> +{
> +	struct page *p;
> +snd_printd("in page\n");
> +
> +	if (sma_indirect) {
> +		p = vmalloc_to_page((substream->runtime->dma_area + offset));
> +	} else {
> +		/*FIXME using CAC_AADR until a proper alsa dma on mips fix */
> +		p = virt_to_page(
> +			CAC_ADDR((substream->runtime->dma_area + offset)));
> +	}
> +
> +	return p;
> +}
> +
> +/* ack callback, when some more data is written */
> +static int sma_pcm_ack(struct snd_pcm_substream *substream)
> +{
> +	//snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	int chi = substream_to_channel_index(substream);
> +	unsigned long ap;
> +
> +	ap = frames_to_bytes(substream->runtime,
> +		substream->runtime->control->appl_ptr);
> +
> +	//ap =- SMA_RING_SIZE;
> +	if (32 > ap) ap += SMA_RING_SIZE;
> +	ap -= 32;
> +	ap &= SMA_RING_MASK;
> +
> +snd_printd("in ack, ap=0x%lX (%lu), for channel %d\n", ap, ap, chi);
> +	writeq(ap, &mace->perif.audio.chan[chi].write_ptr);
> +
> +	/* set DMA to wake on 50% empty and enable interrupt */
> +/*	writeq(SMA_DMA_ENABLE | SMA_INT_THRESHOLD_50,
> +		&mace->perif.audio.chan[chi].control);*/
> +	mb();
> +
> +	return 0;
> +}
> +
> +
> +/* create pcm device */
> +static int __devinit sma_pcm_new(snd_mace_audio_t *chip)
> +{
> +	struct snd_pcm *pcm;
> +	int err, chi;
> +
> +	/* reset channels and leave them off */
> +	for (chi=0; chi<3; chi++) {
> +		writeq(0,
> +			&mace->perif.audio.chan[chi].control);
> +
> +		writeq(0, &mace->perif.audio.chan[chi].write_ptr);
> +		writeq(0, &mace->perif.audio.chan[chi].read_ptr);
> +
> +		writeq(SMA_CTRL_CHAN_RESET,
> +			&mace->perif.audio.chan[chi].control);
> +
> +		spin_lock_init(&chip->channel[chi].lock);
> +	}
> +
> +	pcm = NULL;
> +	err = snd_pcm_new(chip->card, "Mace Audio 1", 0, 1, 1, &pcm);
> +	if (0 > err) return err;
> +
> +	pcm->private_data = chip;
> +	strcpy(pcm->name, "Mace Audio Primary");
> +
> +	/* set operators */
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
> +		&sma_pcm_ops[sma_indirect]);
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
> +		&sma_pcm_ops[sma_indirect]);
> +
> +	chip->pcm[0] = pcm;
> +
> +
> +	pcm = NULL;
> +	err = snd_pcm_new(chip->card, "Mace Audio 1", 1, 1, 0, &pcm);
> +	if (0 > err) return err; /*free pcm0 ? */
> +
> +	pcm->private_data = chip;
> +	strcpy(pcm->name, "Mace Audio Secondary");
> +
> +	/* set operators */
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
> +		&sma_pcm_ops[sma_indirect]);
> +
> +	chip->pcm[1] = pcm;
> +
> +	return 0;
> +}
> +
> +/*************************** Interrupts and DMA engine ****************/
> +static int sma_dma_start(struct snd_pcm_substream *substream)
> +{
> +	snd_mace_audio_t *chip = snd_pcm_substream_chip(substream);
> +	int chi = substream_to_channel_index(substream);
> +
> +snd_printd("In DMA enable for channel %d\n", chi);
> +
> +	if (sma_indirect) {
> +		sma_dma_refill(chip, chi);
> +	}
> +
> +	/* set DMA to wake on 50% empty and enable interrupt */
> +	writeq(SMA_DMA_ENABLE | SMA_INT_THRESHOLD_50,
> +		&mace->perif.audio.chan[chi].control);
> +	mb();
> +
> +	return 0;
> +}
> +
> +static int sma_dma_stop(struct snd_pcm_substream *substream)
> +{
> +	int chi = substream_to_channel_index(substream);
> +snd_printd("In DMA stop for channel %d\n", chi);
> +
> +	writeq(SMA_CTRL_CHAN_RESET,
> +		&mace->perif.audio.chan[chi].control);
> +	mb();
> +
> +	return 0;
> +}
> +
> +static void sma_dma_ping(snd_mace_audio_t *chip, int chi)
> +{
> +
> +	if (sma_indirect){
> +		sma_dma_refill(chip, chi);
> +		snd_pcm_period_elapsed(chip->channel[chi].substream);
> +	} else {
> +		snd_pcm_period_elapsed(chip->channel[chi].substream);
> +		/* Stop DMA if running low */
> +		/*depth = readq(&mace->perif.audio.chan[chi].depth);
> +		if (1024 > depth) sma_dma_stop(chip->channel[chi].substream);*/
> +	}
> +
> +}
> +
> +static void sma_dma_refill(snd_mace_audio_t *chip, int chi)
> +{
> +	u64 *dst, dst_base, dst_pos, *src, src_base, src_pos, src_mask;
> +	unsigned long flags, filled, available;
> +	int i;
> +	struct snd_pcm_runtime *runtime =
> +		chip->channel[chi].substream->runtime;
> +
> +	spin_lock_irqsave(&chip->channel[chi].lock, flags);
> +
> +	dst_base = (u64)chip->ring_base + SMA_RING_OFFSET(chi) +
> +		chip->mace_offset;
> +	src_base = (u64)runtime->dma_area;
> +
> +	dst_pos = readq(&mace->perif.audio.chan[chi].write_ptr);
> +	src_pos = chip->channel[chi].pos;
> +
> +	//src_mask = runtime->dma_bytes -1;
> +	src_mask = frames_to_bytes(runtime, runtime->buffer_size) - 1;
> +
> +	dst = (u64*)(dst_base + dst_pos);
> +	src = (u64*)(src_base + src_pos);
> +;
> +	filled = readq(&mace->perif.audio.chan[chi].depth);
> +	available = SMA_RING_SIZE - filled;
> +
> +	/* don't catch up with the end, note 32 byte chunks*/
> +	if (SMA_RING_SIZE <= available) available -= 32;
> +
> +	/* copy in 32 byte blocks */
> +	while (31 < available) for (i=0; i<32; i+=sizeof(u64)) {
> +
> +		*dst = *src;
> +
> +		dst_pos += sizeof(u64);
> +		dst_pos &= SMA_RING_MASK;
> +		dst = (u64*)(dst_base + dst_pos);
> +
> +		src_pos += sizeof(u64);
> +		src_pos &= src_mask;
> +		src = (u64*)(src_base + src_pos);
> +
> +		available -= sizeof(u64);
> +	}
> +
> +	writeq(dst_pos, &mace->perif.audio.chan[chi].write_ptr);
> +	chip->channel[chi].pos = src_pos;
> +	mb();
> +
> +	src_pos = readq(&mace->perif.audio.chan[chi].write_ptr);
> +	if (src_pos != dst_pos)
> +		snd_printk("ohoh ring boundary not matched! 0x%lX != 0x%lX\n",
> +			src_pos, dst_pos);
> +
> +	spin_unlock_irqrestore(&chip->channel[chi].lock, flags);
> +}
> +
> +static irqreturn_t sma_interrupt
> +	(int irq, snd_mace_audio_t *chip, struct pt_regs *regs)
> +{
> +	switch (irq) {
> +	case MACEISA_AUDIO_SW_IRQ:
> +		printk("Got MACEISA AUDIO SW IRQ\n");
> +		return IRQ_NONE; /*TODO*/
> +
> +	case MACEISA_AUDIO_SC_IRQ:
> +		sma_adjust_vol(chip);
> +		break;
> +
> +	case MACEISA_AUDIO1_DMAT_IRQ:
> +		sma_dma_ping(chip, 0);
> +		break;
> +
> +	case MACEISA_AUDIO1_OF_IRQ:
> +		printk("Got MACEISA AUDIO1 OF IRQ\n");
> +		return IRQ_NONE; /*TODO*/
> +
> +	case MACEISA_AUDIO2_DMAT_IRQ:
> +		sma_dma_ping(chip, 1);
> +		break;
> +
> +	case MACEISA_AUDIO2_MERR_IRQ:
> +		printk("Got MACEISA AUDIO2 MERR IRQ\n");
> +		return IRQ_NONE; /*TODO*/
> +
> +	case MACEISA_AUDIO3_DMAT_IRQ:
> +		sma_dma_ping(chip, 2);
> +		break;
> +
> +	case MACEISA_AUDIO3_MERR_IRQ:
> +		printk("Got MACEISA AUDIO3 MERR IRQ\n");
> +		return IRQ_NONE; /*TODO*/
> +
> +	default:
> +		snd_printk(KERN_ERR "Unknown IRQ received!\n");
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sma_adjust_vol(snd_mace_audio_t *chip)
> +{
> +	unsigned long status, flags;
> +	unsigned int rvol,lvol;
> +
> +	spin_lock_irqsave(&chip->ad1843_lock, flags);
> +
> +	status = readq(&mace->perif.audio.control);
> +	rvol = ad1843_get_gain(chip->ad1843, chip->ext_vol_for);
> +	lvol = (rvol>>8)&0xFF;
> +	rvol &= 0xFF;
> +
> +snd_printd("in volume adjust for %d, current vol %d|%d, status %ld\n",
> +	chip->ext_vol_for, lvol, rvol, status);
> +
> +	if ((status & SMA_CTRL_VOL_BUTTON_UP) >0) {
> +		status &= ~SMA_CTRL_VOL_BUTTON_UP;
> +		writeq(status, &mace->perif.audio.control);
> +		mb();
> +
> +		if (100 > lvol) lvol++;
> +		if (100 > rvol) rvol++;
> +	}
> +
> +	if ((status & SMA_CTRL_VOL_BUTTON_DOWN) >0) {
> +		status &= ~SMA_CTRL_VOL_BUTTON_DOWN;
> +		writeq(status, &mace->perif.audio.control);
> +		mb();
> +
> +		if (0 < lvol) lvol--;
> +		if (0 < rvol) rvol--;
> +	}
> +
> +	ad1843_set_gain(chip->ad1843, chip->ext_vol_for, ((lvol<<8)|rvol));
> +
> +	mb();
> +
> +	status = readq(&mace->perif.audio.control);
> +snd_printd("leaving volume adjust, vol now %d|%d, status %ld\n",
> +	lvol, rvol, status);
> +
> +	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
> +
> +}
> +
> +/******************** Mixer and controls ********************/
> +
> +static int sma_gain_info
> +	(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 2;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = 100;
> +
> +	return 0;
> +}
> +
> +static int sma_gain_get
> +	(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
> +{
> +	snd_mace_audio_t *chip = snd_kcontrol_chip(kcontrol);
> +	int vol;
> +
> +	spin_lock_irq(&chip->ad1843_lock);
> +
> +	vol = ad1843_get_gain(chip->ad1843, (int)kcontrol->private_value);
> +
> +	ucontrol->value.integer.value[0] = vol & 0xFF;
> +	ucontrol->value.integer.value[1] = (vol >> 8) & 0xFF;
> +
> +	spin_unlock_irq(&chip->ad1843_lock);
> +
> +	return 0;
> +}
> +
> +static int sma_gain_put
> +	(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
> +{
> +	snd_mace_audio_t *chip = snd_kcontrol_chip(kcontrol);
> +	int newvol, oldvol;
> +	unsigned long flags;
> +
> +	spin_lock_irq(&chip->ad1843_lock);
> +
> +	oldvol = ad1843_get_gain(chip->ad1843, kcontrol->private_value);
> +	newvol = (ucontrol->value.integer.value[1] << 8) |
> +		ucontrol->value.integer.value[0];
> +
> +	newvol = ad1843_set_gain(chip->ad1843, kcontrol->private_value,
> +		newvol);
> +
> +	spin_unlock_irq(&chip->ad1843_lock);
> +
> +	return (newvol != oldvol);
> +}
> +
> +static int __devinit sma_control_new(snd_mace_audio_t *chip)
> +{
> +	int err;
> +
> +	err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&sma_ctrl_reclevel, chip));
> +	if (0 > err) return err;
> +
> +	err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&sma_ctrl_line, chip));
> +	if (0 > err) return err;
> +
> +	err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&sma_ctrl_cd, chip));
> +	if (0 > err) return err;
> +
> +	err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&sma_ctrl_mic, chip));
> +	if (0 > err) return err;
> +
> +	err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&sma_ctrl_pcm0, chip));
> +	if (0 > err) return err;
> +
> +	err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&sma_ctrl_pcm1, chip));
> +	if (0 > err) return err;
> +
> +	/*plan a mixer control that can change this*/
> +	chip->ext_vol_for = AD1843_GAIN_PCM_0;
> +
> +	return 0;
> +}
> +
> +/****************************** Proc files
> **********************************/
> +static void sma_proc_ad1843_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer)
> +{
> +	int i;
> +	char *str;
> +	snd_mace_audio_t *chip = proc_entry->private_data;
> +
> +	snd_iprintf(buffer,
> +		"|  15/7   |  14/6   |  13/5   |  12/4   "
> +		"|  11/3   |  10/2   |   9/1   |   8/0   |\n");
> +
> +	for (i=0; i<32; i++){
> +
> +		str = ad1843_dump_reg(chip->ad1843, i);
> +		if (NULL == str) continue;
> +
> +		snd_iprintf(buffer, str);
> +
> +		vfree(str);
> +	}
> +
> +}
> +
> +static void sma_proc_mace_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer)
> +{
> +	snd_mace_audio_t *chip = proc_entry->private_data;
> +	unsigned long r,w,c,d;
> +	int chi;
> +
> +	mb();
> +	r = readq(&mace->perif.ctrl.ringbase);
> +	snd_iprintf(buffer, "MACE Periferals Ringbase: 0x%lX (%lu)\n"
> +		"\t(CPU Address: 0x%lX (%lu), Set Bus Address: 0x%lX (%lu))\n",
> +		(unsigned long)r, (unsigned long)r,
> +		(unsigned long)chip->ring_base, (unsigned long)chip->ring_base,
> +		chip->ring_base_handle, chip->ring_base_handle);
> +
> +	c = readq(&mace->perif.audio.control);
> +	snd_iprintf(buffer, "MACE Audio Control: 0x%lX (%lu)\n", c, c);
> +
> +	c = readq(&mace->perif.audio.codec_control);
> +	snd_iprintf(buffer, "MACE Audio Codec Status Control: 0x%lX (%lu)\n",
> +		c, c);
> +
> +	d = readq(&mace->perif.audio.codec_mask);
> +	snd_iprintf(buffer, "MACE Audio Codec Status IRQ Mask: 0x%lX (%lu)\n",
> +		d, d);
> +
> +	r = readq(&mace->perif.audio.codec_read);
> +	snd_iprintf(buffer, "MACE Audio Codec Status Value: 0x%lX (%lu)\n",
> +		r, r);
> +
> +	for (chi=0; chi<3; chi++) {
> +
> +		mb();
> +		c = readq(&mace->perif.audio.chan[chi].control);
> +		r = readq(&mace->perif.audio.chan[chi].read_ptr);
> +		w = readq(&mace->perif.audio.chan[chi].write_ptr);
> +		d = readq(&mace->perif.audio.chan[chi].depth);
> +
> +		snd_iprintf(buffer, "MACE Audio Channel %u:-\n"
> +			"\tControl: 0x%lX (%lu)\n"
> +			"\tRead Pointer: 0x%lX (%lu)\n"
> +			"\tWrite Pointer: 0x%lX (%lu)\n"
> +			"\tDepth: 0x%lX (%lu)\n",
> +			chi, c, c, r, r, w, w, d, d);
> +
> +		if (chip->channel[chi].substream &&
> +		    chip->channel[chi].substream->runtime ) {
> +			unsigned long ap = frames_to_bytes(
> +				chip->channel[chi].substream->runtime,
> +				chip->channel[chi].substream->runtime->control
> +					->appl_ptr);
> +
> +
> +			snd_iprintf(buffer,
> +				"\tALSA Runtime DMA area: 0x%lX (%lu)\n",
> +				chip->channel[chi].substream->runtime->dma_area,
> +				chip->channel[chi].substream->runtime->dma_area);
> +
> +			snd_iprintf(buffer,
> +				"\tALSA App Pointer: 0x%lX (%lu) [0x%lX (%lu)]\n",
> +				ap,ap,
> +				chip->channel[chi].substream->runtime->control
> +					->appl_ptr,
> +				chip->channel[chi].substream->runtime->control
> +					->appl_ptr);
> +
> +		}
> +	}
> +}
> +
> +static void sma_proc_debug_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer)
> +{
> +	sma_proc_debug_t *entry;
> +
> +	snd_iprintf(buffer, "MACE Audio debug info.\n");
> +
> +	list_for_each_entry(entry, &sma_proc_debug_list, link) {
> +
> +		if (NULL == entry->val_str)
> +			snd_iprintf(buffer, "%s: \t%ld\n",
> +				entry->name, entry->val_int);
> +		else
> +			snd_iprintf(buffer, "%s: \t%s\n",
> +				entry->name, entry->val_str);
> +	}
> +
> +}
> +
> +/* this is called inside the volume interrupt, but is it appropriate
> + * to be allocating memory during an interrupt? */
> +static sma_proc_debug_t* sma_proc_debug_append
> +	(char *name)
> +{
> +	sma_proc_debug_t *entry =
> +		kzalloc(sizeof(sma_proc_debug_t), GFP_ATOMIC);
> +
> +	entry->name = name;
> +
> +	list_add_tail(&entry->link, &sma_proc_debug_list);
> +
> +	return entry;
> +
> +}
> +
> +static int sma_proc_create(snd_mace_audio_t *chip)
> +{
> +	int err;
> +
> +	err = snd_card_proc_new(chip->card, "debug", &chip->proc_debug);
> +	if (0 > err) return err;
> +
> +	snd_info_set_text_ops(chip->proc_debug, chip,
> +		sma_proc_debug_read);
> +
> +	err = snd_card_proc_new(chip->card, "ad1843", &chip->proc_ad1843);
> +	if (0 > err) return err;
> +
> +	snd_info_set_text_ops(chip->proc_ad1843, chip,
> +		sma_proc_ad1843_read);
> +
> +	err = snd_card_proc_new(chip->card, "mace", &chip->proc_mace);
> +	if (0 > err) return err;
> +
> +	snd_info_set_text_ops(chip->proc_mace, chip,
> +		sma_proc_mace_read);
> +
> +	return 0;
> +}
> +
> +/******************************* ALSA setup **************************/
> +
> +/* chip specific destructor */
> +static int sma_free(snd_mace_audio_t *chip)
> +{
> +	int irq;
> +
> +snd_printd("sma_free called\n");
> +
> +	/* reset the interface */
> +	writeq(SMA_CTRL_RESET, &mace->perif.audio.control);
> +	udelay(1);
> +	writeq(0L, &mace->perif.audio.control);
> +
> +	/* undo DMA ? */
> +	dma_free_coherent(NULL, MACEISA_RINGBUFFERS_SIZE + 62,
> +		chip->ring_base, chip->ring_base_handle);
> +
> +	/* release IRQ's */
> +	for (irq=MACEISA_AUDIO_SW_IRQ; irq<=MACEISA_AUDIO3_MERR_IRQ; irq++){
> +		free_irq(irq, chip);
> +	}
> +
> +	/* shutdown the ad1843? */
> +
> +
> +	/* free codec struct*/
> +	kfree(chip->ad1843);
> +	snd_mace_audio_chip = NULL;
> +
> +	return 0;
> +}
> +
> +/* chip specific constructor */
> +static int __devinit sma_create
> +	(struct snd_card *card, snd_mace_audio_t **rchip)
> +{
> +	snd_mace_audio_t *chip;
> +	int err, irq;
> +	unsigned long mace_reg, mringbase;
> +
> +	*rchip = NULL;
> +	chip = card->private_data;
> +	chip->card = card;
> +
> +	/* DMA ring buffer */
> +	chip->ring_base = dma_alloc_coherent (NULL,
> +		MACEISA_RINGBUFFERS_SIZE + 62,
> +		&chip->ring_base_handle, GFP_USER);
> +
> +	err = (NULL == chip->ring_base)?-ENOMEM:0; /* ugly */
> +	if (0> err) goto ERROR_EXIT;
> +
> +	/* set ring base */
> +	writeq(chip->ring_base_handle, &mace->perif.ctrl.ringbase);
> +	mb();
> +
> +	chip->maceisa_base = readq(&mace->perif.ctrl.ringbase);
> +	chip->mace_offset = chip->maceisa_base - chip->ring_base_handle;
> +	/*chip->ring_base += chip->mace_offset;*/
> +
> +snd_printd("allocated ring base. CPU addr=0x%lX, Bus addr=0x%lX\n"
> +	"\tmacebase=0x%lX, offset=0x%lX\n",
> +	chip->ring_base, chip->ring_base_handle,
> +	chip->maceisa_base, chip->mace_offset);
> +
> +	/* Allocate IRQs */
> +	for (irq=MACEISA_AUDIO_SW_IRQ; irq<=MACEISA_AUDIO3_MERR_IRQ; irq++){
> +		/*NOTE What does reqeust_irq return? */
> +		err = request_irq(irq,
> +			(irqreturn_t(*)(int, void*, struct pt_regs*))
> +				&sma_interrupt,
> +			SA_INTERRUPT|SA_SHIRQ, "Mace Audio", chip);
> +		if (0 > err) goto ERROR_EXIT;
> +	}
> +
> +	/* check if the codec is present */
> +	mace_reg = readq(&mace->perif.audio.control);
> +	err = (mace_reg & SMA_CTRL_CODEC_PRESENT)>0? 0 : -ENOENT;
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	/* reset the interface and ad1843 */
> +	writeq(SMA_CTRL_RESET, &mace->perif.audio.control);
> +	udelay(100);
> +	writeq(0L, &mace->perif.audio.control);
> +
> +	/* spin locks */
> +	spin_lock_init(&chip->ad1843_lock);
> +
> +	/* ad1843 setup */
> +	chip->ad1843 = kmalloc(sizeof(ad1843_t), GFP_KERNEL);
> +	err = (NULL == chip->ad1843)?-ENOMEM:0;
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	chip->ad1843->chip =  chip;
> +	chip->ad1843->read =
> +		(int(*)(void*, int))&mace_audio_reg_read;
> +	chip->ad1843->write =
> +		(int(*)(void*, int, int))&mace_audio_reg_write;
> +
> +	/* at mo we dont want any codec update irqs (SW) */
> +	writeq(0L, &mace->perif.audio.codec_mask);
> +
> +	err = ad1843_init(chip->ad1843);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	*rchip = chip;
> +	snd_mace_audio_chip = chip;
> +
> +	return 0;
> +
> +ERROR_EXIT:
> +	snd_printk(KERN_ERR "Attemp to initialise MACE Audio failed\n");
> +	sma_free(chip);
> +	return err;
> +}
> +
> +/* constructer */
> +static int __devinit sma_probe(void)
> +{
> +	struct snd_card      *card;
> +	snd_mace_audio_t *chip;
> +	int err;
> +
> +	/* create alsa stuff*/
> +	card = snd_card_new(alsa_index, alsa_id,
> +		THIS_MODULE, sizeof(snd_mace_audio_t));
> +	if (NULL == card) return -ENOMEM;
> +
> +	/* sutup our stuff*/
> +	err = sma_create(card, &chip);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	/* tell the world who we are */
> +	strcpy(card->driver, "SGI O2 MACE Audio Dirver");
> +	strcpy(card->shortname, "MACE Audio");
> +	sprintf(card->longname, "%s",
> +		card->shortname );
> +
> +	/* attach our bits'n'bobs */
> +	err = sma_pcm_new(chip);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	err = sma_control_new(chip);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	err = sma_proc_create(chip);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	/* and we're done */
> +	err = snd_card_register(card);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	return 0;
> +ERROR_EXIT:
> +	snd_printk(KERN_ERR "Probe for MACE Audio failed\n");
> +	snd_card_free(card);
> +
> +	return err;
> +}
> +
> +/***************************** MACE access ***************************/
> +static int mace_audio_reg_read(snd_mace_audio_t *chip, int reg)
> +{
> +	int val;
> +	unsigned long flags;
> +	unsigned int check;
> +
> +	spin_lock_irqsave(&chip->ad1843_lock, flags);
> +	writeq(SMA_CODEC_READ(reg),
> +		&mace->perif.audio.codec_control);
> +	mb();
> +	udelay(200);
> +
> +	check = readq(&mace->perif.audio.codec_control); /* flush bus */
> +	if (unlikely((SMA_CODEC_READ(reg)) != check))
> +		snd_printk("MACE Audio reg read hic-up sent %lX, got %X\n",
> +			(SMA_CODEC_READ(reg)), check);
> +
> +	val = (int)readq(&mace->perif.audio.codec_read);
> +
> +	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
> +
> +	return val;
> +}
> +
> +static int mace_audio_reg_write(snd_mace_audio_t *chip, int reg, int
> word)
> +{
> +	unsigned long flags;
> +	unsigned int check;
> +
> +	spin_lock_irqsave(&chip->ad1843_lock, flags);
> +
> +	writeq(SMA_CODEC_WRITE(reg, word),
> +		&mace->perif.audio.codec_control);
> +	mb();
> +
> +	udelay(200);
> +
> +	check = readq(&mace->perif.audio.codec_control); /* flush bus */
> +	if (unlikely((SMA_CODEC_WRITE(reg, word)) != check))
> +		snd_printk("MACE Audio reg write hic-up sent %lX, got %X\n",
> +			(SMA_CODEC_WRITE(reg, word)), check);
> +
> +	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
> +
> +	return 0;
> +}
> +
> +/*********************** module setup ****************************/
> +
> +
> +static int __init snd_card_mace_audio_init(void)
> +{
> +	int err;
> +
> +	err = sma_probe();
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	return 0;
> +ERROR_EXIT:
> +#ifdef MODULE
> +	snd_printk(KERN_ERR "Mace Audio not found or device busy\n");
> +#endif
> +	return err;
> +}
> +
> +static void __exit snd_card_mace_audio_exit(void)
> +{
> +	if (NULL != snd_mace_audio_chip) {
> +		struct snd_card *card = snd_mace_audio_chip->card;
> +		sma_free(snd_mace_audio_chip);
> +		snd_card_free(card);
> +	}
> +}
> +
> +MODULE_AUTHOR("Thorben J�ndling <tj.trevelyan@gmail.com>");
> +MODULE_DESCRIPTION("SGI O2 MACE Audio");
> +MODULE_LICENSE("GPL");
> +MODULE_SUPPORTED_DEVICE("{{Silicon Graphics, O2 MACE Audio}}");
> +
> +module_param(alsa_index, int, 0444);
> +MODULE_PARM_DESC(alsa_index, "Index value for MACE Audio");
> +module_param(alsa_id, charp, 0444);
> +MODULE_PARM_DESC(alsa_id, "ID string for MACE Audio");
> +module_param(alsa_enable, bool, 0444);
> +MODULE_PARM_DESC(alsa_enable, "Enable MACE Audio");
> +
> +module_init(snd_card_mace_audio_init)
> +module_exit(snd_card_mace_audio_exit)
> +
>
> --- linux-2.6.21.6-b/sound/mips/mace_audio_spy.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.21.6/sound/mips/mace_audio_spy.c	2007-07-09
> 19:51:22.000000000 +0100
> @@ -0,0 +1,524 @@
> +/*
> + *   Sound driver for Silicon Graphics O2 Workstations MACE audio board.
> + *
> + *   Copyright 2007 Thorben J�ndling <tj.trevelyan@gmail.com>
> + *   Based/Copied heavily on/from sgio2audio.c:
> + *   Copyright 2003 Vivien Chappelier <vivien.chappelier@linux-mips.org>
> + *
> + *   This program is free software; you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program; if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> USA
> + *
> + */
> +
> +/*
> + * To snoop at the state mace audio is in after he ARCS jingle
> + *
> + */
> +
> +
> +/*************************** include ******************************/
> +
> +#include <sound/driver.h>
> +#include <linux/init.h>
> +#include <linux/wait.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/gfp.h>
> +#include <linux/vmalloc.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/list.h>
> +#include <linux/dma-mapping.h>
> +#include <asm/io.h>
> +
> +#include <asm/ip32/ip32_ints.h>
> +#include <asm/ip32/mace.h>
> +
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/control.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/info.h>
> +
> +#include <sound/ad1843.h>
> +
> +/**************************** defines *******************************/
> +
> +/* 1: reset audio interface */
> +#define SMA_CTRL_RESET          0x1UL
> +/* 1: codec detected */
> +#define SMA_CTRL_CODEC_PRESENT  0x2UL
> +/*  2-8  : channel 1 write ptr alias */
> +/*  9-15 : channel 2 read ptr alias */
> +/* 16-22 : channel 3 read ptr alias */
> +/* latched volume button */
> +#define SMA_CTRL_VOL_BUTTON_UP   BIT(24)
> +/* latched volume button */
> +#define SMA_CTRL_VOL_BUTTON_DOWN BIT(23)
> +
> +#define SMA_CODEC_READ(reg)  ((reg) <<17) | 0x00010000UL
> +#define SMA_CODEC_WRITE(reg, val) (((reg) <<17)|(val)) & 0x00FEFFFFUL
> +
> +#define SMA_RING_OFFSET(chi) ((chi) << 12)
> +#define SMA_RING_SIZE 0x1000
> +#define SMA_RING_MASK 0x0FFFUL
> +
> +/* int on buffer >50% full */
> +#define SMA_INT_THRESHOLD_50 (2 << 5)
> +/* 1: enable DMA transfer */
> +#define SMA_DMA_ENABLE   BIT(9)
> +
> +/*old, define still inherted from sgio2audio*/
> +
> +#define SMA_CTRL_CHAN_RESET BIT(10) /* 1: reset channel */
> +
> +#define SMA_INT_THRESHOLD_DISABLED  (0 << 5) /* interrupt disabled */
> +#define SMA_INT_THRESHOLD_25 (1 << 5) /* int on buffer >25% full */
> +#define SMA_INT_THRESHOLD_75 (3 << 5) /* int on buffer >75% full */
> +#define SMA_INT_THRESHOLD_EMPTY     (4 << 5) /* int on buffer empty */
> +#define SMA_INT_THRESHOLD_NOT_EMPTY (5 << 5) /* int on buffer !empty */
> +#define SMA_INT_THRESHOLD_FULL      (6 << 5) /* int on buffer empty */
> +#define SMA_INT_THRESHOLD_NOT_FULL  (7 << 5) /* int on buffer !empty */
> +
> +/****************************** structs/types ***********************/
> +
> +/* chip specific record */
> +typedef struct snd_mace_audio {
> +	struct snd_card *card;
> +	struct snd_pcm  *pcm[2];
> +
> +	struct {
> +		struct snd_pcm_substream *substream;
> +		snd_pcm_uframes_t        frames;
> +
> +		int                  ack;
> +		void                *buffer;
> +		u64                  pos;
> +		spinlock_t           lock;
> +	} channel[3];
> +
> +	/* which gain should the O2 vol butons control?*/
> +	unsigned int ext_vol_for;
> +
> +	struct snd_info_entry  *proc_debug,
> +	                  *proc_ad1843,
> +	                  *proc_mace;
> +
> +	ad1843_t   *ad1843;
> +	spinlock_t ad1843_lock;
> +
> +	void        *ring_base;
> +	dma_addr_t   ring_base_handle;
> +	unsigned long maceisa_base;
> +	unsigned int mace_offset;
> +
> +} snd_mace_audio_t;
> +
> +typedef struct sma_proc_debug {
> +	struct list_head link;
> +
> +/* name to display for the entry */
> +	char  *name;
> +
> +/* a string value */
> +	char  *val_str;
> +
> +/* an int val used if val_str is null */
> +	long val_int;
> +} sma_proc_debug_t;
> +
> +/************************** func declaration
> ****************************/
> +/* mace access */
> +static int mace_audio_reg_read(snd_mace_audio_t *chip, int reg);
> +static int mace_audio_reg_write(snd_mace_audio_t *chip, int reg, int
> word);
> +/* proc */
> +static void sma_proc_ad1843_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer);
> +static void sma_proc_mace_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer);
> +static void sma_proc_debug_read
> +	(struct snd_info_entry *, struct snd_info_buffer *);
> +static sma_proc_debug_t* sma_proc_debug_append(char *name);
> +static int sma_proc_create(snd_mace_audio_t *chip);
> +/* ALSA Setup */
> +static int sma_free(snd_mace_audio_t *chip);
> +static int __devinit sma_create
> +	(struct snd_card *card, snd_mace_audio_t **rchip);
> +static int __devinit sma_probe(void);
> +/* module setup */
> +static int __init snd_card_mace_audio_init(void);
> +static void __exit snd_card_mace_audio_exit(void);
> +
> +
> +/************************* define psudo-funcs
> ***************************/
> +#define sma_proc_entry_assert(entry,name) \
> +	if (NULL == entry) entry = sma_proc_entry_append(name);
> +
> +/* pcm0 substream0 = channel 1
> + * pcm0 substream1 = channel 0
> + * pcm1 substream0 = channel 2
> + */
> +#define substream_to_channel_index(substream) \
> +
> ((((snd_mace_audio_t*)(substream->private_data))->pcm[0]==substream->pcm)\
> + ?!(substream->number):2)
> +
> +/******************************** globals
> *******************************/
> +
> +
> +LIST_HEAD(sma_proc_debug_list);
> +
> +static int   alsa_index = -1;
> +static char *alsa_id    = NULL;
> +static int   alsa_enable= 1;
> +static int   sma_indirect = 1;
> +
> +/* Global needed for module exit */
> +snd_mace_audio_t *snd_mace_audio_chip = NULL;
> +
> +
> +/****************************** Proc files
> **********************************/
> +static void sma_proc_ad1843_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer)
> +{
> +	int i;
> +	char *str;
> +	snd_mace_audio_t *chip = proc_entry->private_data;
> +
> +	snd_iprintf(buffer,
> +		"|  15/7   |  14/6   |  13/5   |  12/4   "
> +		"|  11/3   |  10/2   |   9/1   |   8/0   |\n");
> +
> +	for (i=0; i<32; i++){
> +
> +		str = ad1843_dump_reg(chip->ad1843, i);
> +		if (NULL == str) continue;
> +
> +		snd_iprintf(buffer, str);
> +
> +		vfree(str);
> +	}
> +
> +}
> +
> +static void sma_proc_mace_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer)
> +{
> +	snd_mace_audio_t *chip = proc_entry->private_data;
> +	unsigned long r,w,c,d;
> +	int chi;
> +
> +	mb();
> +	r = readq(&mace->perif.ctrl.ringbase);
> +	snd_iprintf(buffer, "MACE Periferals Ringbase: 0x%lX (%lu)\n"
> +		"\t(CPU Address: 0x%lX (%lu), Set Bus Address: 0x%lX (%lu))\n",
> +		(unsigned long)r, (unsigned long)r,
> +		(unsigned long)chip->ring_base, (unsigned long)chip->ring_base,
> +		chip->ring_base_handle, chip->ring_base_handle);
> +
> +	c = readq(&mace->perif.audio.control);
> +	snd_iprintf(buffer, "MACE Audio Control: 0x%lX (%lu)\n", c, c);
> +
> +	c = readq(&mace->perif.audio.codec_control);
> +	snd_iprintf(buffer, "MACE Audio Codec Status Control: 0x%lX (%lu)\n", c,
> c);
> +
> +	d = readq(&mace->perif.audio.codec_mask);
> +	snd_iprintf(buffer, "MACE Audio Codec Status IRQ Mask: 0x%lX (%lu)\n",
> d, d);
> +
> +	r = readq(&mace->perif.audio.codec_read);
> +	snd_iprintf(buffer, "MACE Audio Codec Status Value: 0x%lX (%lu)\n", r,
> r);
> +
> +	for (chi=0; chi<3; chi++) {
> +
> +		mb();
> +		c = readq(&mace->perif.audio.chan[chi].control);
> +		r = readq(&mace->perif.audio.chan[chi].read_ptr);
> +		w = readq(&mace->perif.audio.chan[chi].write_ptr);
> +		d = readq(&mace->perif.audio.chan[chi].depth);
> +
> +		snd_iprintf(buffer, "MACE Audio Channel %u:-\n"
> +			"\tControl: 0x%lX (%lu)\n"
> +			"\tRead Pointer: 0x%lX (%lu)\n"
> +			"\tWrite Pointer: 0x%lX (%lu)\n"
> +			"\tDepth: 0x%lX (%lu)\n",
> +			chi, c, c, r, r, w, w, d, d);
> +
> +		if (chip->channel[chi].substream &&
> +		    chip->channel[chi].substream->runtime ) {
> +			unsigned long ap = frames_to_bytes(
> +				chip->channel[chi].substream->runtime,
> +				chip->channel[chi].substream->runtime->control
> +					->appl_ptr);
> +
> +
> +			snd_iprintf(buffer, "\tALSA Runtime DMA area: 0x%lX (%lu)\n",
> +				chip->channel[chi].substream->runtime->dma_area,
> +				chip->channel[chi].substream->runtime->dma_area);
> +
> +			snd_iprintf(buffer, "\tALSA App Pointer: 0x%lX (%lu) [0x%lX (%lu)]\n",
> +				ap,ap,
> +				chip->channel[chi].substream->runtime->control
> +					->appl_ptr,
> +				chip->channel[chi].substream->runtime->control
> +					->appl_ptr);
> +
> +		}
> +	}
> +}
> +
> +static void sma_proc_debug_read
> +	(struct snd_info_entry *proc_entry, struct snd_info_buffer *buffer)
> +{
> +	sma_proc_debug_t *entry;
> +
> +	snd_iprintf(buffer, "MACE Audio debug info.\n");
> +
> +	list_for_each_entry(entry, &sma_proc_debug_list, link) {
> +
> +		if (NULL == entry->val_str)
> +			snd_iprintf(buffer, "%s: \t%ld\n",
> +				entry->name, entry->val_int);
> +		else
> +			snd_iprintf(buffer, "%s: \t%s\n",
> +				entry->name, entry->val_str);
> +	}
> +
> +}
> +
> +/* this is called inside the volume interrupt, but is it appropriate
> + * to be allocating memory during an interrupt? */
> +static sma_proc_debug_t* sma_proc_debug_append
> +	(char *name)
> +{
> +	sma_proc_debug_t *entry =
> +		kzalloc(sizeof(sma_proc_debug_t), GFP_ATOMIC);
> +
> +	entry->name = name;
> +
> +	list_add_tail(&entry->link, &sma_proc_debug_list);
> +
> +	return entry;
> +
> +}
> +
> +static int sma_proc_create(snd_mace_audio_t *chip)
> +{
> +	int err;
> +
> +	err = snd_card_proc_new(chip->card, "debug", &chip->proc_debug);
> +	if (0 > err) return err;
> +
> +	snd_info_set_text_ops(chip->proc_debug, chip,
> +		sma_proc_debug_read);
> +
> +	err = snd_card_proc_new(chip->card, "ad1843", &chip->proc_ad1843);
> +	if (0 > err) return err;
> +
> +	snd_info_set_text_ops(chip->proc_ad1843, chip,
> +		sma_proc_ad1843_read);
> +
> +	err = snd_card_proc_new(chip->card, "mace", &chip->proc_mace);
> +	if (0 > err) return err;
> +
> +	snd_info_set_text_ops(chip->proc_mace, chip,
> +		sma_proc_mace_read);
> +
> +	return 0;
> +}
> +
> +/******************************* ALSA setup **************************/
> +
> +/* chip specific destructor */
> +static int sma_free(snd_mace_audio_t *chip)
> +{
> +	int irq;
> +
> +printk("sma_free called\n");
> +
> +	/* free codec struct*/
> +	kfree(chip->ad1843);
> +	snd_mace_audio_chip = NULL;
> +
> +	return 0;
> +}
> +
> +/* chip specific constructor, but we don't init anything */
> +static int __devinit sma_create
> +	(struct snd_card *card, snd_mace_audio_t **rchip)
> +{
> +	snd_mace_audio_t *chip;
> +	int err, irq;
> +	unsigned long mace_reg, mringbase;
> +
> +	*rchip = NULL;
> +	chip = card->private_data;
> +	chip->card = card;
> +
> +	/* check if the codec is present */
> +	mace_reg = readq(&mace->perif.audio.control);
> +	err = (mace_reg & SMA_CTRL_CODEC_PRESENT)>0? 0 : -ENOENT;
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	/* spin locks */
> +	spin_lock_init(&chip->ad1843_lock);
> +
> +	/* ad1843 setup */
> +	chip->ad1843 = kmalloc(sizeof(ad1843_t), GFP_KERNEL);
> +	err = (NULL == chip->ad1843)?-ENOMEM:0;
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	chip->ad1843->chip =  chip;
> +	chip->ad1843->read =
> +		(int(*)(void*, int))&mace_audio_reg_read;
> +	chip->ad1843->write =
> +		(int(*)(void*, int, int))&mace_audio_reg_write;
> +
> +	*rchip = chip;
> +	snd_mace_audio_chip = chip;
> +
> +	return 0;
> +
> +ERROR_EXIT:
> +	snd_printk(KERN_ERR "Attemp to initialise MACE Audio failed\n");
> +	sma_free(chip);
> +	return err;
> +}
> +
> +/* constructer */
> +static int __devinit sma_probe(void)
> +{
> +	struct snd_card      *card;
> +	snd_mace_audio_t *chip;
> +	int err;
> +
> +	/* create alsa stuff*/
> +	card = snd_card_new(alsa_index, alsa_id,
> +		THIS_MODULE, sizeof(snd_mace_audio_t));
> +	if (NULL == card) return -ENOMEM;
> +
> +	/* sutup our stuff*/
> +	err = sma_create(card, &chip);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	/* tell the world who we are */
> +	strcpy(card->driver, "SGI O2 MACE Audio Spy");
> +	strcpy(card->shortname, "MACE Audio Spy");
> +	sprintf(card->longname, "%s",
> +		card->shortname );
> +
> +	err = sma_proc_create(chip);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	/* and we're done */
> +	err = snd_card_register(card);
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	return 0;
> +ERROR_EXIT:
> +	snd_printk(KERN_ERR "Probe for MACE Audio failed\n");
> +	snd_card_free(card);
> +
> +	return err;
> +}
> +
> +/***************************** MACE access ***************************/
> +static int mace_audio_reg_read(snd_mace_audio_t *chip, int reg)
> +{
> +	int val;
> +	unsigned long flags;
> +	unsigned int check;
> +
> +	spin_lock_irqsave(&chip->ad1843_lock, flags);
> +	writeq(SMA_CODEC_READ(reg),
> +		&mace->perif.audio.codec_control);
> +	mb();
> +	udelay(200);
> +
> +	check = readq(&mace->perif.audio.codec_control); /* flush bus */
> +	if (unlikely((SMA_CODEC_READ(reg)) != check))
> +		printk("MACE Audio reg read hic-up sent %lX, got %X\n",
> +			(SMA_CODEC_READ(reg)), check);
> +
> +	val = (int)readq(&mace->perif.audio.codec_read);
> +
> +	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
> +
> +	return val;
> +}
> +
> +static int mace_audio_reg_write(snd_mace_audio_t *chip, int reg, int
> word)
> +{
> +	unsigned long flags;
> +	unsigned int check;
> +
> +	spin_lock_irqsave(&chip->ad1843_lock, flags);
> +
> +	writeq(SMA_CODEC_WRITE(reg, word),
> +		&mace->perif.audio.codec_control);
> +	mb();
> +
> +	udelay(200);
> +
> +	check = readq(&mace->perif.audio.codec_control); /* flush bus */
> +	if (unlikely((SMA_CODEC_WRITE(reg, word)) != check))
> +		printk("MACE Audio reg write hic-up sent %lX, got %X\n",
> +			(SMA_CODEC_WRITE(reg, word)), check);
> +
> +	spin_unlock_irqrestore(&chip->ad1843_lock, flags);
> +
> +	return 0;
> +}
> +
> +/*********************** module setup ****************************/
> +
> +
> +static int __init snd_card_mace_audio_init(void)
> +{
> +	int err;
> +
> +	err = sma_probe();
> +	if (0 > err) goto ERROR_EXIT;
> +
> +	return 0;
> +ERROR_EXIT:
> +#ifdef MODULE
> +	printk(KERN_ERR "Mace Audio not found or device busy\n");
> +#endif
> +	return err;
> +}
> +
> +static void __exit snd_card_mace_audio_exit(void)
> +{
> +	if (NULL != snd_mace_audio_chip) {
> +		struct snd_card *card = snd_mace_audio_chip->card;
> +		sma_free(snd_mace_audio_chip);
> +		snd_card_free(card);
> +	}
> +}
> +
> +MODULE_AUTHOR("Thorben J�ndling <tj.trevelyan@gmail.com>");
> +MODULE_DESCRIPTION("SGI O2 MACE Audio Spy");
> +MODULE_LICENSE("GPL");
> +MODULE_SUPPORTED_DEVICE("{{Silicon Graphics, O2 MACE Audio}}");
> +
> +module_param(alsa_index, int, 0444);
> +MODULE_PARM_DESC(alsa_index, "Index value for MACE Audio");
> +module_param(alsa_id, charp, 0444);
> +MODULE_PARM_DESC(alsa_id, "ID string for MACE Audio");
> +module_param(alsa_enable, bool, 0444);
> +MODULE_PARM_DESC(alsa_enable, "Enable MACE Audio");
> +
> +module_init(snd_card_mace_audio_init)
> +module_exit(snd_card_mace_audio_exit)
> +
>
> --- linux-2.6.21.6-b/sound/mips/Kconfig	2007-07-09 11:57:38.000000000
> +0100
> +++ linux-2.6.21.6/sound/mips/Kconfig	2007-07-09 19:14:18.000000000 +0100
> @@ -11,5 +11,18 @@
>  	help
>  	  ALSA Sound driver for the Au1x00's AC97 port.
>
> +config SND_MACE_AUDIO
> +	tristate "SGI O2 MACE Audio"
> +	depends on  SND && SGI_IP32
> +	help
> +	Sound support for the SGI O2 Workstation.
> +
> +config SND_MACE_AUDIO_SPY
> +	tristate "SGI O2 MACE Audio Spy"
> +	depends on  SND && SGI_IP32
> +	help
> +	Spy on MACE Audio Hardware state. Do not use if you don't know
> +	what this module is for or why you want to use it.
> +
>  endmenu
>
>
> --- linux-2.6.21.6-b/sound/mips/Makefile	2007-07-09 11:57:38.000000000
> +0100
> +++ linux-2.6.21.6/sound/mips/Makefile	2007-07-09 19:14:18.000000000 +0100
> @@ -3,6 +3,11 @@
>  #
>
>  snd-au1x00-objs := au1x00.o
> +snd-mace-audio-objs := mace_audio.o ad1843.o
> +snd-mace-audio-spy-objs := mace_audio_spy.o ad1843.o
>
>  # Toplevel Module Dependency
>  obj-$(CONFIG_SND_AU1X00) += snd-au1x00.o
> +obj-$(CONFIG_SND_MACE_AUDIO) += snd-mace-audio.o
> +obj-$(CONFIG_SND_MACE_AUDIO_SPY) += snd-mace-audio-spy.o
> +
>
>
>
