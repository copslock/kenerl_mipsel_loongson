Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 16:44:33 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:52968 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992334AbdKNPo0CqAJ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 16:44:26 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 15:44:08 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 14 Nov
 2017 07:43:59 -0800
Subject: Re: [PATCH] MIPS: ath25: Avoid undefined early_serial_setup() without
 SERIAL_8250_CONSOLE
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@mips.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1510666157-27252-1-git-send-email-matt.redfearn@mips.com>
 <20171114140534.GA14698@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <c3c985db-3ad7-d5f3-8d3a-065a458b6900@mips.com>
Date:   Tue, 14 Nov 2017 15:43:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171114140534.GA14698@linux-mips.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510674247-452059-8516-521135-2
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186917
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60925
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



On 14/11/17 14:05, Ralf Baechle wrote:
> On Tue, Nov 14, 2017 at 01:29:17PM +0000, Matt Redfearn wrote:
> 
>> Currently MIPS allnoconfig with CONFIG_ATH25=y fails to link due to
>> missing support for early_serial_setup():
>>
>>    LD      vmlinux
>> arch/mips/ath25/devices.o: In function ath25_serial_setup':
>> devices.c:(.init.text+0x68): undefined reference to 'early_serial_setup'
>>
>> Rather than adding dependencies to the platform to force inclusion of
>> SERIAL_8250_CONSOLE together with it's dependencies like TTY, HAS_IOMEM,
>> etc, just make ath25_serial_setup() a no-op when the dependency is not
>> selected in the kernel config.
> 
> Looks like arch/mips/rb532/serial.c might be suffering from the same
> issue?

Hi Ralf!

Indeed it does, and another unmet dependency. Patches incoming.

Thanks,
Matt

> 
>    Ralf
> 
