Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 13:41:56 +0000 (GMT)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:59166
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225263AbUCYNly>; Thu, 25 Mar 2004 13:41:54 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 25 Mar 2004 13:41:52 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i2PDff1x051663;
	Thu, 25 Mar 2004 22:41:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 25 Mar 2004 22:42:29 +0900 (JST)
Message-Id: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: missing flush_dcache_page call in 2.4 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I noticed that reading from file with mmap sometimes return wrong data
on 2.4 kernel.

This is a test program to reproduce the problem.

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
	int fd;
	struct stat st;
	volatile unsigned char *buf;
	unsigned char dat, dat2;

	fd = open(argv[1], O_RDONLY);
	fstat(fd, &st);
	buf = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);

	dat = *buf;
	cacheflush(0, 0, 0);	// flush cache all
	dat2 = *buf;

	printf("dat %x dat2 %x\n", dat, dat2);

	munmap(buf, st.st_size);
	close(fd);
	return 0;
}

'dat' and 'dat2' should be same value, of course.  But sometimes they
differ.

This problem often happens when I read a file in IDE disk (using PIO)
just after mounted.  I saw same problem on a mtd JFFS2 partition a
while ago.  I suppose it is not a filesystem/driver problem.

After calling cacheflush(), it returns correct data.  And I checked
the virtual/physical address return by the mmap and found they had
different 'color' when the problem happens.  So it seems to be a
virtual aliasing problem.

Documentation/cachetlb.txt says:

  void flush_dcache_page(struct page *page)

	Any time the kernel writes to a page cache page, _OR_
	the kernel is about to read from a page cache page and
	user space shared/writable mappings of this page potentially
	exist, this routine is called.

But flush_dcache_page() did not called between the mmap() call and the
cacheflush() call.

Tracing the code path on the page fault, I noticed filemap_nopage()
uses old flush_page_to_ram() interface.  I suppose flush_dcache_page()
should be called in same place.  Is this a correct fix?


--- linux-2.4.25/mm/filemap.c	Wed Feb 18 22:36:32 2004
+++ linux/mm/filemap.c	Thu Mar 25 21:19:29 2004
@@ -2111,6 +2111,7 @@
 	 * and possibly copy it over to another page..
 	 */
 	mark_page_accessed(page);
+	flush_dcache_page(page);
 	flush_page_to_ram(page);
 	return page;
 
---
Atsushi Nemoto
