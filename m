Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:23:52 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:34148 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990490AbdK1PXiaJAMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:23:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 15:23:25 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Nov
 2017 07:20:12 -0800
Subject: Re: [PATCH 2/2] MIPS: Add custom serial.h with BASE_BAUD override for
 generic kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-serial@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "stable # 4 . 14" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <1511344649-27612-1-git-send-email-matt.redfearn@mips.com>
 <1511344649-27612-2-git-send-email-matt.redfearn@mips.com>
 <20171128143502.GA17699@kroah.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <c33143de-4aa1-828c-a5bf-015545c50a93@mips.com>
Date:   Tue, 28 Nov 2017 15:20:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171128143502.GA17699@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1511882604-298555-29403-39644-4
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187380
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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



On 28/11/17 14:35, Greg Kroah-Hartman wrote:
> On Wed, Nov 22, 2017 at 09:57:29AM +0000, Matt Redfearn wrote:
>> Add a custom serial.h header for MIPS, allowing platforms to override
>> the asm-generic version if required.
>>
>> The generic platform uses this header to set BASE_BAUD to 0. The
>> generic platform supports multiple boards, which may have different
>> UART clocks. Also one of the boards supported is the Boston FPGA board,
>> where the UART clock depends on the loaded FPGA bitfile. As such there
>> is no way that the generic kernel can set a compile time default
>> BASE_BAUD.
>>
>> Commit 31cb9a8575ca ("earlycon: initialise baud field of earlycon device
>> structure") changed the behavior of of_setup_earlycon such that any baud
>> rate set in the device tree is now set in the earlycon structure. The
>> UART driver will then calculate a divisor based on BASE_BAUD and set it.
>> With MIPS generic kernels this resulted in garbage output due to the
>> incorrect uart clock rate being used to calculate a divisor. This
>> commit, combined with "serial: 8250_early: Only set divisor if valid clk
>> & baud" prevents the earlycon code setting a bad divisor and restores
>> earlycon output.
>>
>> Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
>> Cc: stable <stable@vger.kernel.org> # 4.14
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>
>> ---
>>
>>   arch/mips/include/asm/Kbuild   |  1 -
>>   arch/mips/include/asm/serial.h | 21 +++++++++++++++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/mips/include/asm/serial.h
>>
>> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
>> index 7c8aab23bce8..b1f66699677d 100644
>> --- a/arch/mips/include/asm/Kbuild
>> +++ b/arch/mips/include/asm/Kbuild
>> @@ -16,7 +16,6 @@ generic-y += qrwlock.h
>>   generic-y += qspinlock.h
>>   generic-y += sections.h
>>   generic-y += segment.h
>> -generic-y += serial.h
>>   generic-y += trace_clock.h
>>   generic-y += unaligned.h
>>   generic-y += user.h
>> diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
>> new file mode 100644
>> index 000000000000..30be5cd8efdb
>> --- /dev/null
>> +++ b/arch/mips/include/asm/serial.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
> 
> Which version of the GPL?  As it is, this means "GPL v1 and all others".
> 
> I doubt you want that :)

Good point - thanks!

Matt

> 
> thanks,
> 
> greg k-h
> 
