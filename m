Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 18:07:00 +0200 (CEST)
Received: from p508B48B4.dip.t-dialin.net ([80.139.72.180]:7068 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122978AbSITQG7>; Fri, 20 Sep 2002 18:06:59 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8KG6qI32633
	for linux-mips@linux-mips.org; Fri, 20 Sep 2002 18:06:52 +0200
Date: Fri, 20 Sep 2002 18:06:51 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: CVS server moved
Message-ID: <20020920180651.A32600@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I moved the cvs archive to ftp.linux-mips.org two days ago.  If you already
have a checked out copy, here is how to avoid having to checkout again:

  cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login

The password for anonymous cvs is cvs.

   cd <your-checked-out-copy>
   find . -name Root | while read n; do
       echo ftp.linux-mips.org:/home/cvs > $n
   done

There are still a few loose bits but here and there but those should not
become visible to normal users.

  Ralf
