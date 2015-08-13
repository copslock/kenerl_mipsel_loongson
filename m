Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 22:42:55 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:32808 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012193AbbHMUmwVNMUn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 22:42:52 +0200
Received: from [2001:7c0:dc15:72:2db:dfff:fe14:52d] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZPzKq-0006MK-1A; Thu, 13 Aug 2015 22:42:48 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZPzKp-0006UP-3l; Thu, 13 Aug 2015 22:42:47 +0200
Date:   Thu, 13 Aug 2015 22:42:46 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH 6/6] MIPS: net: BPF: Introduce BPF ASM helpers
Message-ID: <20150813204246.GA24857@aurel32.net>
Mail-Followup-To: Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
 <1433415376-20952-7-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433415376-20952-7-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On 2015-06-04 11:56, Markos Chandras wrote:
> This commit introduces BPF ASM helpers for MIPS and MIPS64 kernels.
> The purpose of this patch is to twofold:
> 
> 1) We are now able to handle negative offsets instead of either
> falling back to the interpreter or to simply not do anything and
> bail out.
> 
> 2) Optimize reads from the packet header instead of calling the C
> helpers
> 
> Because of this patch, we are now able to get rid of quite a bit of
> code in the JIT generation process by using MIPS optimized assembly
> code. The new assembly code makes the test_bpf testsuite happy with
> all 60 test passing successfully compared to the previous
> implementation where 2 tests were failing.
> Doing some basic analysis in the results between the old
> implementation and the new one we can obtain the following
> summary running current mainline on an ER8 board (+/- 30us delta is
> ignored to prevent noise from kernel scheduling or IRQ latencies):
> 
> Summary: 22 tests are faster, 7 are slower and 47 saw no improvement
> 
> with the most notable improvement being the tcpdump tests. The 7 tests
> that seem to be a bit slower is because they all follow the slow path
> (bpf_internal_load_pointer_neg_helper) which is meant to be slow so
> that's not a problem.
> 
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Alexei Starovoitov <ast@plumgrid.com>
> Cc: Daniel Borkmann <dborkman@redhat.com>
> Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> I have uploaded the script and the bpf result files in my LMO webspace
> in case you want to have a look. I didn't paste them in here because they
> are nearly 200 lines. Simply download all 3 files and run './bpf_analysis.py'

This patch relies on R2 instructions, and thus the Linux kernel fails to
build when targetting non-R2 CPUs. See for example:

https://buildd.debian.org/status/fetch.php?pkg=linux&arch=mipsel&ver=4.2%7Erc6-1%7Eexp1&stamp=1439480000

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
