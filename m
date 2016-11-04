Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 09:46:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41684 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990509AbcKDIqwZBpwt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 09:46:52 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 51B267ACBAF5D;
        Fri,  4 Nov 2016 08:46:44 +0000 (GMT)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 4 Nov
 2016 08:46:46 +0000
Subject: Re: [PATCH 5/6] MIPS: Ensure bss section ends on a long-aligned
 address
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
References: <20161020202705.3783-1-paul.burton@imgtec.com>
 <20161020202705.3783-6-paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <99627bd7-3dc7-9b9b-0e34-bc4fc251de1a@imgtec.com>
Date:   Fri, 4 Nov 2016 09:46:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161020202705.3783-6-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Paul,

On 20.10.2016 22:27, Paul Burton wrote:
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index d5de675..d1f5401 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -1,3 +1,4 @@
> +#include <asm/asm.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/thread_info.h>

This patch (and specifically including asm/asm.h) causes a build error 
when CONFIG_RELOCATABLE=y as there's a LONG() linker command that gets 
converted to '.[d]word' as a result of including the assembly macros ...

Marcin
