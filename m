Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 12:29:46 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:43562 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903883Ab2BCL3l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2012 12:29:41 +0100
Received: by wera10 with SMTP id a10so3404906wer.36
        for <multiple recipients>; Fri, 03 Feb 2012 03:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q4abndwuLrxTOJPahU7gyauY+DqKZm/cDKKOyG9CswU=;
        b=LJ57cOvpvqGHmRTnLiZxDEj5NrYqdxoIFqGYPjiqyjDpYU5pdiHU6z9jyfcyIGtxzs
         VAJSGsLd7frK7VgEXFnEopkaNwBQQyigW5dNHuyhm5AC7K0+czUM8hgKLVIr5rIC19Si
         jMbOcavPV08vWCbGh8xWyJsuwMcX4SJtGummg=
MIME-Version: 1.0
Received: by 10.216.131.29 with SMTP id l29mr578553wei.48.1328268575573; Fri,
 03 Feb 2012 03:29:35 -0800 (PST)
Received: by 10.216.0.134 with HTTP; Fri, 3 Feb 2012 03:29:35 -0800 (PST)
In-Reply-To: <1328255503-17575-1-git-send-email-xiyou.wangcong@gmail.com>
References: <1328255503-17575-1-git-send-email-xiyou.wangcong@gmail.com>
Date:   Fri, 3 Feb 2012 16:59:35 +0530
Message-ID: <CA+7sy7C34f8MVAhf_+95Cm==-ZcSwxG3ybMcdEyXVHaUVFgNxA@mail.gmail.com>
Subject: Re: [Patch] mips: do not redefine BUILD_BUG()
From:   "Jayachandran C." <c.jayachandran@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.jayachandran@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Feb 3, 2012 at 1:21 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On mips, we got
>
> include/linux/kernel.h:717:1: error: "BUILD_BUG" redefined
> arch/mips/include/asm/page.h:43:1: error: this is the location of the previous definition
> make[3]: *** [arch/mips/sgi-ip27/ip27-console.o] Error 1
> make[2]: *** [arch/mips/sgi-ip27] Error 2
> make[1]: *** [arch/mips] Error 2
> make: *** [sub-make] Error 2
>
> use generic BUILD_BUG() instead of re-defining one.
>
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

This is already fixed in linux-mips.org repository:

commit 2f5d5510507626ee799b6d1304d154569b6dfe05
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Mon Jan 16 12:38:05 2012 +0100

    MIPS: Remove temporary kludge from <asm/page.h>

JC.
