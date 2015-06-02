Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 20:57:12 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:35858 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026874AbbFBS5KN2P04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 20:57:10 +0200
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id bWwV1q00126dK1R01WwxHj; Tue, 02 Jun 2015 18:56:57 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id bWww1q00V42s2jH01WwxJv; Tue, 02 Jun 2015 18:56:57 +0000
Message-ID: <556DFC72.9010705@gentoo.org>
Date:   Tue, 02 Jun 2015 14:56:50 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in cpu_set_fpu_fcsr_mask()
References: <556943D9.7020502@gentoo.org> <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org> <556BCA01.1070208@gentoo.org> <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org> <556D378C.8060503@gentoo.org> <alpine.LFD.2.11.1506021208120.22908@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1506021208120.22908@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433271417;
        bh=5uwDEgELRVHPUrz+5l6VadyhsJtqSB0/D/FzmUE9fu4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=sRIan7VejXfHcZVmbqXvPUR+5J/cag8S6/XxOZkSeAzTq/HIbtQPlDhlDbO7qn/lc
         xRDYT3dKkGTUYvxcG8hYawjSz+GTDwxyOOpGHISBudgQ4ah7ny+V0Wruyn5YKP+rEo
         KsKC4Q73ri2iJHFsCqFi+kwcN8buIH84iD53xsnuUPcCCzakEbsVL30nsMetcyhuED
         wjiplXwIM4yQcN3E0AJWse5JxJyXLFg7PeS3hGdEA1klt07Is1J3BGncm9Ll3QGd6X
         1PLowPVIsI+FMv0Bayb0k8BM18trwJvxEXoMz5L58f8/qE3T+Nx8W1CfeQN1N+AZ1h
         c/ttfH6QaVVCw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/02/2015 07:32, Maciej W. Rozycki wrote:
> On Tue, 2 Jun 2015, Joshua Kinard wrote:
> 
>> I commented on it being odd because out of four CPUs, #2 was coming up with a
>> sign-extended value, twice (I tested two reboot cycles, same both times).  I'm
>> not fully knowledgable of IP27 hardware, and am probably one of the few on the
>> planet in possession of R14K node boards, so this might be a quirk of these
>> specific nodes.  Would need others to test to verify, I guess.
> 
>  That's how the CFC1 instruction works, it sign-extends the 32-bit value 
> written to the destination register on 64-bit processors.  So if the chip 
> has come out of reset with FCSR.FCC[7] set, then the bit will be repeated 
> across bits 63:32 when the bit pattern from FCSR has been transferred to a 
> general-purpose register.
> 
>> As for a typo, nope:
>>
>> 	__enable_fpu(FPU_AS_IS);
>>
>> 	fcsr = read_32bit_cp1_register(CP1_STATUS);
>> ->	pr_info("CPU%d: FCSR is: %08lx\n", smp_processor_id(), fcsr);
>> 	fcsr &= ~mask;
> 
>  OK, thanks for confirming.  So it looks like the cause of the exception 
> vanished at the same time.  There's no harm in reinitialising FCSR here 
> though, any vendor-specific bits possibly set will be cleared on process 
> creation anyway.

I had a thought and moved the printk to be near the top of cpu_probe(), since
it was possible the value of fcsr was getting clobbered by earlier code.  sure
enough, I got saner-looking values:

From full power-down:
# dmesg | grep FCSR
[    0.000000] CPU0: FCSR is: 000051a1
[    0.319163] CPU1: FCSR is: d0828324
[    0.364956] CPU2: FCSR is: a8011980
[    0.404819] CPU3: FCSR is: 00000000

Following a warm reboot cycle:
# dmesg | grep FCSR
[    0.000000] CPU0: FCSR is: 00000000
[    0.319248] CPU1: FCSR is: 00000000
[    0.364920] CPU2: FCSR is: 00000000
[    0.404893] CPU3: FCSR is: 00000000

Following a second full power-down:
# dmesg | grep FCSR
[    0.000000] CPU0: FCSR is: c6001100
[    0.318236] CPU1: FCSR is: 908203a4
[    0.364976] CPU2: FCSR is: a9801888
[    0.404828] CPU3: FCSR is: 08000088

With your new patch posted, it boots up just fine.

--J
