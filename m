Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 14:56:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33972 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991843AbeEDM401dJu9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2018 14:56:26 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id w44Cu9WJ036196;
        Fri, 4 May 2018 14:56:09 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id w44Cu1gb036195;
        Fri, 4 May 2018 14:56:01 +0200
Date:   Fri, 4 May 2018 14:56:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Robert Richter <rric@kernel.org>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504125601.GA30595@linux-mips.org>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
 <20180504102600.GD4493@rric.localdomain>
 <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
 <20180504122750.GE4493@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504122750.GE4493@rric.localdomain>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, May 04, 2018 at 02:27:51PM +0200, Robert Richter wrote:

> On 04.05.18 12:03:12, Matt Redfearn wrote:
> > >As said, oprofile version 0.9.x is still available for cpus that do
> > >not support perf. What is the breakage?
> > 
> > The breakage I originally set out to fix was the MT support in perf.
> > https://www.linux-mips.org/archives/linux-mips/2018-04/msg00259.html
> > 
> > Since the perf code shares so much copied code from oprofile, those same
> > issues exist in oprofile and ought to be addressed. But as newer oprofile
> > userspace does not use the (MIPS) kernel oprofile code, then we could,
> > perhaps, just remove it (as per the RFC). That would break legacy tools
> > (0.9.x) though...
> 
> Those support perf:
> 
>  (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
> 
> Here is the total list of CPU_*:
> 
>  $ git grep -h config.CPU_ arch/mips/ | sort -u | wc -l
>  79
> 
> The comparisation might not be accurate, but at least gives a hint
> that there are many cpus not supporting perf. You would drop profiling
> support at al to them.

The grep results are a bit missleading.  We have many symbols such as
CPU_MIPS32_R1 which describe a particular architecture revision supported
by a CPU.  Others CPU_* symbols are describing particular features or
options so in reality there are far fewer CPU to be supported.  Also
many of the older processors or embedded cores don't have performance
counters at all; for yet other cores presence, number and a few other
details can be configured when synthesizing the RTL so relying on the
CONFIG_* alone won't help.

> If it is too hard to also fix the oprofile code (code duplication
> seems the main issue here), then it would be also ok to blacklist
> newer cpus to enable oprofile kernel code (where it is broken).

  Ralf
