Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 18:11:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35177 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993156AbdGUQK63BFD9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jul 2017 18:10:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F0FBA1825D26;
        Fri, 21 Jul 2017 17:10:48 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Jul
 2017 17:10:52 +0100
Subject: Re: [PATCH] MIPS: OCTEON: Fix USB platform code breakage.
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
References: <1496250830-26716-1-git-send-email-steven.hill@cavium.com>
 <20170719094143.GS31455@jhogan-linux.le.imgtec.org>
 <d8c33b8e-e57c-f109-7747-fdddbcc7bd0e@cavium.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <bce34cc9-38a2-1fce-3569-65742dc068ad@imgtec.com>
Date:   Fri, 21 Jul 2017 17:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d8c33b8e-e57c-f109-7747-fdddbcc7bd0e@cavium.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59200
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

Hi Steven


On 19/07/17 16:31, Steven J. Hill wrote:
> On 07/19/2017 04:41 AM, James Hogan wrote:
>> Is this already fixed in some other way or is it some unusual configuration? I couldn't reproduce any failure on 4.12 and you haven't quoted the build error or explained what was missing that required io.h to be included.
>>
> It appears things are working fine in 4.12, so I have dropped
> this patch.
>

This is indeed still broken in v4.13-rc1 with some configurations:

   CC      arch/mips/cavium-octeon/octeon-usb.o
arch/mips/cavium-octeon/octeon-usb.c: In function ‘dwc3_octeon_device_init’:
arch/mips/cavium-octeon/octeon-usb.c:540:4: error: implicit declaration 
of function ‘devm_iounmap’ [-Werror=implicit-function-declaration]
     devm_iounmap(&pdev->dev, base);
     ^
cc1: some warnings being treated as errors
scripts/Makefile.build:302: recipe for target 
'arch/mips/cavium-octeon/octeon-usb.o' failed

Thanks,
Matt
