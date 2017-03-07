Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 19:07:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42279 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993896AbdCGSHh3UXsL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 19:07:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A1689C4722E91;
        Tue,  7 Mar 2017 18:07:27 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 7 Mar 2017 18:07:31 +0000
Received: from hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Tue, 7 Mar 2017 18:07:30 +0000
From:   Bryan O'Donoghue <Bryan.ODonoghue@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "stable # v3 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: pm-cps: Drop manual cache-line alignment of
 ready_count
Thread-Topic: [PATCH v2] MIPS: pm-cps: Drop manual cache-line alignment of
 ready_count
Thread-Index: AQHSk6EcaUS8fE8370G9xrHl/kG8HqGJtHOA
Date:   Tue, 7 Mar 2017 18:07:29 +0000
Message-ID: <18ee93a8-8349-c3eb-116b-71dd0703e3a5@imgtec.com>
References: <20170302183128.22883-1-paul.burton@imgtec.com>
 <20170302220240.17615-1-paul.burton@imgtec.com>
In-Reply-To: <20170302220240.17615-1-paul.burton@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.0.240]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3FABAD576F88D049B648ADDCC0B0F8CE@imgtec.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Bryan.ODonoghue@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bryan.ODonoghue@imgtec.com
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

On 02/03/17 22:02, Paul Burton wrote:
> We allocate memory for a ready_count variable per-CPU, which is accessed
> via a cached non-coherent TLB mapping to perform synchronisation between
> threads within the core using LL/SC instructions. In order to ensure
> that the variable is contained within its own data cache line we
> allocate 2 lines worth of memory & align the resulting pointer to a line
> boundary. This is however unnecessary, since kmalloc is guaranteed to
> return memory which is at least cache-line aligned (see
> ARCH_DMA_MINALIGN). Stop the redundant manual alignment.
>
> Besides cleaning up the code & avoiding needless work, this has the side
> effect of avoiding an arithmetic error found by Bryan on 64 bit systems
> due to the 32 bit size of the former dlinesz. This led the ready_count
> variable to have its upper 32b cleared erroneously for MIPS64 kernels,
> causing problems when ready_count was later used on MIPS64 via cpuidle.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 3179d37ee1ed ("MIPS: pm-cps: add PM state entry code for CPS systems")
> Reported-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
> Cc: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> Cc: stable <stable@vger.kernel.org> # v3.16+
> ---
> Changes in v2:
>   - Change kmalloc size to the 4 bytes we use with LL/SC.
>   - Fix mis-spelling of Bryan's name.

For the recored on v2, with this patch and the other patch I've posted 
we appear to boot correctly in SMP* mode on IASIM/I6400

Tested-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
