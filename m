Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 02:48:58 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:35878 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816306AbaDKAswwA8Dt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2014 02:48:52 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id 32B3EB20530;
        Fri, 11 Apr 2014 02:54:51 +0200 (CEST)
Received: from Mobile.Peter (root@Mobile.Peter [192.168.1.7])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id s3B3lm13001298;
        Fri, 11 Apr 2014 03:47:48 GMT
Received: from Mobile.Peter (pf@localhost [127.0.0.1])
        by Mobile.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id s3B1xRDI012965;
        Fri, 11 Apr 2014 01:59:27 GMT
Received: from localhost (pf@localhost)
        by Mobile.Peter (8.12.6/8.12.6/Submit) with ESMTP id s3B1xRNP012962;
        Fri, 11 Apr 2014 01:59:27 GMT
X-Authentication-Warning: Mobile.Peter: pf owned process doing -bs
Date:   Fri, 11 Apr 2014 01:59:26 +0000 (UTC)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Mobile.Peter
To:     Miod Vallat <miod@online.fr>
cc:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <Pine.LNX.4.64.1404110154450.12828@Mobile.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
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



On Thu, 10 Apr 2014, Miod Vallat wrote:

> Date: Thu, 10 Apr 2014 12:10:41 +0000 (UTC)
> From: Miod Vallat <miod@online.fr>
> To: linux-mips@linux-mips.org
> Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
>     option -mr10k-cache-barrier=store.  Stop.
> 
>> Odd, I thought R10K systems were locked to booting 64-bit kernels only.  At
>> least the Octane was when it was bootable.  Not sure about IP27.
>
> The Octane needs a 64-bit ARCS and kernel only because none of its
> physical memory is addressable with KSEG0/KSEG1.

The same holds for IP28. Apparently SGI prepared it for the 128MB SIMMS
(banks of 512MB) yet to come.

>
>>>> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it
> working, though.
>
> For some very limited value of working (it boots single-user but does not
> last long due to page table corruption).
>
> Miod
>
>
>

kind regards
