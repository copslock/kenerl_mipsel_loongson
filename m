Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 17:12:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33680 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012146AbbD2PMqXyxmY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 17:12:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8CFE5D59BF7D9;
        Wed, 29 Apr 2015 16:12:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 29 Apr 2015 16:12:42 +0100
Received: from [192.168.154.77] (192.168.154.77) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 29 Apr
 2015 16:12:41 +0100
Message-ID: <5540F4E9.7010100@imgtec.com>
Date:   Wed, 29 Apr 2015 16:12:41 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS64: R6: R2 emulation bugfix
References: <20150428195335.11229.4516.stgit@ubuntu-yegoshin> <5540A1BF.7060408@imgtec.com> <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 04/29/2015 10:49 AM, Maciej W. Rozycki wrote:
> On Wed, 29 Apr 2015, James Hogan wrote:
> 
>>> Error recovery pointers for fixups was improperly set as ".word"
>>> which is unsuitable for MIPS64.
>>>
>>> Replaced by __stringify(PTR)
>>
>> Every other case of this sort of thing uses STR(PTR) (or __UA_ADDR in
>> uaccess.h). Can we stick to STR(PTR) for consistency please?
> 
>  Or __PA_ADDR in paccess.h.
> 
>  I have mixed feelings, the reason for __stringify being absent is the 
> macro being generic and more recently added than pieces of code that use 
> STR, e.g. unaligned.c that has been there since forever.  And we do use 
> __stringify in many other cases.
> 
>  On the other hand STR is short and sweet, unlike __stringify.

The patch overall looks good to me so here is my

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

I do agree with James that it would be nice to have it in stable 4.0+ as
well.

I don't particularly care if STR() is going to be used at the end or we
stick to __stringify. Both are used in arch/mips/* anyway

-- 
markos
