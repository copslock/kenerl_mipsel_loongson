Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2011 12:41:39 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:50770 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491021Ab1DLKlg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2011 12:41:36 +0200
Received: by bwz1 with SMTP id 1so6437032bwz.36
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2011 03:41:29 -0700 (PDT)
Received: by 10.204.14.11 with SMTP id e11mr1211756bka.185.1302604889278;
        Tue, 12 Apr 2011 03:41:29 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.65.152])
        by mx.google.com with ESMTPS id c11sm3765447bkc.2.2011.04.12.03.41.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2011 03:41:28 -0700 (PDT)
Message-ID: <4DA42BFB.2010908@mvista.com>
Date:   Tue, 12 Apr 2011 14:39:55 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Yury Polyanskiy <ypolyans@princeton.edu>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Notifier chain called twice
References: <BANLkTikTDQgwHtK1V4AqRAALw_HrSTuvnQ@mail.gmail.com>
In-Reply-To: <BANLkTikTDQgwHtK1V4AqRAALw_HrSTuvnQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 12-04-2011 10:44, Yury Polyanskiy wrote:

> Dear all,

> The notifier chain is currently called twice on OOPS. Patch below.

    You need to provide your signoff for the patch to be applied.

> Best,
> Yury

    The greeting and goodbye shouldn't be parts of the patch.

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 4e00f9b..fdc6773 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -375,8 +375,6 @@ void __noreturn die(const char *str, str
>          unsigned long dvpret = dvpe();
>   #endif /* CONFIG_MIPS_MT_SMTC */
>
> -       notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV);
> -

    Unfortunately, the patch is whitespace-mangled: all tabs have been 
replaced by spaces.

WBR, Sergei
