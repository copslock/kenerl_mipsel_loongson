Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 06:47:23 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:1729
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbTE0FrU>; Tue, 27 May 2003 06:47:20 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R5ksbY019737;
	Mon, 26 May 2003 22:46:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R5knPr019736;
	Tue, 27 May 2003 07:46:49 +0200
Date: Tue, 27 May 2003 07:46:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Arrow keys on USB keyboards
Message-ID: <20030527054649.GA19562@linux-mips.org>
References: <Pine.GSO.4.21.0305231545030.26586-100000@vervain.sonytel.be> <Pine.GSO.3.96.1030523155904.14542E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030523155904.14542E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 23, 2003 at 04:05:43PM +0200, Maciej W. Rozycki wrote:

>  Hmm, if the PC/AT keyboard translation is needed by other devices beside
> pc_keyb.c, then why isn't the common part put into a separate file to be
> used by all devices depending on this translation as needed?  I think
> dummy_keyb.c should be kept plain and simple as it is now. 

You're right but for 2.4 this looks like an acceptable solution for now so
I'm going to apply this until somebody comes up with a better solution.

  Ralf
