Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2004 17:20:44 +0100 (BST)
Received: from p508B6C63.dip.t-dialin.net ([IPv6:::ffff:80.139.108.99]:29210
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225313AbUFIQUk>; Wed, 9 Jun 2004 17:20:40 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i59GKdIO028740;
	Wed, 9 Jun 2004 18:20:39 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i59GKc1I028739;
	Wed, 9 Jun 2004 18:20:38 +0200
Date: Wed, 9 Jun 2004 18:20:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Anonymous CVS server offline again
Message-ID: <20040609162038.GA28419@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

today another bunch of exploitable security holes in CVS was published.
I therefore disabled anonymous access via pserver.  As a workaround
you can still use rsync to mirror the cvs archive, then do a checkout
or update from the mirror.  This may take some modification to the
CVS/Repository and CVS/Root files.

Sorry for the inconvenience,

  Ralf
