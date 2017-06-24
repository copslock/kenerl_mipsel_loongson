Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 10:51:00 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:34751
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdFXIuxan4Wa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 10:50:53 +0200
Received: by mail-io0-x244.google.com with SMTP id m19so9062118ioe.1;
        Sat, 24 Jun 2017 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=K7+8a/wKKUr7+qSufHlAk1xLlGOyPkRIgL6m8neAWW0=;
        b=H2gnZeymppv1kawsV3kKPRkU0nwM5F0Rhd5oquyrwCTbfAvL081+jFvcPXEcVs+C5M
         hCDvK/MSJhAP0BLI5RR7jrMQMg/uVNHx0Cuc1GFoRYEOfxdB4SlYU9pquinTab5xDhpF
         YjXMy3GNjI140Q34/NHgGYakm232VQbL/usRZnl88LcTgsF/X9N5sAcctO5Isk0647mC
         pha0Tq3nG6vdxOSB3o+XvcwslHjelLA55MZuD255YoNlOkjAY5O60gpL3abiICMyBOeG
         TBu1gkr0D7QGC8YYWoTJ8pCOOs0DuaeoZGTYZErhFn08aXy1oogjGpaTHzLQf8P+M3GZ
         rmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=K7+8a/wKKUr7+qSufHlAk1xLlGOyPkRIgL6m8neAWW0=;
        b=d2vsWQKuid7AGG1t9oz0wj7GDTqqs138osXDZwi+G1ccM4p38dMmSHvDSxXoEeS5cN
         yVRUF4Oh/E3cRM3qXQfZv9QDsKyEDhQc0FGRJLFRdTSfHCx3OfhwrDBZl9SZ6d+M84Am
         CvxAd/b2spX7uWoru1mWYLEGgAyIyXTYTYizFFyCXDCeyV/thKaYJc1CcOfH9zjrhXD/
         zxGI3PzTGv1WPHyQGJvB/zL19XrTw/wdKOovF4wMNxDIYF9fMOpVTleucI+PsCsKYNOV
         vYve0cWDZKD8hnOAKhAvcqnP6Gc6ioGJf4DNKT0dBD/qyZObUwdyo24FWLvFde0AnWgy
         6R7Q==
X-Gm-Message-State: AKS2vOyre6nO72zyJBZInw7EqADAT0Fj8vaHU5/w+ImqAvjMVxZMvFuT
        5VNp7qMF96vrF3MtgsdkHyICglo/qA==
X-Received: by 10.107.192.193 with SMTP id q184mr11790994iof.70.1498294247283;
 Sat, 24 Jun 2017 01:50:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Sat, 24 Jun 2017 01:50:46 -0700 (PDT)
In-Reply-To: <20170623171103.GH6306@linux-mips.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-9-git-send-email-chenhc@lemote.com> <20170623151507.GC31455@jhogan-linux.le.imgtec.org>
 <20170623171103.GH6306@linux-mips.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sat, 24 Jun 2017 16:50:46 +0800
X-Google-Sender-Auth: W_7MkH6TMdqIkygIrnRS9im82KM
Message-ID: <CAAhV-H7_sn=NhTTm2SXFeueCJww_mWvzXQX6xqZrS89sBQCnpQ@mail.gmail.com>
Subject: Re: [PATCH V7 8/9] MIPS: Add __cpu_full_name[] to make CPU names more human-readable
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

OK, I'll rework this patch.

Huacai

On Sat, Jun 24, 2017 at 1:11 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 23, 2017 at 04:15:07PM +0100, James Hogan wrote:
>
>> On Thu, Jun 22, 2017 at 11:06:55PM +0800, Huacai Chen wrote:
>> > diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
>> > index 4eff2ae..78db63a 100644
>> > --- a/arch/mips/kernel/proc.c
>> > +++ b/arch/mips/kernel/proc.c
>>
>> > @@ -62,6 +63,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>> >     seq_printf(m, fmt, __cpu_name[n],
>> >                   (version >> 4) & 0x0f, version & 0x0f,
>> >                   (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
>> > +   if (__cpu_full_name[n])
>> > +           seq_printf(m, "model name\t\t: %s @ %uMHz\n",
>> > +                 __cpu_full_name[n], mips_hpt_frequency / 500000);
>>
>> If the core frequency is useful (I can imagine it being useful for
>> humans), maybe it should be on a separate line.
>>
>> This also assumes that the mips_hpt_frequency is half the core
>> frequency, which may not universally be the case. Perhaps that should be
>> abstracted too (at some point, I suppose it doesn't matter right away).
>
> Indeed, there is a number of cores where the counter is incrementing at
> the full clock rate and some - I think this was the IDT 5230/5260 class
> of devices where the clock rate can be configured through a cold reset
> time bitstream but the rate in use can not be detected by software in
> a configuration register, so it has to be meassured by comparing to
> another known clock.  Whops..
>
> Making the clock part of the name is probably sensible on x86 where there
> seem to be different CPU packages being marketed for different clock
> rates, so this is more of a marketing name in contrast to an actual
> core type.
>
> It's not like on MIPS we're not suffering from creative CPU naming as
> well.  It all started in '91 with when the R4000 with its 8k primary
> caches was upgraded and then primarily due to its 16k caches sold as
> the R4400.  From a software perspective there isn't much of a difference
> so calling the R4400 an R4000 is sensible but users might miss an inch
> or two if their R4400 is called a lowly R4000 ;-)
>
>   Ralf
>
