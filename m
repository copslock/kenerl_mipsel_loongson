Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2011 11:40:58 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:33539 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491070Ab1IMJky (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2011 11:40:54 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 89DCF200FE;
        Tue, 13 Sep 2011 11:40:47 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8DBJ49e001309;
        Tue, 13 Sep 2011 11:19:04 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id p8D9dKAV004152;
        Tue, 13 Sep 2011 11:39:20 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8D9dKRx004149;
        Tue, 13 Sep 2011 11:39:20 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Tue, 13 Sep 2011 11:39:20 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     Sergei Shtylyov <sshtylyov@mvista.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
Message-ID: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-archive-position: 31060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6278



Hi Sergei,

On Mon, 12 Sep 2011, Sergei Shtylyov wrote:

> Date: Mon, 12 Sep 2011 13:56:36 +0400
> From: Sergei Shtylyov <sshtylyov@mvista.com>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
>     attilio.fiandrotti@gmail.com
> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
> 
> ...
>> framebuffer device. Without the support of PCI & AGP.
>
>   It looks like the patch is spoiled as I'm seeing two spaces at the start
> of line when looking at the message source.

hmmm, that's a strange problem. The two spaces are not in the diff-file
read into the eMail and are not displayed by the MUA (pine 4.64). But
indeed, where's a leading space in the diff, there's an additional space
inserted into the eMail-body. Have to find out the best way to suppress
this behaviour...

>
>>
>> ...
>
>   There are alos empty lines after each file in the patch -- which
> shouldn't be there.

These were intended for readability (reviewability :), but i can remove
them easily (of course).

>
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> ...
>
>   The above should be a part of the driver patch, as you can't add Makefile
> targets fow which no source files exist yet.
>

Do you suggest to submit the ip22-setup.c-, impact.h-, impact.c-parts
alone in a first patch and then, in a separate follow-up patch, the
Kconfig- and Makefile-parts, or just to reorder the parts in this single
patch?

>> diff --git a/arch/mips/sgi-ip22/ip22-setup.c
>> ...
>> + if (sgi_gfxaddr < 0x1f000000 || 0x1fa00000 <= sgi_gfxaddr)
>
>   Immediate should generally be the right operand in comparison.

This can be changed, should the "if (a is outside the range...)"
notation be confusing or the like.

> ...
>
>   I lack the time to review such a large driver, unfortunately...
>
> WBR, Sergei
>

with kind regards

peter
