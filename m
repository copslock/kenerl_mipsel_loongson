Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 23:29:29 +0100 (BST)
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:36502 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021917AbXFEW31 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 23:29:27 +0100
Received: (qmail 37580 invoked from network); 5 Jun 2007 22:29:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=UOCXJCTFAVBpcAnmYnvJnzuFfOkeCIEDyxlZrnifeqGNh+V1uxs26qqc5owx25cNQ4Ss3cU8jwWLu1T1vqGkQCpTjHMXYdaD1uCLyTobr0PmJ6FWDE2j2aqcvuZ1l+pjbzpwA7VuppWvoYx4XxD0ugvMMBJ9TR+WacaYfr1RMk4=  ;
Received: from unknown (HELO adsl-69-226-248-13.dsl.pltn13.pacbell.net) (david-b@pacbell.net@69.226.212.132 with login)
  by smtp109.sbc.mail.mud.yahoo.com with SMTP; 5 Jun 2007 22:29:18 -0000
X-YMail-OSG: AtTQ7CUVM1lNabwFvJm1ZisN0mUCrvaVSmfX34xcIG3AXXxzwMjaZMn2KjvRB0Kpd6dTlWOEnw--
Received: by adsl-69-226-248-13.dsl.pltn13.pacbell.net (Postfix, from userid 500)
	id B61BD230C66; Tue,  5 Jun 2007 15:28:53 -0700 (PDT)
Date:	Tue, 05 Jun 2007 15:28:53 -0700
From:	David Brownell <david-b@pacbell.net>
To:	stjeanma@pmc-sierra.com, stern@rowland.harvard.edu
Subject: Re: [linux-usb-devel] [PATCH 11/12] drivers: PMC MSP71xx USB driver
Cc:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	gregkh@suse.de, akpm@linux-foundation.org
References: <Pine.LNX.4.44L0.0706051706550.4003-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0706051706550.4003-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20070605222853.B61BD230C66@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

> This does far too much to be a single patch.  It needs to be broken up.

Agreed.  300+ KB is not digestible at all.

Most maintainers like to see patches on the order of 10 KB; that much
is easy to review.  New drivers are rarely that small of course, but
that should give you some understanding of just how excessive this is...

But the fact that this one "driver" patch touched so many other files
outside its own directory is a dead giveaway that it's got something
pretty wrong...

- Dave
