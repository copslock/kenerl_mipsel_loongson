Received:  by oss.sgi.com id <S42213AbQF3QPp>;
	Fri, 30 Jun 2000 09:15:45 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:38666 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42210AbQF3QPY>;
	Fri, 30 Jun 2000 09:15:24 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id JAA32328
	for linux-mips@oss.sgi.com; Fri, 30 Jun 2000 09:15:24 -0700
Date:   Fri, 30 Jun 2000 09:15:24 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     linux-mips@oss.sgi.com
Subject: glibc 2.2 based root fs available
Message-ID: <20000630091524.A32081@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is the Simple MIPS/Linux 0.2a 'pre-Alpha and we're not joking'
release. You can obtain the kernel from
ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/kernels/vmlinux-24test2
and the filesystem from .../mips-linux/testing/core-0.2a.tar.gz. This
is a big-endian filesystem and the kernel is for SGI IP22.

This is a developer release, mainly to help shake out bugs in the
toolchain and glibc. This release will not run properly on kernel
2.2. Mandatory release notes are at
.../mips-linux/testing/README.core-02a. There is still a good deal of
functionality missing, including the networking utilities, ext2fs
tools, and a c++ compiler. This release includes the libemptysymbol
hack to work around the "undefined symbol: " problem until it's fixed.

Bug reports accepted but in general nothing is patched so you may also
wish to send reports to the appropriate maintainers.

Happy hacking!

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
