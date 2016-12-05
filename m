Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2016 17:53:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36506 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992943AbcLEQxBL5hw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2016 17:53:01 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0CF56B12607BB;
        Mon,  5 Dec 2016 16:52:51 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Dec
 2016 16:52:54 +0000
Subject: Re: [PATCH 3/5] MIPS: Only change $28 to thread_info if coming from
 user mode
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
 <1480685957-18809-4-git-send-email-matt.redfearn@imgtec.com>
 <alpine.DEB.2.00.1612051605590.6743@tp.orcam.me.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <9579f0c6-9f67-cf1d-94c1-34d14f38afd6@imgtec.com>
Date:   Mon, 5 Dec 2016 16:52:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1612051605590.6743@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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


Hi Maciej,

On 05/12/16 16:20, Maciej W. Rozycki wrote:
> On Fri, 2 Dec 2016, Matt Redfearn wrote:
>
>> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
>> index eebf39549606..5782fa3d63be 100644
>> --- a/arch/mips/include/asm/stackframe.h
>> +++ b/arch/mips/include/asm/stackframe.h
>> @@ -216,12 +216,22 @@
>>   		LONG_S	$25, PT_R25(sp)
>>   		LONG_S	$28, PT_R28(sp)
>>   		LONG_S	$31, PT_R31(sp)
>> +
>> +		/* Set thread_info if we're coming from user mode */
>> +		.set	reorder
>> +		mfc0	k0, CP0_STATUS
>> +		sll	k0, 3		/* extract cu0 bit */
>> +		.set	noreorder
>> +		bltz	k0, 9f
>> +		 nop
>   This code is already `.set reorder', although a badly applied CONFIG_EVA
> change made things slightly less obvious.  So why do you need this `.set
> reorder' in the first place, and then why do you switch code that follows
> to `.set noreorder'?

Ah yes, I missed the .set reorder above the EVA ifdef and just included 
the .set reorder as the similar snippet here:
http://lxr.free-electrons.com/source/arch/mips/include/asm/stackframe.h#L149

I'll revise that in V2.

Thanks,
Matt

>
>   Overall I think all <asm/stackframe.h> code should be using the (default)
> `.set reorder' mode, perhaps forced explicitly in case these macros are
> pasted into `.set noreorder' code, to make it easier to avoid subtle data
> dependency bugs, and also to make R6 porting easier.  Except maybe for the
> RFE sequence, for readability's sake, although even there GAS will do the
> right thing.  Surely the BLTZ/MOVE piece does not have to be `.set
> noreorder' as GAS will schedule that delay slot automatically if allowed
> to.
>
>    Maciej
