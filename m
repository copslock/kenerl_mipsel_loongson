Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 20:15:38 +0100 (BST)
Received: from p508B7216.dip.t-dialin.net ([IPv6:::ffff:80.139.114.22]:21728
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225212AbTDMTPh>; Sun, 13 Apr 2003 20:15:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3DJFVU05305;
	Sun, 13 Apr 2003 21:15:31 +0200
Date: Sun, 13 Apr 2003 21:15:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brm@murphy.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.4] trivial secondary cache probe fix for R5000/NEVADA
Message-ID: <20030413211531.A5000@linux-mips.org>
References: <E194mQF-0004aB-00@brian.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E194mQF-0004aB-00@brian.localnet>; from brm@murphy.dk on Sun, Apr 13, 2003 at 08:41:47PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 13, 2003 at 08:41:47PM +0200, Brian Murphy wrote:

> despite the comment there are at least two more processors this 
> probe is needed/works for.

I don't think we want to use this frightening jewel for more than necessary.
On the R5000 the secondary cache can nicely be probed by looking at the
c0_config register.  c0_config.sc=0 indicates a second level cache is
present, setting the se bit in the same register enables it and the two
ss bits contain the size - doesn't that sound so much nicer than the
insane fragile stunt necessary for the R4000?

  Ralf
