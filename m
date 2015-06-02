Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 10:41:41 +0200 (CEST)
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:34445 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006905AbbFBIlh6vO14 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 10:41:37 +0200
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
        by resqmta-ch2-11v.sys.comcast.net with comcast
        id bLhT1q0022LrikM01LhTRa; Tue, 02 Jun 2015 08:41:27 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-12v.sys.comcast.net with comcast
        id bLhR1q00E42s2jH01LhR3Q; Tue, 02 Jun 2015 08:41:27 +0000
Message-ID: <556D6C31.3070500@gentoo.org>
Date:   Tue, 02 Jun 2015 04:41:21 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org
CC:     benh@kernel.crashing.org, markos.chandras@imgtec.com,
        macro@linux-mips.org, Steven.Hill@imgtec.com,
        alexander.h.duyck@redhat.com, davem@davemloft.net
Subject: Re: [PATCH 0/3] MIPS: SMP memory barriers: lightweight sync, acquire-release
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
In-Reply-To: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433234487;
        bh=O8elMqv/diYEQp0pqf9LBH1QsJcgXsZukqfqvOFFbr4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=uYest2VWk1MC8EiiQ1Oy3YPupT4DSuAhWQ7kMZJH+WS46vO6NFAO4jwXob8sSeHS2
         dJ/3OTgkbyukoq7Kjbw4HF4kf77Wo1dkHOTftgVWtT1cQCMZIa58pd+mrclHiHQh3L
         bA8dtVPUwP7UBpvIJ5K1K8qS0pNalxxGehgjWmWZBMgZi+eeHXVnfIy/AHkKzKY/R2
         JAXAjAH1BiYHwKykusDyBYABPjZEKIs1CZSkxYX/J41zM0C6CLWqDxRQ1wQltaU1UU
         fb0/so2tbQ2M7jGwGJtiYYNrPulxXemHrzALOdP4gNJ7fYRpzBaJdnsQS1nYaST7Me
         YlfO3LU10H32g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/01/2015 20:09, Leonid Yegoshin wrote:
> The following series implements lightweight SYNC memory barriers for SMP Linux
> and a correct use of SYNCs around atomics, futexes, spinlocks etc LL-SC loops -
> the basic building blocks of any atomics in MIPS.
> 
> Historically, a generic MIPS doesn't use memory barriers around LL-SC loops in
> atomics, spinlocks etc. However, Architecture documents never specify that LL-SC
> loop creates a memory barrier. Some non-generic MIPS vendors already feel
> the pain and enforces it. With introduction in a recent out-of-order superscalar
> MIPS processors an aggressive speculative memory read it is a problem now.
> 
> The generic MIPS memory barrier instruction SYNC (aka SYNC 0) is something
> very heavvy because it was designed for propogating barrier down to memory.
> MIPS R2 introduced lightweight SYNC instructions which correspond to smp_*()
> set of SMP barriers. The description was very HW-specific and it was never
> used, however, it is much less trouble for processor pipelines and can be used
> in smp_mb()/smp_rmb()/smp_wmb() as is as in acquire/release barrier semantics.
> After prolonged discussions with HW team it became clear that lightweight SYNCs
> were designed specifically with smp_*() in mind but description is in timeline
> ordering space.
> 
> So, the problem was spotted recently in engineering tests and it was confirmed
> with tests that without memory barrier load and store may pass LL/SC
> instructions in both directions, even in old MIPS R2 processors.
> Aggressive speculation in MIPS R6 and MIPS I5600 processors adds more fire to
> this issue.
> 
> 3 patches introduces a configurable control for lightweight SYNCs around LL/SC
> loops and for MIPS32 R2 it was allowed to choose an enforcing SYNCs or not
> (keep as is) because some old MIPS32 R2 may be happy without that SYNCs.
> In MIPS R6 I chose to have SYNC around LL/SC mandatory because all of that
> processors have an agressive speculation and delayed write buffers. In that
> processors series it is still possible the use of SYNC 0 instead of
> lightweight SYNCs in configuration - just in case of some trouble in
> implementation in specific CPU. However, it is considered safe do not implement
> some or any lightweight SYNC in specific core because Architecture requires
> HW map of unimplemented SYNCs to SYNC 0.

How useful might this be for older hardware, such as the R10k CPUs?  Just
fallbacks to the old sync insn?

--J
