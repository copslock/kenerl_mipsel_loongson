Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 16:04:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40111 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011490AbbAMPEWt2aAL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 16:04:22 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C29ECB17C3464;
        Tue, 13 Jan 2015 15:04:13 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Jan 2015 15:04:16 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 13 Jan
 2015 15:04:14 +0000
Message-ID: <54B533EF.1090201@imgtec.com>
Date:   Tue, 13 Jan 2015 15:04:15 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com> <54932370.605@gmail.com> <5493E97A.1070608@imgtec.com> <alpine.LFD.2.11.1501112322130.27458@eddie.linux-mips.org> <54B519DE.4010708@imgtec.com> <alpine.LFD.2.11.1501131455530.23937@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501131455530.23937@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45102
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

On 01/13/2015 02:58 PM, Maciej W. Rozycki wrote:
> On Tue, 13 Jan 2015, Markos Chandras wrote:
> 
>>>  I think using the ADDU macro is preferred here as it allows arbitrary 
>>> 32-bit values for `off', just like with memory references in MIPS assembly 
>>> instructions.
>>
>> What ADDU macro?
> 
>  This:
> 
> {"addu",		"t,r,I",	0,    (int) M_ADDU_I,	INSN_MACRO,		0,		I1,		0,	0 },
> 
> (from opcodes/mips-opc.c).
> 
>   Maciej
> 
I see your point about having 32-bit offsets supported here but it's not
obvious that addu would simply accept this format without looking at the
binutils sources.

in any case, it does not make a difference in this particular example,
so I will fix it. Thanks

-- 
markos
