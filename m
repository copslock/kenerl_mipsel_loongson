Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 10:32:52 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43754 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834997Ab3EBIcvSNK05 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 May 2013 10:32:51 +0200
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com [209.85.220.178])
        by mail.nanl.de (Postfix) with ESMTPSA id D0EF345F79;
        Thu,  2 May 2013 08:32:37 +0000 (UTC)
Received: by mail-vc0-f178.google.com with SMTP id kw10so262642vcb.9
        for <multiple recipients>; Thu, 02 May 2013 01:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jld6ip3i4MkgFiEKp6MUuCsAkPynGnALPUumvLZYwpw=;
        b=gs9Cyl3C5FITEXt1U/R/Novd/4Sl3gedC1fNRjQYA9nqFgKt9qfcWuuf+oEKvckSeP
         cbwsWwr7BWVMscjBUHFoySNgsWyhcIZRW5g5CU1s5C1l1Rfr3Vc7J5h9DVmGi3wkYd9g
         QQ5f+kSPDNQlzG1PTtWZMtUUZRo7bIq1dPuy83wkliw1ejqlYMOklwBPtWNdO9khQHCU
         pbSjTK4oRizR7mVoBIiOeBYzkQaylcF3M8glurhGgXzhWB//wiE/ZXEHZCV+KnzpzWnk
         YSREH0BCOaRdxEcc4NunUtp2Bs1U84D5kbXJQGFlZoqUfuS/LGLtzO06DPPwn2mmXWQu
         5f5w==
X-Received: by 10.52.99.162 with SMTP id er2mr1576644vdb.67.1367483567295;
 Thu, 02 May 2013 01:32:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Thu, 2 May 2013 01:32:27 -0700 (PDT)
In-Reply-To: <20522420.158691367384219315.JavaMail.weblogic@epml17>
References: <20522420.158691367384219315.JavaMail.weblogic@epml17>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Thu, 2 May 2013 10:32:27 +0200
Message-ID: <CAOiHx=mBPHmDse4EwL-+Fgmpz0=XhcgF_0nWdyvErFO4NU7E0Q@mail.gmail.com>
Subject: Re: mips; boot fail after merge 3.9+
To:     eunb.song@samsung.com
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>, tglx@linutronix.de,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Wed, May 1, 2013 at 6:57 AM, EUNBONG SONG <eunb.song@samsung.com> wrote:
>
> Hello.
> After merge cavium board boots fail, boot log messages are as follows.
> I enabled initcall_debug for debugging.

I can confirm that MIPS does not seem to finish to boot after using
the generic idle loop, I have the same problem on a different platform
(bcm63xx), and bisecting showed the same commit.

(snip)

> I found this issue after cdbedc61c8d0122ad682815936f0d11df1fe5f57.
> And i found something strange. I ran the git show for this commit.
> As below "select GENERIC_IDLE_LOOP" is added for CONFIG_MIPS.
> but the latest arch/mips/Kconfig file has not this one. I have tried to find when this is gone. but i can't find.
> Is there any problem with this?

No, after all architectures were converted to use the generic idle
loop the config symbol was removed, so it's now always on. The problem
is rather that the generic idle loop does not seem to work on MIPS.
Unfortunately due to limited knowledge in this area I can't really
tell which part broke it.


Jonas
