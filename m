Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 04:57:36 +0200 (CEST)
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:42853 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006629AbbFAC5UkF0R4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 04:57:20 +0200
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-06v.sys.comcast.net with comcast
        id aqx21q0032TL4Rh01qx75N; Mon, 01 Jun 2015 02:57:07 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-17v.sys.comcast.net with comcast
        id aqx61q00342s2jH01qx6ML; Mon, 01 Jun 2015 02:57:07 +0000
Message-ID: <556BCA01.1070208@gentoo.org>
Date:   Sun, 31 May 2015 22:57:05 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in cpu_set_fpu_fcsr_mask()
References: <556943D9.7020502@gentoo.org> <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433127427;
        bh=4AB6M0/1JwUmFLMo7a1w3Sv5Yv4q/kOXzyIVmTAMDIo=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=ZQsaANUAjolzB2SaxzuXJ8N10ql/2YQkPYhcsKAjh5yllD8NYs8h4F1Wzl6j7i6Rz
         ho+kGxtspuvuUWADiO/SC++YTKe1Nk9v4sEDD/lmA060cn835I4Fkr724c8AsbqTNm
         RUJ6R0F9HKQ2nP7Cf89RNQM4NDIPvPb/GWzFc77haC8w7FapHArpf16ASfpJR89TEX
         T5yQwO4WPTr7aZUwGYTFQTrSYUn3km8N/RrIxUyzq2KhsaofCr/AcHF3RjbkHxBGyl
         Hh2OqXOe9JTAIi0/0VKX3xT8w1tuIiBpgP6xk1GWaQdFuTQT7ccp6OFbHi1ZmG/ILQ
         Pzxpq9qTbbKVQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47755
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

On 05/31/2015 20:09, Maciej W. Rozycki wrote:
> On Sat, 30 May 2015, Joshua Kinard wrote:
> 
>> MMC:
>> 2A 000: *** General Exception on node 0
>> 2A 000: *** EPC: 0xa800000000022178 (0xa800000000022178)
>> 2A 000: *** Press ENTER to continue.
>> 2A 000: POD MSC Unc> why
>> 2A 000:  EPC    : 0xa800000000022178 (0xa800000000022178)
>> 2A 000:  ERREPC : 0xffffffffbfc00ee0 (0xc00000001fc00ee0)
>> 2A 000:  CACERR : 0x00000000d6d7ff21
>> 2A 000:  Status : 0x0000000024407c80
>> 2A 000:  BadVA  : 0x0000000000000000 (0x0)
>> 2A 000:  RA     : 0xa8000000008771cc (0xa8000000008771cc)
>> 2A 000:  SP     : 0xa80000000081be00
>> 2A 000:  A0     : 0x00000000000051a1
>> 2A 000:  Cause  : 0x000000000000c03c (INT:87------ <Float Pt. Exc>)
>> 2A 000:  Reason : 242 (Unexpected General Exception.)
>> 2A 000:  POD mode was called from: 0xc00000001fc027ec (0xc00000001fc027ec)
>> 2A 000: POD MSC Unc>
>>
>> Address 0xa800000022178 centers around line 85 in 4.1.0-rc4's
>> arch/mips/cpu-probe.c:
>>
>> 85:         write_32bit_cp1_register(CP1_STATUS, fcsr0);
>>     a80000000002216c:       3c020003        lui     v0,0x3
>>     a800000000022170:       3445ffff        ori     a1,v0,0xffff
>>     a800000000022174:       00851024        and     v0,a0,a1
>> --> a800000000022178:       44c2f800        ctc1    v0,$31
>>     a80000000002217c:       00000000        nop
>>
>> Looks like cpu_set_fpu_fcsr_mask() was added in April sometime:
>>
>> http://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/kernel/cpu-probe.c?id=9b26616c8d9dae53fbac7f7cb2c6dd1308102976
> 
>  Thanks for your report and the accurate details!
> 
>> Not sure what else can be gleaned.  Seems this version of the R14K (v1.4)
>> doesn't like that FCSR mask.  Don't recall the Octane complaining about this,
>> but I'll try to double-check tomorrow.  It's got a newer rev of R14K silicon.
>> Might be an errata.
> 
>  Nope, it looks to me like sloppy firmware leaving IEEE 754 exception 
> cause and enable bits set behind in FCSR.  Upon writing them back with the 
> same values an FPE exception is triggered as per the semantics of the CTC1 
> instruction (we have some issues elsewhere with that, e.g. try writing
> ~0 to $fsr manually under GDB in a program that uses the FPU and then
> resuming execution).  I overlooked this possibility.  So it looks to me 
> like we need to mask the enables out here and leave the state of FCSR 
> clobbered after r/w mask probing.

ARCS, sloppy?  Never!


>  Can you please try this diagnostic patch and report the value of FCSR 
> printed ("FCSR is:"), and also tell me if the exception has now gone too?  
> 
>  I'll submit the final fix, properly annotated, if your testing confirms 
> my diagnosis.

That got it to boot again.  I added CPU ID to the printk as well, and got some
odd output from one of the CPUs:

# dmesg | grep FCSR
[    0.000000] CPU0: FCSR is: 00000000
[    0.319158] CPU1: FCSR is: 00000000
[    0.364971] CPU2: FCSR is: ffffffffa8000000
[    0.404854] CPU3: FCSR is: 00000000

--J
