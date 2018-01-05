Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 11:08:56 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:46211 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAEKItPjLLb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 11:08:49 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 10:08:39 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Jan 2018
 02:08:37 -0800
Date:   Fri, 5 Jan 2018 10:08:36 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: Is MIPS affected by the recent KAISER/KASLR/KPTI/etc mess?
Message-ID: <20180105100835.GP27409@jhogan-linux.mipstec.com>
References: <fa392a88-9968-14f4-73e3-0d8bafad97df@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <fa392a88-9968-14f4-73e3-0d8bafad97df@gentoo.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1515146918-298552-12614-109080-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188673
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Thu, Jan 04, 2018 at 07:06:39PM -0500, Joshua Kinard wrote:
> 
> Regarding the KAISER/KASLR/KPTI work to mitigate the recently-announced
> "Spectre" and "Meltdown" issues in x86/x64 and some Arm processors, does anyone
> know how vulnerable MIPS processors might be?
> 
> My initial guess is Spectre might apply, since MIPS CPUs have supported
> speculative execution as far back as the R10000, and even the R10K manual
> contained an entire section on "The side-effects of speculative execution", for
> SGI's non-coherent platforms (IP28, IP32).  But MIPS is a varied ecosystem of
> CPUs, so if the arch is vulnerable, there might be specific MIPS CPU types that
> are not vulnerable.
> 
> I am also uncertain if the way MIPS lays out its address space, with specific
> ranges for kernel mode, supervisor mode (unused), and user mode, makes this a
> non-issue.
> 
> Thoughts?

I'm not a hardware engineer so don't quote me on this, and have only
briefly tried to detect leaked kernel data on a couple of recent cores,
but I'd be surprised if any MIPS cores are vulnerable to kernel data
leak, simply because the static segments (ignoring EVA) encode the
minimum privilege. Hardware should be able to test privilege very easily
compared to when that data comes from the TLB/page tables, hopefully
before anything can be done speculatively depending on the data that
would be read (but of course that doesn't mean individual cores can't be
broken).

The MIPS segment layout won't help with any leakage of speculative
execution within a privilege level though (e.g. eBPF or javascript
bounds checks).

Cheers
James
