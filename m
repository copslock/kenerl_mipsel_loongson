Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NHLMh02609
	for linux-mips-outgoing; Mon, 23 Apr 2001 10:21:22 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NHLLM02605
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 10:21:21 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP id 1A101F1A9
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 10:20:39 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id C72141F42A; Mon, 23 Apr 2001 10:21:09 -0700 (PDT)
Date: Mon, 23 Apr 2001 10:21:09 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: linux-mips@oss.sgi.com
Subject: New toolchain release
Message-ID: <20010423102109.E6180@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have updated my March 3 toolchain to April 23.  The highlights of
this release are:

	- sjhill's tradmips work
	- fixes to glibc and linux for sjhill's tradmips work :-)
	- Linux 2.4.3 (HEAD) from oss cvs, plus mingo's ext2 corruption 
	  patch
	- gcc 3.0 branch 0422 dated release with the gcse patch and 
	  sjhill's
	- binutils HEAD as of 0421
	- glibc 2.2.3 (HEAD) plus several patches from Maciej, sjhill, 
	  and me.

This has received minimal testing on Indy only.  It builds a bootable
working kernel and fileutils built and run against this glibc works.
This release should support kernel modules, and the sample kernel has
been built accordingly, but this has not been tested by me.

NOTE: This release breaks binary compatibility with previous releases.
Your pre-tradmips binaries and libraries will not work with these.  If
you elect to use these tools for userland development you must
rebootstrap.

The crossdev bundle can be found at
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/cross-all-20010423.tar.

The sample IP22 kernel can be found at
.../simple/kernels/linux-2.4.3-20010422-IP22-4400.tar.gz.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
