Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 05:23:48 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:51863 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901346Ab2EUDXk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 May 2012 05:23:40 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4L3NWor028263;
        Sun, 20 May 2012 20:23:32 -0700
Received: from [192.168.225.107] (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Sun, 20 May 2012
 20:23:29 -0700
Message-ID: <4FB9B52F.908@mips.com>
Date:   Mon, 21 May 2012 11:23:27 +0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     John Crispin <john@phrozen.org>, <linux-mips@linux-mips.org>,
        <kevink@paralogos.com>
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org> <4FB60403.3080700@mips.com> <4FB68FA2.1030404@phrozen.org> <alpine.LFD.2.00.1205202231400.3701@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1205202231400.3701@eddie.linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: FF07UDKEzgCe/GLrFrLYZg==
X-archive-position: 33388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/21/2012 05:32 AM, Maciej W. Rozycki wrote:
> On Fri, 18 May 2012, John Crispin wrote:
>
>>>> You could introduce a ARCH_HAS_APRP which any platform can then select ?
>>>
>>> Hmm... This is a good idea. Maybe the name could be SYS_SUPPORTS_APRP?
>>
>> You are correct
>
>   What's so Malta-specific in the VPE loader anyway?  It's a CPU feature,
> not a board-specific one.

Well, first off, for VPE loader itself, when it comes to CPS we have
vpe_run() that derives from amon_cpu_start() in arch/mips/mti-malta/malta-
amon.c. There is no implementation of amon_cpu_start() on other platforms.
Secondly, I suppose VPE loader works uniquely for APRP, and part of APRP
(such as IRQ related stuff) depends on platform code. So it makes sense
(IMO) to impose the dependency of APRP on the root (VPE loader).


Thanks,

Deng-Cheng
