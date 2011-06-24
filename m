Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2011 13:35:35 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:44452 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491831Ab1FXLf3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2011 13:35:29 +0200
Received: from 201-75-172-239-nd.cpe.vivax.com.br ([201.75.172.239] helo=[192.168.30.170])
        by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
        id 1Qa4fW-0005u8-DD; Fri, 24 Jun 2011 11:35:26 +0000
Message-ID: <4E04767A.5020201@infradead.org>
Date:   Fri, 24 Jun 2011 08:35:22 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110419 Red Hat/3.1.10-1.el6_0 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
References: <20110623144750.GA10180@linux-mips.org> <s5hzkl7zlcq.wl%tiwai@suse.de> <20110624111608.GA6327@linux-mips.org>
In-Reply-To: <20110624111608.GA6327@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by casper.infradead.org
        See http://www.infradead.org/rpr.html
X-archive-position: 30505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchehab@infradead.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20251

Em 24-06-2011 08:16, Ralf Baechle escreveu:
> On Fri, Jun 24, 2011 at 10:26:13AM +0200, Takashi Iwai wrote:
> 
>> Hrm...  I still don't understand why ES18XX or others were selected at
>> the first place.  Isn't it covered by the conditional in
>> sound/isa/Kconfig like below?
>>
>> ================================================================
>> menuconfig SND_ISA
>> 	bool "ISA sound devices"
>> 	depends on ISA && ISA_DMA_API
>> ...
>> if SND_ISA
>> ...
>> config SND_ES18XX
>> 	tristate "Generic ESS ES18xx driver"
>> ...
>> endif	# SND_ISA
>> ================================================================
>>
>> Isn't SND_ISA=n in your case although ISA_DMA_API=n?
> 
> The answer is hidden in this Kconfig warning:
> 
> warning: (RADIO_MIROPCM20) selects SND_ISA which has unmet direct dependencies (SOUND && !M68K && SND && ISA && ISA_DMA_API)
> 
> This is due to the following in drivers/media/radio/Kconfig:
> 
> config RADIO_MIROPCM20
>         tristate "miroSOUND PCM20 radio"
>         depends on ISA && VIDEO_V4L2 && SND
>         select SND_ISA
>         select SND_MIRO
> 
> So SND_ISA gets forced on even though the dependency on ISA_DMA_API is not
> fulfilled.  That's solved by adding the dependency on ISA_DMA_API to
> RADIO_MIROPCM20.

Another option would be to convert the two above selects into depends on.

Cheers,
Mauro
