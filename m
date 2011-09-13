Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2011 15:06:05 +0200 (CEST)
Received: from mail1.pearl-online.net ([62.159.194.147]:52971 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491110Ab1IMNF6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2011 15:05:58 +0200
Received: from Mobile0.Peter (109.125.101.165.dynamic.cablesurf.de [109.125.101.165])
        by mail1.pearl-online.net (Postfix) with ESMTPA id C3E0020351;
        Tue, 13 Sep 2011 15:05:50 +0200 (CEST)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id p8DEi89e001768;
        Tue, 13 Sep 2011 14:44:08 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
        by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id p8DD3LAV005901;
        Tue, 13 Sep 2011 15:03:21 +0200
Received: from localhost (pf@localhost)
        by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id p8DD3LNa005898;
        Tue, 13 Sep 2011 15:03:21 +0200
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:   Tue, 13 Sep 2011 15:03:20 +0200 (CEST)
From:   peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:     Sergei Shtylyov <sshtylyov@mvista.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
In-Reply-To: <4E6F32AE.3040007@mvista.com>
Message-ID: <Pine.LNX.4.64.1109131456270.5896@Indigo2.Peter>
References: <Pine.LNX.4.64.1109131101530.4143@Indigo2.Peter>
 <4E6F32AE.3040007@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-archive-position: 31065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6364



Hi Sergei,

On Tue, 13 Sep 2011, Sergei Shtylyov wrote:

> Date: Tue, 13 Sep 2011 14:38:38 +0400
> From: Sergei Shtylyov <sshtylyov@mvista.com>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH] Impact video driver for SGI Indigo2
> 
> Hello.
>
> ...
>>> There are alos empty lines after each file in the patch -- which
>>> shouldn't be there.
>
>> These were intended for readability (reviewability :), but i can remove
>> them easily (of course).
>
>   These will prevent the patch from applying, AFAIK.
>

i do a "patch -p1<diffile; git add ..." and patch just discards (as
expected) any "comment"-lines before, between and after the chunks.

> ...
>
>
> WBR, Sergei
>
>

kind regards

peter
