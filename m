Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 14:24:19 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.182]:60721 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022434AbXGLNYQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 14:24:16 +0100
Received: by wa-out-1112.google.com with SMTP id m16so155834waf
        for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 06:24:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ddAbNMG4K7ohLWhXjIMWKf1DKBFOqglp2Uk6ah30R6FBKzOh1F0vCALzbcsKOZ7Pl/D9D0TCljNT9GRsZJOLMWUXNaIUIpsxx+uTZSqMJDxzwOsOmiu2pobgXZ55PKwv8Wd9sTecg+9VRBD2uhk4caXspcpJggbtsQqQMWayjow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jf+cktcuIRwTxB3xvK2z12hdRQ1DhPubI6x9LrlB2zisUNqOqW8OCVZSYCfH+4fEzIVleCbavtJaCmv1Bjv1OP5uswSzqwAEj3JxJHLqPt5S4H4UluWknGB9kijFk3gCjWdA14nmqt3NWmjlIk/4PdRXSdsYa4JdEwTFS1jro0w=
Received: by 10.114.60.19 with SMTP id i19mr559382waa.1184246640157;
        Thu, 12 Jul 2007 06:24:00 -0700 (PDT)
Received: by 10.114.108.4 with HTTP; Thu, 12 Jul 2007 06:24:00 -0700 (PDT)
Message-ID: <6849c8890707120624o308d53ep88c5b8939903449f@mail.gmail.com>
Date:	Thu, 12 Jul 2007 14:24:00 +0100
From:	TJ <tj.trevelyan@gmail.com>
To:	"sknauert@wesleyan.edu" <sknauert@wesleyan.edu>
Subject: Re: [alsa-devel] [RFC] SGI O2 MACE audio ALSA module
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"ALSA Dev List" <alsa-devel@alsa-project.org>
In-Reply-To: <37831.129.133.89.141.1184226612.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
	 <s5hejjpaiwa.wl%tiwai@suse.de>
	 <6849c8890707091407g61fe2f01jc4eb8ee41e624f15@mail.gmail.com>
	 <s5h644rjmn2.wl%tiwai@suse.de>
	 <37831.129.133.89.141.1184226612.squirrel@webmail.wesleyan.edu>
Return-Path: <tj.trevelyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj.trevelyan@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

All playback sounds too fast, some players seem faster then others,
but I maybe wrong on that. The source file's sample rate seems to make
no difference, i've tried 22k,34k,44k,48k.

I have now been given a sin wave generator script, which I've been
meaning to try, but I lack an OCR so I will have to rely on my
hearing.

ALSA doesn't need to change sample rate, nor will it if the sample is
within the range supported/reported by the driver (as far as i know).

Mace audio supports 8k to 48k. You can look at the set clock speed for
the DAC in /proc/asound/card0/ad1843

You can manually override the clock speed by playing with
ad1843_setup_dac in ad1843.c

You can try lying to ALSA by playing with snd_mace_audio_hw[1] (or
sma_audio_hw[1]) in mace_audio.c

If anyone can see why it plays too fast, please let me know.

Thorben

On 12/07/07, sknauert@wesleyan.edu <sknauert@wesleyan.edu> wrote:
> Okay, I got the module compiled and it and ALSA installed.
>
> I noticed the timing bug, I doubt its a frequency issue as the ALSA guides
> to downsample (i.e. if it were doing 48kHz instead of 44.1kHz) didn't
> help.
>
> You mentioned on some players it would sound okay? I tried everything from
> aplay to xmms and always seemed to play too fast. What CPU are you running
> this on, by the way? Aplay does give underruns if I'm heavily
> multitasking, though sound output seems the same.
>
>
