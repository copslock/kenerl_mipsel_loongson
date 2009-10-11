Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 00:52:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42355 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493010AbZJKWwK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 00:52:10 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9BMrNnK010290;
	Mon, 12 Oct 2009 00:53:24 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9BMrLQn010288;
	Mon, 12 Oct 2009 00:53:21 +0200
Date:	Mon, 12 Oct 2009 00:53:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	mbizon@freebox.fr, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] bcm63xx: only set the proper GPIO overlay settings
Message-ID: <20091011225320.GA10230@linux-mips.org>
References: <200908312028.10931.florian@openwrt.org> <1251750389.10420.24.camel@sakura.staff.proxad.net> <200908312337.36634.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200908312337.36634.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 31, 2009 at 11:37:31PM +0200, Florian Fainelli wrote:

> Le lundi 31 août 2009 22:26:29, Maxime Bizon a écrit :
> > On Mon, 2009-08-31 at 20:28 +0200, Florian Fainelli wrote:
> > > This patch makes the GPIO pin multiplexing configuration
> > > read the initial GPIO mode register value instead of
> > > setting it initially to 0, then setting the correct
> > > bits, this is safer.
> >
> > I disagree, now we get working or not working devices depending on the
> > CFE version used, for which we don't have any public source code nor
> > changelog.
> 
> I did not think this could break other boards, it is required on BCM6345 
> though.
> 
> >
> > I cleared the register for that purpose.
> >
> > If a particular pin muxing config is needed for some board, we should
> > add this to the board specific struct instead.
> 
> Then I will make it BCM6345 specific.

I thought you were going to send an update to this?

  Ralf
