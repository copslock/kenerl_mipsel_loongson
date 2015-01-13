Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 14:13:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34018 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010496AbbAMNNI6qfrR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 14:13:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C0E72E155D382;
        Tue, 13 Jan 2015 13:13:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Jan 2015 13:13:03 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 13 Jan
 2015 13:13:02 +0000
Message-ID: <54B519DE.4010708@imgtec.com>
Date:   Tue, 13 Jan 2015 13:13:02 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com> <54932370.605@gmail.com> <5493E97A.1070608@imgtec.com> <alpine.LFD.2.11.1501112322130.27458@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501112322130.27458@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45100
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

On 01/11/2015 11:34 PM, Maciej W. Rozycki wrote:
> On Fri, 19 Dec 2014, Markos Chandras wrote:
> 
>>>> The use of "add" instruction for immediate operations is wrong and
>>>> relies to gas being smart enough to notice that and replace it with
>>>> either addi or addui. However, MIPS R6 removed the addi instruction
>>>> so, fix this problem properly by using the correct instruction
>>>> directly.
> 
>  Not true, depending on the arguments the ADD assembly macro expands to 
> either of the ADD and the ADDI hardware instructions; where an immediate 
> outside the 16-bit signed range is used it also expands to a longer 
> sequence involving LUI and the actual operation is ADD.  It never expands 
> to ADDIU (which I gather you meant).
> 
>>> This is another case of the use of "add" being a real bug.  We should
>>> never have faulting instructions like this in the kernel.
>>>
>>> Can you send all patches in this set that fix this bug as a separate
>>> patch?  Since they are obviously correct, and really should be used by
>>> all non-R6 processors, we can get them in sooner that the entire R6 thing.
>>>
>>> Thanks,
>>> David Daney
>>
>> sure i will move these patches away from R6 and post them separately.
> 
>  I think using the ADDU macro is preferred here as it allows arbitrary 
> 32-bit values for `off', just like with memory references in MIPS assembly 
> instructions.
> 
>   Maciej
> 
Hi,

What ADDU macro?

-- 
markos
