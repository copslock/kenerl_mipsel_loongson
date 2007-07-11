Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 09:55:49 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.180]:59109 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022908AbXGKIzr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 09:55:47 +0100
Received: by wa-out-1112.google.com with SMTP id m16so2030488waf
        for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 01:55:35 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LFh68hCfRoj+Z3W/CgffVGc48NG0BC3kzpyPtO7salElnwyQa0hc+yR9m4P3XqSumtqqklpJOohW0hwzHqbVMp969flYz0IbZiwQi9ekPl3TOw3UGGPQwDFLNjytwLUqkaZofeQztAqqNJuiBdwct1Qs4JW6UnDWxNIykGFmJGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BRP/HgTOZpyGDLgdgX/e+W3VIBKiXcmyFIVoh7GOx7BWai1+MwspX1F/juBPN/OF/CiYKmoURDQWAH8A0iYzGSDUKbAnj3YzLmkA7Sx8Ke9726xp9dj2UbcECFuSojP3h5rfv7BQM+Ci8A5Jt7BMrYOJMSRr2usr2KXElhlo5S8=
Received: by 10.115.76.1 with SMTP id d1mr4940474wal.1184144135327;
        Wed, 11 Jul 2007 01:55:35 -0700 (PDT)
Received: by 10.114.108.4 with HTTP; Wed, 11 Jul 2007 01:55:34 -0700 (PDT)
Message-ID: <6849c8890707110155r3961439dxd7fde5251fa1fd3a@mail.gmail.com>
Date:	Wed, 11 Jul 2007 09:55:34 +0100
From:	TJ <tj.trevelyan@gmail.com>
To:	"sknauert@wesleyan.edu" <sknauert@wesleyan.edu>
Subject: Re: [alsa-devel] [RFC] SGI O2 MACE audio ALSA module
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"ALSA Dev List" <alsa-devel@alsa-project.org>
In-Reply-To: <47304.129.133.92.31.1184130847.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
	 <s5hejjpaiwa.wl%tiwai@suse.de>
	 <6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
	 <47304.129.133.92.31.1184130847.squirrel@webmail.wesleyan.edu>
Return-Path: <tj.trevelyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj.trevelyan@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Thank you for trying it.

On 11/07/07, sknauert@wesleyan.edu <sknauert@wesleyan.edu> wrote:
> Thanks for the quick work. Gave it a try.
>
> Shiva:/usr/src/linux-2.6.21.6# make CROSS_COMPILE=mips-linux-gnu- all
> ...
>   Building modules, stage 2.
>   MODPOST 3 modules
> WARNING: "snd_pcm_period_elapsed" [sound/mips/snd-mace-audio.ko] undefined!
> WARNING: "snd_pcm_set_ops" [sound/mips/snd-mace-audio.ko] undefined!
> WARNING: "snd_pcm_lib_ioctl" [sound/mips/snd-mace-audio.ko] undefined!
> WARNING: "snd_pcm_new" [sound/mips/snd-mace-audio.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>

I have never seen this before, it looks like the ALSA core/support
modules have not been build on which my module depends on. Here's my
SND/ALSA config:

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_PCM_XRUN_DEBUG=y

CONFIG_SND_MACE_AUDIO=m
CONFIG_SND_MACE_AUDIO_SPY=m

I guess I should be adding more depends to my Kconfig, I've never
tried to see what the bare minimum alsa modules needed are.

> Surprisingly, make modules before trying to compile the kernel didn't give
> an error, but these warnings:

'make all' includes 'make modules'. I only ever use make all, which is
fine since make does what it's supposed to do and only rebuilds stuff
whose source files have changed.


>   LD [M]  sound/core/snd.o
>   CC [M]  sound/mips/mace_audio.o
> sound/mips/mace_audio.c: In function 'sma_pcm_open':
> sound/mips/mace_audio.c:398: warning: unused variable 'chi'
> sound/mips/mace_audio.c: In function 'sma_gain_put':
> sound/mips/mace_audio.c:893: warning: unused variable 'flags'
> sound/mips/mace_audio.c: In function 'sma_proc_mace_read':
> sound/mips/mace_audio.c:1023: warning: format '%lX' expects type 'long
> unsigned int', but argument 3 has type 'unsigned char *'
> sound/mips/mace_audio.c:1023: warning: format '%lu' expects type 'long
> unsigned int', but argument 4 has type 'unsigned char *'
> sound/mips/mace_audio.c: In function 'sma_create':
> sound/mips/mace_audio.c:1169: warning: passing argument 2 of 'request_irq'
> from incompatible pointer type
> sound/mips/mace_audio.c:1136: warning: unused variable 'mringbase'
> sound/mips/mace_audio.c: At top level:
> sound/mips/mace_audio.c:1060: warning: 'sma_proc_debug_append' defined but
> not used
> sound/mips/mace_audio.c:372: warning: 'print_pointers' defined but not used

This my test/dev code expect complaints about printf (%X for unsigned
char), I could put in explicit type casts, but I do plan to remove all
the spurious printk calls at some point and this helps to remind me.

Out of all of those I have to admit the 'unused variable flags' was an
oversight by me, I meant to remove that..

> This seems like a minor oversight like a patch from the wrong directory.
>
> However, if this is a real bug, I'm using gcc 4.1.1-21 with the MIPS
> cross-compiler and build system from people.debian.org. I haven't tried
> native compilation on the O2 yet. Let me know what you're using to get
> something working and I can be more helpful.

I compile both on the O2 (occasionally) and on a Debian cross dev
environment, built using:
http://people.debian.org/~ths/toolchain/..../buildcross

> I applied the patch -p1 < (let me know if it needs something extra) and
> tried both the Linux-MIPS 2.6.21.6 (which isn't linked on the homepage for
> some reason) and mainline from kernel.org with my working .config from
> 2.6.21.3 with make oldconfig.

I would be surprised if it patched a kernel.org kernel, but it should
apply fine the linux-mip.org kernel. I will have a look to check. Did
you use the patch from the email, that may have been mangled? (It was
a bit of a test to see have Gmail behaves) or the one I linked to on
lm.o? (below)

> Again thanks for all the hard work on this driver. I can't wait to get it
> working on my O2.

Same here, and thank you for looking at the patch/module.

Thorben

http://www.linux-mips.org/pub/linux/mips/people/trevelyan/mace_audio/mace_audio-20070709.patch
