Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 21:36:01 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:57509 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1103085AbYDDTf5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 21:35:57 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m34JZFB4006337
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2008 12:35:15 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m34JZqLn008210;
	Fri, 4 Apr 2008 20:35:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m34JZpRK008208;
	Fri, 4 Apr 2008 20:35:51 +0100
Date:	Fri, 4 Apr 2008 20:35:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make KGDB compile on UP
Message-ID: <20080404193551.GA5959@linux-mips.org>
References: <200803202059.37857.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803202059.37857.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 20, 2008 at 08:59:34PM +0300, Sergei Shtylyov wrote:

> Building UP kernel with KGDB enabled produces the following errors and warning
> (fatal due to -Werror in arch/mips/kernel/Makefile):
> 
> In file included from arch/mips/kernel/gdb-stub.c:142:
> include/asm/smp.h:25:1: "raw_smp_processor_id" redefined
> In file included from include/linux/sched.h:69,
>                  from arch/mips/kernel/gdb-stub.c:126:
> include/linux/smp.h:88:1: this is the location of the previous definition
> In file included from arch/mips/kernel/gdb-stub.c:142:
> include/asm/smp.h:62: error: redefinition of 'smp_send_reschedule'
> include/linux/smp.h:102: error: previous definition of 'smp_send_reschedule' was here
> include/asm/smp.h: In function `smp_send_reschedule':
> include/asm/smp.h:65: error: dereferencing pointer to incomplete type
> arch/mips/kernel/gdb-stub.c: At top level:
> arch/mips/kernel/gdb-stub.c:660: warning: 'kgdb_wait' defined but not used
> 
> Fix the errors by not directly including <asm/smp.h> (which is already included
> by <linux/smp.h>) and the warning by enclosing kgdb_wait() in #ifdef CONFIG_SMP.

Applied, thanks.

  Ralf
