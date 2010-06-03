Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 19:25:16 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:60044 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492030Ab0FCRZM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 19:25:12 +0200
Received: by wyj26 with SMTP id 26so264365wyj.36
        for <multiple recipients>; Thu, 03 Jun 2010 10:25:04 -0700 (PDT)
Received: by 10.216.88.203 with SMTP id a53mr1472081wef.25.1275585903976;
        Thu, 03 Jun 2010 10:25:03 -0700 (PDT)
Received: from [192.168.1.6] (host81-136-218-57.in-addr.btopenworld.com [81.136.218.57])
        by mx.google.com with ESMTPS id k13sm220714wed.23.2010.06.03.10.25.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 10:25:02 -0700 (PDT)
Subject: Re: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC support
From:   Liam Girdwood <lrg@slimlogic.co.uk>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <4C07E37A.40502@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
         <1275505950-17334-5-git-send-email-lars@metafoo.de>
         <1275569309.3593.106.camel@odin>  <4C07DD48.2050503@metafoo.de>
         <1275584609.3118.26.camel@odin>  <4C07E37A.40502@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 03 Jun 2010 18:25:00 +0100
Message-ID: <1275585900.3118.29.camel@odin>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 27058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@slimlogic.co.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2622

On Thu, 2010-06-03 at 19:16 +0200, Lars-Peter Clausen wrote:
> Liam Girdwood wrote:
> > On Thu, 2010-06-03 at 18:50 +0200, Lars-Peter Clausen wrote:
> >   
> >>>> +    config = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai,
> >>>>         
> >> substream);
> >>     
> >>>> +    if (!prtd->dma) {
> >>>> +            const char *dma_channel_name;
> >>>> +            if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >>>> +                    dma_channel_name = "PCM Playback";
> >>>> +            else
> >>>> +                    dma_channel_name = "PCM Capture";
> >>>> +
> >>>> +            prtd->dma = jz4740_dma_request(substream,
> >>>>         
> >> dma_channel_name);
> >>     
> >>>>     
> >>>>         
> >>> dma_channel_name variable is not required here. Just use the const
> >>>       
> >> char
> >>     
> >>> * directly.
> >>>
> >>>   
> >>>       
> >> I actually had it like that before, but I think it is much more readable
> >> in its current form.
> >>     
> >
> > I disagree, having the char pointer here just adds an extra level of
> > indirection and costs an extra two lines of code. 
> >
> > Liam 
> >   
> Hi
> 
> Could you give an concrete example of how you would code it?
> 

Sure,

if (!prtd->dma) {
          if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
                   prtd->dma = jz4740_dma_request(substream, "PCM Playback");
          else
                   prtd->dma = jz4740_dma_request(substream, "PCM Capture");
}

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
