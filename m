Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2004 16:39:28 +0100 (BST)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:29164 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225548AbUFQPjY>; Thu, 17 Jun 2004 16:39:24 +0100
Received: from [192.168.1.3] (c-24-6-196-202.client.comcast.net[24.6.196.202])
          by comcast.net (rwcrmhc13) with SMTP
          id <2004061715391701500t078ne>; Thu, 17 Jun 2004 15:39:17 +0000
Subject: CVS access
From: Prasanth Kumar <lunix@comcast.net>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Date: Thu, 17 Jun 2004 08:39:16 -0700
Message-Id: <1087486756.3789.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Return-Path: <lunix@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lunix@comcast.net
Precedence: bulk
X-list: linux-mips

I'm trying to cross compile a Linux MIPS kernel on my x86 system to put
into an embedded board. I'm encountering some problems with compilation
of the stock kernels 2.4.x and 2.6.x from kernel.org. Perhaps the ones
on linux-mips.org are easier to compile. However I cannot get CVS access
following the directions on the linux-mips.org website. It says
authorization failed. Am I doing something incorrectly?

[bubba]$ cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs loginLogging
in to :pserver:cvs@ftp.linux-mips.org:2401/home/cvs
CVS password:
cvs login: authorization failed: server ftp.linux-mips.org rejected
access to /home/cvs for user cvs

-- 
Regards,
Prasanth
