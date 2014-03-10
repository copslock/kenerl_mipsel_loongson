Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2014 18:44:34 +0100 (CET)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:55568 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828011AbaCJRobo0ZdT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Mar 2014 18:44:31 +0100
Received: by mail-wg0-f46.google.com with SMTP id b13so2905872wgh.5
        for <linux-mips@linux-mips.org>; Mon, 10 Mar 2014 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MCNoD+Wcr6A/jDCID6IdIOVJd6ljn9bwXcS/fYNWGho=;
        b=wz+162Ggi1EGJWTprUJvQVHAriGHs3qMfUOUggpPObw//1EpMq7Ehc40uEIGH2GbG4
         R14EaQjtzemsx1mOFwAmN2B6EHK6ZkISc65ZcQH4tJ/85TtIGHoPv2tg8QP7HzoL/8qA
         uGRxqsZrRsKwiYiaIsrvp8I22e0S8T/nYfBPww9C3VVbZfwAUVcmr5Tyyf+OZB7InRDb
         e1tvjQkA8BYJXeLq4B+W07C4gC/akzccGAwTqA2nzz7qiYph7FGE2c8NdHc82mtMnHRY
         0f+WNyADQIPR3mtqJFIj19FbH0vVK4BVhLPsalWSGLH2oG38Oqpo8p5HgZdFjRgjSA/E
         9Skw==
X-Received: by 10.194.63.145 with SMTP id g17mr2637167wjs.72.1394473466224;
 Mon, 10 Mar 2014 10:44:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.80.2 with HTTP; Mon, 10 Mar 2014 10:43:56 -0700 (PDT)
In-Reply-To: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com>
References: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon, 10 Mar 2014 13:43:56 -0400
X-Google-Sender-Auth: RPwpqKS4W9x2kyD-3tmu4d4qAh0
Message-ID: <CAP=VYLribDoh9LyQuNr-RxmRdaVxqNqzCCSAgMxKoZKWd2b1YA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for the M5150 processor
To:     Markos Chandras <markos.chandras@imgtec.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On Tue, Mar 4, 2014 at 8:34 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> Hi,
>
> This patchset adds support for the recently announced M5150 processor
> http://imgtec.com/mips/mips-series5-mclass-m51xx.asp?NewsID=804

I'm going to skip the bisect, and make a guess that this patchset causes
the following build failures on all pre-existing mips boards:

arch/mips/kernel/cpu-probe.c:856:7: error: 'PRID_IMP_M5150' undeclared
(first use in this function)
arch/mips/kernel/cpu-probe.c:857:16: error: 'CPU_M5150' undeclared
(first use in this function)
make[3]: *** [arch/mips/kernel/cpu-probe.o] Error 1

See this link as one of the many linux-next mips failures:

http://kisskb.ellerman.id.au/kisskb/buildresult/10701712/

Paul.
--

>
> This patchset is for the upstream-sfr/mips-for-linux-next tree
>
> Leonid Yegoshin (3):
>   MIPS: Add processor identifier for the M5150 processor
>   MIPS: Add support for the M5150 processor
>   MIPS: kernel: cpu-probe: Add support for probing M5150 cores
>
>  arch/mips/include/asm/cpu-type.h     | 1 +
>  arch/mips/include/asm/cpu.h          | 3 ++-
>  arch/mips/kernel/cpu-probe.c         | 4 ++++
>  arch/mips/kernel/idle.c              | 1 +
>  arch/mips/mm/c-r4k.c                 | 1 +
>  arch/mips/mm/tlbex.c                 | 1 +
>  arch/mips/oprofile/common.c          | 1 +
>  arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
>  8 files changed, 15 insertions(+), 1 deletion(-)
>
> --
> 1.9.0
>
>
