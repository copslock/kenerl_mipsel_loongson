Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 09:14:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55622 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012580AbbLDIOrMUwnY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2015 09:14:47 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AB3AC31FC585A;
        Fri,  4 Dec 2015 08:14:39 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 4 Dec 2015 08:14:41 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 4 Dec
 2015 08:14:40 +0000
Subject: Re: [PATCH 0/9] MIPS Relocatable kernel & KASLR
To:     Joshua Kinard <kumba@gentoo.org>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <5660C0D5.208@gentoo.org>
CC:     <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56614B70.9090700@imgtec.com>
Date:   Fri, 4 Dec 2015 08:14:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5660C0D5.208@gentoo.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50329
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

Hi Joshua,
The patch as it stands uses a couple of MIPS R2 additional instructions 
to deal with synchronizing icache. Firstly, the synci instruction to 
ensure that icache is in sync with the dcache after the relocated kernel 
has been written, and the jr.hb instruction to resolve any hazards 
created by writing the new kernel before jumping to it.

Thanks,
Matt

On 03/12/15 22:23, Joshua Kinard wrote:
> On 12/03/2015 05:08, Matt Redfearn wrote:
>> This series adds the ability for the MIPS kernel to relocate itself at
>> runtime, optionally to an address determined at random each boot. This
>> series is based on v4.3 and has been tested on the Malta platform.
> [snip]
>
>> * Relocation is currently supported on R2 of the MIPS architecture,
>>    32bit and 64bit.
> Out of curiosity, why is this capability restricted to MIPS R2 and higher?
> IRIX kernels and the 'sash' tool were both relocatable on the older SGI
> platforms.  Does the feature, as implemented, rely on R2-specific
> instructions/capabilities, or only due to lack of testing on pre-R2 hardware?
>
> --J
>
