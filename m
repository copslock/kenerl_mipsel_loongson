Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 02:51:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:31110 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038426AbXBKCum (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Feb 2007 02:50:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1AL60vM010327;
	Sat, 10 Feb 2007 21:08:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1AL5vcK010326;
	Sat, 10 Feb 2007 21:05:57 GMT
Date:	Sat, 10 Feb 2007 21:05:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:	Davide Libenzi <davidel@xmailserver.org>,
	linux-mips@linux-mips.org, David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>, Andi Kleen <ak@suse.de>
Subject: Re: -mm merge plans for 2.6.21
Message-ID: <20070210210557.GA9116@linux-mips.org>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org> <1171042535.29713.96.camel@pmac.infradead.org> <20070209134516.2367a7aa.akpm@linux-foundation.org> <1171058342.29713.136.camel@pmac.infradead.org> <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com> <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 10, 2007 at 11:22:05AM +0100, Heiko Carstens wrote:

> Which remembers me that I think that MIPS is using the non-compat version
> of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
> syscall for some reason. Dunno.

Which reminds me that x86_64 i386 compat doesn't wire up sys_epoll_pwait ;-)

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index b4aa875..5993262 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -718,4 +718,5 @@ ia32_sys_call_table:
 	.quad compat_sys_vmsplice
 	.quad compat_sys_move_pages
 	.quad sys_getcpu
+	.quad sys_epoll_pwait
 ia32_syscall_end:		
