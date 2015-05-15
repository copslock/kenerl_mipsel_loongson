Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 00:42:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61411 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012643AbbEOWmBa4XVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 00:42:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5B98442885CC7;
        Fri, 15 May 2015 23:41:54 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 15 May
 2015 23:39:57 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 15 May
 2015 23:39:56 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 15 May
 2015 15:39:54 -0700
Message-ID: <555675BA.9000700@imgtec.com>
Date:   Fri, 15 May 2015 15:39:54 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <aleksey.makarov@auriga.com>, <james.hogan@imgtec.com>,
        <paul.burton@imgtec.com>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <davidlohr@hp.com>,
        <kirill@shutemov.name>, <akpm@linux-foundation.org>,
        <mingo@kernel.org>
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin> <20150515215320.GI2322@linux-mips.org>
In-Reply-To: <20150515215320.GI2322@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 05/15/2015 02:53 PM, Ralf Baechle wrote:
> On Thu, May 14, 2015 at 06:34:43PM -0700, Leonid Yegoshin wrote:
>
> The order 1 allocation for the PGD are concerning me a little.  On a
> system under even moderate memory pressure that might become a bit of
> a reliability or performance issue.
>
> With 4kB pages we already need order 1 or even 2 allocations for the
> allocation of the stack and some folks have reported that to be an issue
> so we may have to start using the PUD for very large VA spaces.
>
>    Ralf

I don't think it is an issue here - people, who wants to exercise 256 
TERABAIT of memory PER PROCESS may even doesn't note that they have PGD 
= 2 pages. It is definitely not for systems with 4GB physmemory.

I also recommend for low memory to look into CONFIG_COMPACTION, it may 
be a great help for them here, look into mm/vmscan.c, 
in_reclaim_compaction().

Besides that, I defined this feature for 16KB and 64KB pages only, not 
for 4KB.
