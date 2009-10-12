Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 19:08:46 +0200 (CEST)
Received: from smtp.wp.pl ([212.77.101.1]:8953 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493462AbZJLRIi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 19:08:38 +0200
Received: (wp-smtpd smtp.wp.pl 19780 invoked from network); 12 Oct 2009 19:08:33 +0200
Received: from aaty200.neoplus.adsl.tpnet.pl (HELO [192.168.2.5]) (laurentp@[83.6.6.200])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with RC4-MD5 encrypted SMTP
          for <linux-mips@linux-mips.org>; 12 Oct 2009 19:08:33 +0200
Message-ID: <4AD36290.1040709@wp.pl>
Date:	Mon, 12 Oct 2009 19:08:32 +0200
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.8.1.17) Gecko/20080829 SeaMonkey/1.1.12
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: gcc/binutils versions
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000 [kdNE]                               
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

Hi,

I want to make some modules for an existing system. (Manta "Media
Center" HDD-2000 aka Shenzen Mele HMC-35HD).
What I have is an official firmware, it looks to be Linux 2.6.12.6-VENUS
for MIPS, uClibc 0.9.28

What is missing to me is support to ext2/3 filesystems (believe or not
only squashfs, jffs2, ntfs and vfat).

Now my questions:

a). how to find what version of binutils/gcc i need? (for setting up
buildroot)
b). how to find kernel configuration I need to supply to compile (apart
setting CONFIG_EXT3_FS=m)?

W.Piotrzkowski
