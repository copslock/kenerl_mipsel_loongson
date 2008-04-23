Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 17:06:49 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:41449 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28584158AbYDWQGr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 17:06:47 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id DA5F05BC016;
	Wed, 23 Apr 2008 19:06:46 +0300 (EEST)
Date:	Wed, 23 Apr 2008 19:06:07 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Roland McGrath <roland@redhat.com>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips ptrace compat build error
Message-ID: <20080423160607.GS28933@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit e16b27816462de700f9508d86954410c41105dc2
(ptrace: compat_ptrace_request siginfo) causes
the following build error with CONFIG_COMPAT=y
on mips:

<--  snip   -->

...
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `$L181':
ptrace.c:(.text+0x1d380): undefined reference to `copy_siginfo_from_user32'
ptrace.c:(.text+0x1d380): relocation truncated to fit: R_MIPS_26 against `copy_siginfo_from_user32'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
