Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 17:01:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27657 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991970AbcIUPBm4rF-1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2016 17:01:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3B5FF59018B96;
        Wed, 21 Sep 2016 16:01:23 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 21 Sep
 2016 16:01:26 +0100
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
 <20160921130852.GA10899@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com>
Date:   Wed, 21 Sep 2016 16:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160921130852.GA10899@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55222
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

Hi Ralf,


On 21/09/16 14:08, Ralf Baechle wrote:
> On Thu, Sep 01, 2016 at 05:30:07PM +0100, James Hogan wrote:
>
>> When reading the CP0_EBase register containing the WG (write gate) bit,
>> the ebase variable should be set to the full value of the register, i.e.
>> on a 64-bit kernel the full 64-bit width of the register via
>> read_cp0_ebase_64(), and on a 32-bit kernel the full 32-bit width
>> including bits 31:30 which may be writeable.
> How about changing the definition of read/write_c0_ebase to
>
> #define read_c0_ebase()         __read_ulong_c0_register($15, 1)
> #define write_c0_ebase(val)     __write_ulong_c0_register($15, 1, val)

James added the {read,write}_c0_ebase_64 functions in 
37fb60f8e3f011c25c120081a73886ad8dbc42fd, because performing a 64bit 
access to 32bit cp0 registers (like ebase on 32bit cpus) was an 
undefined operation pre-r6, so we can't always access them as longs.

>
> or using a new variant like
>
> #define read_c0_ebase_ulong()         __read_ulong_c0_register($15, 1)
> #define write_c0_ebase_ulong(val)     __write_ulong_c0_register($15, 1, val)
>
> to avoid the ifdefery?  This could also make this bit
>
>                  ebase = cpu_has_mips64r6 ? read_c0_ebase_64()
>                                           : (s32)read_c0_ebase();

This relies on being able to determine a 64bit value for ebase, either 
by reading it in its entirety on a 64bit cpu (including on a 32bit 
kernel) or sign extending it from a 32bit read.

Thanks,
Matt

>
> in cpu-probe.c prettier.
>
>    Ralf
