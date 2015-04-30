Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 00:48:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52330 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026373AbbD3Wsrv9p9K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 00:48:47 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F18C8A75CDCAD;
        Thu, 30 Apr 2015 23:48:39 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 30 Apr
 2015 23:43:40 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 30 Apr
 2015 23:43:39 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 30 Apr
 2015 15:43:37 -0700
Message-ID: <5542B019.7010303@imgtec.com>
Date:   Thu, 30 Apr 2015 15:43:37 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS64: R6: R2 emulation bugfix
References: <20150428195335.11229.4516.stgit@ubuntu-yegoshin> <5540A1BF.7060408@imgtec.com> <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 04/29/2015 02:49 AM, Maciej W. Rozycki wrote:
> On Wed, 29 Apr 2015, James Hogan wrote:
>
>>> Error recovery pointers for fixups was improperly set as ".word"
>>> which is unsuitable for MIPS64.
>>>
>>> Replaced by __stringify(PTR)
>> Every other case of this sort of thing uses STR(PTR) (or __UA_ADDR in
>> uaccess.h). Can we stick to STR(PTR) for consistency please?
>   Or __PA_ADDR in paccess.h.
>
>   I have mixed feelings, the reason for __stringify being absent is the
> macro being generic and more recently added than pieces of code that use
> STR, e.g. unaligned.c that has been there since forever.  And we do use
> __stringify in many other cases.
>
>   On the other hand STR is short and sweet, unlike __stringify.
>
>   So how about adding a macro like __STR_PTR that expands to
> __stringify(PTR) and converting all the places throughout our port
> (including ones currently using __UA_ADDR/__PA_ADDR) to use the new macro?
>
>   Leonid's bug fix will need to go in first of course.
>
>    Maciej
As for me, I don't mind which solution is - STR/__stringify or __PA_ADDR.
I just would like to have one for future submissions and I assumed that 
__stringify is it because it a last one so far introduced.

So, I put a decision to maintainer. Ralf?

- Leonid.
