Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EH73j00730
	for linux-mips-outgoing; Fri, 14 Sep 2001 10:07:03 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EH71e00727
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 10:07:01 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id DE63A125C3; Fri, 14 Sep 2001 10:07:00 -0700 (PDT)
Date: Fri, 14 Sep 2001 10:07:00 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: PATCH: Fix offset of mmap
Message-ID: <20010914100700.A16047@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We should check if offset of mmap is on the page boundary.


H.J.
---
--- /tmp/tmp.20947.0	Fri Sep 14 10:05:33 2001
+++ arch/mips/kernel/syscall.c	Fri Sep 14 10:05:08 2001
@@ -82,6 +82,8 @@ out:
 asmlinkage unsigned long old_mmap(unsigned long addr, size_t len, int prot,
                                   int flags, int fd, off_t offset)
 {
+	if (offset & ~PAGE_MASK)
+		return -EINVAL;
 	return do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
 }
 
