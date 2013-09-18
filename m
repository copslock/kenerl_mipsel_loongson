Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 09:55:59 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3064 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824820Ab3IRHzzaymzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 09:55:55 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 18 Sep 2013 00:45:03 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 18 Sep 2013 00:55:38 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 18 Sep 2013 00:55:37 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1109F246A4; Wed, 18
 Sep 2013 00:55:36 -0700 (PDT)
Date:   Wed, 18 Sep 2013 13:29:41 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Message-ID: <20130918075940.GA10328@jayachandranc.netlogicmicro.com>
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
 <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
 <20130917212113.GI22468@linux-mips.org>
MIME-Version: 1.0
In-Reply-To: <20130917212113.GI22468@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7E2786752L885817588-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Tue, Sep 17, 2013 at 11:21:13PM +0200, Ralf Baechle wrote:
> On Sun, Aug 11, 2013 at 05:10:17PM +0530, Jayachandran C wrote:
> 
> > Allow usage of scratch register for current pgd even when
> > MIPS_PGD_C0_CONTEXT is not configured. MIPS_PGD_C0_CONTEXT is set
> > for 64r2 platforms to indicate availability of Xcontext for saving
> > cpuid, thus freeing Context to be used for saving PGD. This option
> > was also tied to using a scratch register for storing PGD.
> > 
> > This commit will allow usage of scratch register to store the current
> > pgd if one can be allocated for the platform, even when
> > MIPS_PGD_C0_CONTEXT is not set. The cpuid will be kept in the CP0
> > Context register in this case.
> > 
> > The code to store the current pgd for the TLB miss handler is now
> > generated in all cases. When scratch register is available, the PGD
> > is also stored in the scratch register.
> 
> This patch breaks the build for almost all platforms.  Amusingly it
> doesn't break Cavium however which is why I didn't notice it right away.
> 
> The build error is the same for all platforms:
> 
> [...]
>   LD      init/built-in.o
> arch/mips/built-in.o: In function `per_cpu_trap_init':
> (.text+0x80e4): undefined reference to `tlbmiss_handler_setup_pgd'
> arch/mips/built-in.o: In function `build_setup_pgd':
> tlbex.c:(.text+0xe31c): undefined reference to `tlbmiss_handler_setup_pgd'
> tlbex.c:(.text+0xe328): undefined reference to `tlbmiss_handler_setup_pgd'
> tlbex.c:(.text+0xe324): undefined reference to `tlbmiss_handler_setup_pgd_end'
> tlbex.c:(.text+0xe32c): undefined reference to `tlbmiss_handler_setup_pgd_end'
> kernel/built-in.o: In function `__schedule':
> core.c:(.sched.text+0x1b74): undefined reference to `tlbmiss_handler_setup_pgd'
> mm/built-in.o: In function `use_mm':
> (.text+0x1a530): undefined reference to `tlbmiss_handler_setup_pgd'
> fs/built-in.o: In function `flush_old_exec':
> (.text+0x8da8): undefined reference to `tlbmiss_handler_setup_pgd'
> make[2]: *** [vmlinux] Error 1
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> make: Leaving directory `/home/ralf/src/linux/obj/cobalt-build'
> 
> I'm reverting the patch now.

The commit 774b6175 "MIPS: tlbex: Guard tlbmiss_handler_setup_pgd" that
went into 3.12-rc1 takes out tlbmiss_handler_setup_pgd definition when
CONFIG_MIPS_PGD_C0_CONTEXT is not defined. That clashes with this change
and caused the failure.

You can revert 774b6175 before applying this and things should work, I
had tested it with qemu on malta as well as on XLP.

JC.
