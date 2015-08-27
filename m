Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 11:56:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41561 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010797AbbH0J4I2iFYr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 11:56:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 37B8872CB9AED;
        Thu, 27 Aug 2015 10:56:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 27 Aug 2015 10:56:02 +0100
Received: from [192.168.154.168] (192.168.154.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 27 Aug
 2015 10:56:01 +0100
Subject: Re: [PATCH] mips: siginfo.h: add SIGSYS details [BZ #18863]
To:     Joseph Myers <joseph@codesourcery.com>
References: <1440563342-5411-1-git-send-email-vapier@gentoo.org>
 <alpine.DEB.2.10.1508260918240.26898@digraph.polyomino.org.uk>
 <20150826171017.GD3116@vapier> <55DEC3B9.1070105@imgtec.com>
 <alpine.DEB.2.10.1508270940090.29564@digraph.polyomino.org.uk>
CC:     Mike Frysinger <vapier@gentoo.org>, <libc-alpha@sourceware.org>,
        <linux-mips@linux-mips.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55DEDEB1.70604@imgtec.com>
Date:   Thu, 27 Aug 2015 10:56:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1508270940090.29564@digraph.polyomino.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49042
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

On 08/27/2015 10:41 AM, Joseph Myers wrote:
> On Thu, 27 Aug 2015, Markos Chandras wrote:
> 
>>>> OK.  CC to linux-mips because I see that the MIPS implementation of 
>>>> copy_siginfo_to_user32 doesn't handle __SI_SYS, unlike arm64 at least, so 
>>>> I suspect this won't in fact work for n32 or for o32 with a 64-bit kernel.
>>>
>>> i'm getting reports of seccomp misbehavior on mips already which is what
>>> started me down this glibc path.  i suspect the original port was tested
>>> against o32 kernels only.
>>> -mike
>>>
>>
>> I have recently tested mips64 n64/n32 with the testsuite from libseccomp
>> and that led me to this fix
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9f161439e4104b641a7bfb9b89581d801159fec8
>>
>> if you are aware of other problems (and perhaps a test to trigger them)
>> that could be kernel related let me know
> 
> My observation about copy_siginfo_to_user32 missing a case was purely 
> based on the kernel source code.  I've no reason to think it has anything 
> to do with seccomp problems.
> 

Yeah, my email was directed to Mike who said he is getting reports that
seccomp on MIPS has issues and that led him to his glibc patch.

-- 
markos
