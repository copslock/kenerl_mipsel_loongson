Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jun 2003 15:12:02 +0100 (BST)
Received: from p508B6123.dip.t-dialin.net ([IPv6:::ffff:80.139.97.35]:11496
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbTFUOMA>; Sat, 21 Jun 2003 15:12:00 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5LEBvbv008504;
	Sat, 21 Jun 2003 16:11:57 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5LEBupx008503;
	Sat, 21 Jun 2003 16:11:56 +0200
Date: Sat, 21 Jun 2003 16:11:55 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brm@murphy.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] ide.h fix(es)
Message-ID: <20030621141155.GA8315@linux-mips.org>
References: <E19TTca-0007WN-00@brian.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19TTca-0007WN-00@brian.localnet>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 20, 2003 at 11:40:36PM +0200, Brian Murphy wrote:

> this fixes some problems with undefined symbols in IDE and also
> seems to work (as far as my limited testing can go at the moment).
> Sorry if I was out of order in removing the big endian stuff, 

The big endian stuff was just old code, so from the point you were right
with removing it.  It's not an entirely correct solution though, on some
MIPS IDE systems the OS has to do endianess conversion, on some the
hardware takes care of it.  IDE as a big endian thing that was made
popular through the little endian PC platform has funny endianess issues
at times ...

  Ralf
