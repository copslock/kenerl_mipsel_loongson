Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 08:49:34 +0200 (CEST)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34532 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbFBGtdANYM4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 08:49:33 +0200
Received: by wgv5 with SMTP id 5so131792094wgv.1;
        Mon, 01 Jun 2015 23:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j85UK6NskaNe5sjbmFD+abZs9VpVDjlxtNDYA/GLXzA=;
        b=L9tDxGcFJn+Vx5hIoEldy5WlyE2InKP2UEWkJ1P6ljrgjDzRbhbRdzsCHDPnj5mPw9
         u7hrR4NzClHk8TKE+r004NCTVVhnDa4XnsNC0qFpqk2sfclbYA9uMqEAZprtQoZ73c3Q
         TKDfuaa4Lai8YzyZUpjmKJ7dLP3u0ESi2e12wkH2QhjPtQSaZLYOqFN64+sIv+Aik4nB
         DkGiVsVFnrZ8q/uus0oQh1Ya2wb7z+zFQ79IIQZwoTy0OvJ3R7Jv6ve3P9SUYiRgYv6g
         NPLLMtPr0iDAX1X1ve7Glr0uMMW3fqXqsHYUs8JgKOguzt9RDFvfG+cAQEdljBp3YJJj
         tDCg==
X-Received: by 10.180.205.168 with SMTP id lh8mr28102435wic.24.1433224141140;
 Mon, 01 Jun 2015 22:49:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.170.7 with HTTP; Mon, 1 Jun 2015 22:48:30 -0700 (PDT)
In-Reply-To: <20150601195339.GB29986@linux-mips.org>
References: <CAD3Xx4K_qq-FZPymp4Ss7rG2FC4iK3TF1sJnBMO+7haMFN_wFg@mail.gmail.com>
 <20150601195339.GB29986@linux-mips.org>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Tue, 2 Jun 2015 07:48:30 +0200
Message-ID: <CAD3Xx4LbBFnrTjgQ0eOY7i6d0-koyQm0jYnWUn=1pMYr90830Q@mail.gmail.com>
Subject: Re: MIPS/IRQCHIP: some remainders of IRQ_CPU
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <andreas.ruprecht@fau.de>,
        hengelein Stefan <stefan.hengelein@fau.de>, tglx@linutronix.de,
        jason@lakedaemon.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

Hi Ralf,

thanks for your answer.

On Mon, Jun 1, 2015 at 9:53 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jun 01, 2015 at 04:51:48PM +0200, Valentin Rothberg wrote:
>
>> Hi Ralf,
>>
>> your commit 1f1786e60b53 ("MIPS/IRQCHIP: Move irq_chip from arch/mips
>> to drivers/irqchip.") is in today's linux-next tree (i.e.,
>> next-20150601).  It renames the Kconfig option IRQ_CPU to
>> IRQ_MIPS_CPU, but misses to rename a few Kconfig selects (see git
>> grep) in arch/mips.
>>
>> If you agree, I can send a trivial patch that renames those remainders?
>
> sed -i -e 's@\bIRQ_CPU\b@IRQ_MIPS_CPU@' $(git grep -l -w IRQ_CPU)
>
> or something like that.

I am not sure if you want me to send a patch, do you?

Kind regards,
 Valentin

>> I detected the issue with ./scripts/checkkconfigsymbols.py by diffing
>> the last and today's linux tree.
>>
>> Some advertisement for a small tool I started a few month a go, which
>> is made for such cases.  With vgrep [1] you can grep for symbols in
>> the current directory tree and afterwards open specific lines in your
>> editor.  It's more or less a comfortable wrapper around (git) grep.  I
>> use it a lot to study source code as well as to manage code changes.
>> The most prominent user I know is Greg KH who uses it as a replacement
>> for cgvg.
>>
>> Kind regards,
>>  Valentin
>>
>> [1] https://github.com/vrothberg/vgrep
>
> Thanks for reporting!
>
>   Ralf
