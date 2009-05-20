Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 00:17:53 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55532 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025163AbZETXRr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 00:17:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4KNHTxm009229;
	Thu, 21 May 2009 00:17:29 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4KNHRfC009227;
	Thu, 21 May 2009 00:17:27 +0100
Date:	Thu, 21 May 2009 00:17:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Laurent GUERBY <laurent@guerby.net>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Andrew Sharp <andy.sharp@onstor.com>,
	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Bigsur?
Message-ID: <20090520231727.GB1656@linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com> <1242663215.18301.26.camel@chaos.ne.broadcom.com> <20090518222334.GD16847@linux-mips.org> <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org> <1242735440.6098.101.camel@localhost> <20090519125310.GA17733@linux-mips.org> <20090520110105.6fb81573@ripper.onstor.net> <20090520191618.GA32295@linux-mips.org> <20090520212243.0a023a22@scarran.roarinelk.net> <1242850869.6098.140.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242850869.6098.140.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 20, 2009 at 10:21:09PM +0200, Laurent GUERBY wrote:

> > I rebuilt a whole Gentoo system from scratch natively over an NFSroot--
> > it was actually very painless; add distcc and the time to wait is a
> > lot shorter.
> 
> One of the farm machine is a Marvell sheevaplug with root over NFS
> (gentoo based with marvell.git kernel) and it does multi user
> compilations all day long with no issue so far.

For your entertainment:

  http://www.opengroup.org/onlinepubs/9629799/apdxa.htm
  http://www.time-travellers.org/shane/papers/NFS_considered_harmful.html

NFSv4 fixes alot of issues but is only slowly being adopted.  Also iSCSI
might be worth trying; it would completely solve all the NFS issues.

  Ralf
