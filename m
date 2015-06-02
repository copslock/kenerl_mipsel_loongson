Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 08:32:24 +0200 (CEST)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:52929 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026895AbbFBGcWG0Gw4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 08:32:22 +0200
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id bGwo1q00327uzMh01Gwohf; Tue, 02 Jun 2015 04:56:48 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-02v.sys.comcast.net with comcast
        id bGwn1q00F42s2jH01Gwnax; Tue, 02 Jun 2015 04:56:48 +0000
Message-ID: <556D378C.8060503@gentoo.org>
Date:   Tue, 02 Jun 2015 00:56:44 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in cpu_set_fpu_fcsr_mask()
References: <556943D9.7020502@gentoo.org> <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org> <556BCA01.1070208@gentoo.org> <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433221008;
        bh=oVlrdVfijLtRd5a4mEoM41SbDN+Xz9256AKhxU3+8xE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=SMsL7iMXu8gV1QWfHWSlCqP7iVPs0yVeW87bijFYOswioLpQJFonMP29xjDMyZQJj
         QZOmYlsleINt6nwX346zwNRg7rEhtVvNLEGaxFqsSjyekWaS2d3BtCfQIRh7OrnECk
         U9H60MUomHhONIJFxwntoKKZMfTAbByt8Ozd/G2m8CeptxYm6ybZPNHHcCrKLri8dZ
         Gga5nGpNtgpWST1jvHj3bFx5DVRpyCJM1zHz/rA5A3rJQUSMAOmlS9+kzWLVldg3rs
         +CZkMTK/4/90WSbfIq5PsJOMR9e4/HEFcQ9mq+OqfDp5rhWvIEHvxaC/0+WOED+QR1
         ju4bTRWCi7Lbg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47770
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

On 06/01/2015 07:27, Maciej W. Rozycki wrote:
> On Sun, 31 May 2015, Joshua Kinard wrote:
> 
>>>  Can you please try this diagnostic patch and report the value of FCSR 
>>> printed ("FCSR is:"), and also tell me if the exception has now gone too?  
>>>
>>>  I'll submit the final fix, properly annotated, if your testing confirms 
>>> my diagnosis.
>>
>> That got it to boot again.  I added CPU ID to the printk as well, and got some
>> odd output from one of the CPUs:
>>
>> # dmesg | grep FCSR
>> [    0.000000] CPU0: FCSR is: 00000000
>> [    0.319158] CPU1: FCSR is: 00000000
>> [    0.364971] CPU2: FCSR is: ffffffffa8000000
>> [    0.404854] CPU3: FCSR is: 00000000
> 
>  The value reported for CPU2 merely shows FCC[7,5,3] bits set, nothing 
> really odd about that, the CPU may well have come out of reset like this.  
> Neither of the values reported though actually corresponds to the symptom 
> you saw, can you double-check you didn't make a typo in your modification 
> to `printk'?

I commented on it being odd because out of four CPUs, #2 was coming up with a
sign-extended value, twice (I tested two reboot cycles, same both times).  I'm
not fully knowledgable of IP27 hardware, and am probably one of the few on the
planet in possession of R14K node boards, so this might be a quirk of these
specific nodes.  Would need others to test to verify, I guess.

Could always turn on heavy diags and poke through the verbose MSC reporting if
needed.

As for a typo, nope:

	__enable_fpu(FPU_AS_IS);

	fcsr = read_32bit_cp1_register(CP1_STATUS);
->	pr_info("CPU%d: FCSR is: %08lx\n", smp_processor_id(), fcsr);
	fcsr &= ~mask;


--J
