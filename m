Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2003 03:39:31 +0100 (BST)
Received: from MAIL.13thfloor.at ([IPv6:::ffff:212.16.62.51]:14720 "EHLO
	mail.13thfloor.at") by linux-mips.org with ESMTP
	id <S8225465AbTJDCj2>; Sat, 4 Oct 2003 03:39:28 +0100
Received: by mail.13thfloor.at (Postfix, from userid 1001)
	id 12663510AA6; Sat,  4 Oct 2003 04:39:21 +0200 (CEST)
Date: Sat, 4 Oct 2003 04:39:21 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: vserver@solucorp.qc.ca
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	ultralinux@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@linuxia64.org
Subject: Syscall on Linux Platforms ...
Message-ID: <20031004023921.GA5807@DUK2.13thfloor.at>
Mail-Followup-To: vserver@solucorp.qc.ca,
	linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	ultralinux@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@linuxia64.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <herbert@13thfloor.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@13thfloor.at
Precedence: bulk
X-list: linux-mips


The Linux-VServer Project recently got one syscall
reserved for i386, and, as this project is considered 
platform independant, would like to do similar for 
other platforms ...

we know that vservers work or at least where tested 
on the following platforms i386, x86_64, ppc, sparc, 
and sparc64 ...

please advice how to proceed ...

as I'm not subscribed to any of those lists (yet), 
please CC me, or the vserver mailing list ...

thanks in advance,
Herbert 



# This patch includes the following deltas:
#                  ChangeSet    1.1378  -> 1.1379
#       arch/i386/kernel/entry.S        1.68    -> 1.69
#

 entry.S |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S  Wed Oct  1 11:14:26 2003
+++ b/arch/i386/kernel/entry.S  Wed Oct  1 11:14:26 2003
@@ -879,5 +879,6 @@
       	.long sys_tgkill        /* 270 */
       	.long sys_utimes
        .long sys_fadvise64_64
+	.long sys_ni_syscall    /* sys_vserver */

 nr_syscalls=(.-sys_call_table)/4
