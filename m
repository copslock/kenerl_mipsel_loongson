Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 10:06:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9517 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010502AbbAUJGM5wLqm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 10:06:12 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B7FFD5A949788;
        Wed, 21 Jan 2015 09:06:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 09:06:04 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 09:06:03 +0000
Message-ID: <54BF6BFB.1020908@imgtec.com>
Date:   Wed, 21 Jan 2015 09:06:03 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for MIPS
 R6
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200015580.28301@eddie.linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320FAC20A@LEMAIL01.le.imgtec.org> <54BE217D.3060508@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320FAC32D@LEMAIL01.le.imgtec.org> <54BE2A0B.8010500@imgtec.com> <alpine.LFD.2.11.1501201433480.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501201433480.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45391
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

On 01/20/2015 02:37 PM, Maciej W. Rozycki wrote:
> On Tue, 20 Jan 2015, Markos Chandras wrote:
> 
>>>> We have tools out there based on 4.9. If we make gcc < 5.0 to fail with
>>>> R6, then nobody will be able to build it until 5.0 is released.
>>>> Perhaps it makes sense to add some checks in arch/mips/Makefile, see if
>>>> our gcc supports -mips32r6 or something and then decide what to do.
>>>
>>> Indeed, I think it is worthwhile supporting the use of tools which have R6
>>> backported to them owing to long lead times for new versions of GCC to be
>>> released.
>>>
>>> I think you could actually just switch the check around and remove the
>>> check for micromips entirely, putting the GCC 4.9 check first:
>>>
>>> #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
>>> #define GCC_OFF12_ASM() "ZC"
>>> #else
>>> #define GCC_OFF12_ASM() "R"
>>> #endif
>>>
>>> From what I can see this is safe. It was presumably written with a micromips
>>> check out of caution to not change older non-micromips code-gen but that
>>> doesn't seem particularly important. It is an improvement to older code if
>>> anything.
>>
>> For non-micromips kernel, this will start using "ZC" instead of "R",
>> whereas before, it only used "ZC" for micromips and "R" for everything
>> else. Is that safe? Maciej was the one committed this code, so if that's
>> still safe, then I will change it as requested.
> 
>  I'm fine with this proposal; a separate Makefile check for 
> `-march=mips32r6' support would be good too.
> 
>   Maciej
> 
I think we are over engineering this. In patch 04/70 you suggested

cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap
cflags-$(CONFIG_CPU_MIPS64_R6)	+= -march=mips64r6 -Wa,--trap

that means that you will pass march=mips32r6 if _R6 is selected without
checking if the toolchain support.

We know that every toolchain that has r6 support will have ZC support as
well. So my question is, why is the original patch wrong. Do you really
need to trap here for r6? Like I said, ever R6 toolchain will support
ZC. If you are trying to build R6 with a non-r6 toolchain you surely
have broken the build earlier on.

Having said that. I believe the original patch is fine.

-- 
markos
