Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 23:21:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47826 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6862036Ab3IQVVSYj02w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 23:21:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8HLLEVZ005896;
        Tue, 17 Sep 2013 23:21:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8HLLDEN005895;
        Tue, 17 Sep 2013 23:21:13 +0200
Date:   Tue, 17 Sep 2013 23:21:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Message-ID: <20130917212113.GI22468@linux-mips.org>
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
 <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37839
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

On Sun, Aug 11, 2013 at 05:10:17PM +0530, Jayachandran C wrote:

> Allow usage of scratch register for current pgd even when
> MIPS_PGD_C0_CONTEXT is not configured. MIPS_PGD_C0_CONTEXT is set
> for 64r2 platforms to indicate availability of Xcontext for saving
> cpuid, thus freeing Context to be used for saving PGD. This option
> was also tied to using a scratch register for storing PGD.
> 
> This commit will allow usage of scratch register to store the current
> pgd if one can be allocated for the platform, even when
> MIPS_PGD_C0_CONTEXT is not set. The cpuid will be kept in the CP0
> Context register in this case.
> 
> The code to store the current pgd for the TLB miss handler is now
> generated in all cases. When scratch register is available, the PGD
> is also stored in the scratch register.

This patch breaks the build for almost all platforms.  Amusingly it
doesn't break Cavium however which is why I didn't notice it right away.

The build error is the same for all platforms:

[...]
  LD      init/built-in.o
arch/mips/built-in.o: In function `per_cpu_trap_init':
(.text+0x80e4): undefined reference to `tlbmiss_handler_setup_pgd'
arch/mips/built-in.o: In function `build_setup_pgd':
tlbex.c:(.text+0xe31c): undefined reference to `tlbmiss_handler_setup_pgd'
tlbex.c:(.text+0xe328): undefined reference to `tlbmiss_handler_setup_pgd'
tlbex.c:(.text+0xe324): undefined reference to `tlbmiss_handler_setup_pgd_end'
tlbex.c:(.text+0xe32c): undefined reference to `tlbmiss_handler_setup_pgd_end'
kernel/built-in.o: In function `__schedule':
core.c:(.sched.text+0x1b74): undefined reference to `tlbmiss_handler_setup_pgd'
mm/built-in.o: In function `use_mm':
(.text+0x1a530): undefined reference to `tlbmiss_handler_setup_pgd'
fs/built-in.o: In function `flush_old_exec':
(.text+0x8da8): undefined reference to `tlbmiss_handler_setup_pgd'
make[2]: *** [vmlinux] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/home/ralf/src/linux/obj/cobalt-build'

I'm reverting the patch now.

  Ralf
