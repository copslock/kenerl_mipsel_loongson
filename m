Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 04:31:05 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:31616 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224908AbVAFEa7>; Thu, 6 Jan 2005 04:30:59 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CmPIO-0000wb-9n
	for <linux-mips@linux-mips.org>; Wed, 05 Jan 2005 22:30:48 -0600
Message-ID: <41DCC038.9000307@realitydiluted.com>
Date: Wed, 05 Jan 2005 22:36:08 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [RFC] Add 4/8 bytes to 'struct k_sigaction'...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

In order support easy building of IRIX emulation support as either
a module or statically, I would like to simply have the 'sa_restorer'
function pointer be defined for all big endian architectures. This
means extra storage space, but I wanted comments first. The problem
is that if you configure for IRIX, build and then decide that you
want to build it as a module, CONFIG_BINFMT_IRIX_MODULE gets defined
instead of CONFIG_BINFMT_IRIX and hence 'signal.h' changes and the
whole kernel has to be rebuilt. If we simply have it be defined for
big endian architectures regardless, then there is no recompile. Al
Viro did comment that Christoph Hellwig may be moving stuff like
'struct sighand_struct' out of 'sched.h' along with some other things
which might make this below a non-issue, but that is far off. Comments
before I commit?

-Steve

Index: signal.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/signal.h,v
retrieving revision 1.17
diff -u -r1.17 signal.h
--- signal.h	30 Sep 2003 14:27:29 -0000	1.17
+++ signal.h	6 Jan 2005 04:21:58 -0000
@@ -135,7 +135,7 @@

  struct k_sigaction {
  	struct sigaction sa;
-#ifdef CONFIG_BINFMT_IRIX
+#if !defined(CONFIG_CPU_LITTLE_ENDIAN)
  	void		(*sa_restorer)(void);
  #endif
  };
