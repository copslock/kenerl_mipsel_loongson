Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 20:58:10 +0000 (GMT)
Received: from h0000c06cf87e.ne.client2.attbi.com ([IPv6:::ffff:24.34.109.122]:43787
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225393AbTLIU6J>; Tue, 9 Dec 2003 20:58:09 +0000
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id hB9Kw6G25309
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 15:58:07 -0500
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id hB9Kw6t31608
	for <linux-mips@linux-mips.org>; Tue, 9 Dec 2003 15:58:06 -0500
Message-Id: <200312092058.hB9Kw6t31608@p2.parker.boston.ma.us>
To: linux-mips@linux-mips.org
Subject: to_tm() in kernel/time.c?
X-Mailer: MH-E 7.2; nmh 1.0.4; GNU Emacs 20.7.1
Date: Tue, 09 Dec 2003 15:58:06 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@parker.boston.ma.us
Precedence: bulk
X-list: linux-mips


Can anyone tell me if to_tm() in kernel/time.c returns months as 0-11?
(in the current mips tree, that is)

I'm curious if the to_tm() in the ppc tree is the same as the to_tm()
in the mips tree.  In the ppc tree it returns 1-12.

-brad
