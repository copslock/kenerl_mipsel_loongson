Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 17:42:17 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:56812 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225199AbTDKQmP>;
	Fri, 11 Apr 2003 17:42:15 +0100
Received: from mahes.visi.com (mahes.visi.com [209.98.98.96])
	by mail-out.visi.com (Postfix) with ESMTP id 16A6F36CD
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2003 11:42:10 -0500 (CDT)
Received: from mahes.visi.com (localhost [127.0.0.1])
	by mahes.visi.com (8.12.9/8.12.5) with ESMTP id h3BGg99R040762
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2003 11:42:09 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mahes.visi.com (8.12.9/8.12.5/Submit) id h3BGg8Ao040761
	for linux-mips@linux-mips.org; Fri, 11 Apr 2003 16:42:08 GMT
X-Authentication-Warning: mahes.visi.com: www set sender to erik@greendragon.org using -f
Received: from temns.guidant.com (temns.guidant.com [12.145.46.162]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Fri, 11 Apr 2003 16:42:08 +0000
Message-ID: <1050079328.3e96f060dd3cd@my.visi.com>
Date: Fri, 11 Apr 2003 16:42:08 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: linux-mips@linux-mips.org
Subject: Kernel build on Irix w/gcc-fw, Irix as/ld?
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 12.145.46.162
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips



Hi all;

Has anyone successfully built a kernel under Irix, using the freeware GCC and
the standard Irix as/ld tools?  Just wondering off the top of my head, I would
think the Irix tools would have less bugs for 64 bit code than the current
binutils are reputed to have.  I have a set of licensed compilers coming for
another project so I could possibly use those too.

Just curious,

Erik




-- 
Erik J. Green
erik@greendragon.org
