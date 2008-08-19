Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:16:08 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:30017 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20030692AbYHSNQB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:16:01 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 19 Aug 2008 13:15:53 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 19 Aug 2008 08:16:51 -0500
Subject: Compilation problem
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 19 Aug 2008 08:16:50 -0500
Message-Id: <1219151811.3948.1.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Is anyone else having trouble compiling the HEAD of LMO?  Under multiple
defconfigs, I get:

In file included from init/main.c:32:
include/linux/security.h: In function ‘security_ptrace_traceme’:
include/linux/security.h:1760: error: ‘parent’ undeclared (first use in
this function)
include/linux/security.h:1760: error: (Each undeclared identifier is
reported only once
include/linux/security.h:1760: error: for each function it appears in.)
make[1]: *** [init/main.o] Error 1

I did a clean clone to be sure that it was not anything leftover in my
working directory.  Is it just me?


-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
