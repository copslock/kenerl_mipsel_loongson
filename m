Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2009 18:24:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:39615 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21368289AbZCXSYX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2009 18:24:23 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2OIOJ6Q022312;
	Tue, 24 Mar 2009 19:24:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2OIOI9j022310;
	Tue, 24 Mar 2009 19:24:18 +0100
Date:	Tue, 24 Mar 2009 19:24:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-arch@vger.kernel.org
Cc:	dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org
Subject: Sign extension problem in llseek(2)
Message-ID: <20090324182418.GC6509@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

In fs/read_write.c:

SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
                unsigned long, offset_low, loff_t __user *, result,
                unsigned int, origin)
...
	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
                        origin);
 
On a 64-bit system that define CONFIG_HAVE_SYSCALL_WRAPPERS SYSCALL_DEFINEx
will truncate long arguments to 32-bit and on some architectures such as
MIPS sign-extended to 64-bit again.  On such architectures passing a
value with bit 31 in offset_low set will result in a huge 64-bit offset
being passed to vfs_llseek() and it failiing with EINVAL.

MIPS is affected by this issue.  Other 64-bit architectures which also
set CONFIG_HAVE_SYSCALL_WRAPPERS and __ARCH_WANT_SYS_LLSEEK are PowerPC,
S390 and sparc.

The issue was discovered on Debian's MIPS infrastructure machines running
e2fsck:

[...]
                          This was noticed on one of the Debian
infrastructure machines where, after an upgrade, e2fsck began failing
with errors like:

  Error reading block 524290 (Invalid argument) while getting next inode
  from scan.  Ignore error<y>?
[...]

  Ralf
