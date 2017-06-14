Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 11:49:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55478 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992213AbdFNJtFAsjF3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 11:49:05 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5E9mxHZ003214;
        Wed, 14 Jun 2017 11:49:00 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5E9mw1j003213;
        Wed, 14 Jun 2017 11:48:58 +0200
Date:   Wed, 14 Jun 2017 11:48:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v2 0/5] MIPS: Implement eBPF JIT.
Message-ID: <20170614094858.GC31492@linux-mips.org>
References: <20170613222847.7122-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613222847.7122-1-david.daney@cavium.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58446
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

On Tue, Jun 13, 2017 at 03:28:42PM -0700, David Daney wrote:

> Changes in v2:
> 
>   - Squash a couple of the uasm cleanups.
> 
>   - Make insn_table_MM const (suggested by Matt Redfearn)
> 
>   - Put the eBPF in its own source file (should fix build
>     warnings/errors on 32-bit kernel builds).
> 
>   - Use bpf_jit_binary_alloc() (suggested by Daniel Borkmann)
> 
>   - Implement tail calls.
> 
>   - Fix system call tracing to extract arguments for
>     kprobe/__seccomp_filter() tracing (perhaps not really part the the
>     JIT, but necessary to have fun with the samples/bpf programs).
> 
> Most things in samples/bpf work, still working on the incantations to
> build tools/testing/selftests/bpf/ ... 
> 
> 
> >From v1:
> 
> The first three patches improve MIPS uasm in preparation for use by
> the JIT.  Then the eBPF JIT implementation.
> 
> I am CCing netdev@ and the BPF maintainers for their comments, but
> would expect Ralf to merge via the MIPS tree if and when it all looks
> good.

Thanks, applied after fixing a minor conflict in arch/mips/Kconfig.

  Ralf
