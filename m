Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 11:18:24 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:59293 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab1CRKSU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 11:18:20 +0100
Received: by wwb17 with SMTP id 17so4107960wwb.24
        for <linux-mips@linux-mips.org>; Fri, 18 Mar 2011 03:18:14 -0700 (PDT)
Received: by 10.227.177.199 with SMTP id bj7mr1005366wbb.140.1300443494796;
        Fri, 18 Mar 2011 03:18:14 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.74.94])
        by mx.google.com with ESMTPS id bd8sm1251521wbb.18.2011.03.18.03.18.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 03:18:13 -0700 (PDT)
Message-ID: <4D833110.8020306@mvista.com>
Date:   Fri, 18 Mar 2011 13:16:48 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Heiher <admin@heiher.info>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fixup personality in different ABI.
References: <AANLkTimsVcPtJHrV+UMcXAMcqDRpm3ZbbXqSuupx0Uq5@mail.gmail.com>
In-Reply-To: <AANLkTimsVcPtJHrV+UMcXAMcqDRpm3ZbbXqSuupx0Uq5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 18-03-2011 7:59, Heiher wrote:

> Hello,

>  From bf3637153bc5e3d0e3f1c2982c323057a8e04801 Mon Sep 17 00:00:00 2001
> From: Heiher<admin@heiher.info>
> Date: Fri, 18 Mar 2011 12:51:08 +0800
> Subject: [PATCH] Fixup personality in different ABI.

    This header (and "Hello") should be omitted, or the maintainer will have 
to hand edit it out of the patch...

> * 'arch' output:
> 	o32 : mips
> 	n32 : mips64
> 	64  : mips64

    You should sign off the patch (with your real name) for it to be applied.

> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index 455c0ac..01510d4 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
[...]
> @@ -305,7 +307,10 @@ do {									\
>   	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)			\
>   		__SET_PERSONALITY32(ex);				\
>   	else								\
> +	{								\

    { should be on the same line with *else*.

WBR, Sergei
