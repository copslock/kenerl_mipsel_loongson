Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jun 2008 07:18:58 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:28123 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20022212AbYFOGS4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jun 2008 07:18:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5F6IMxR021581;
	Sun, 15 Jun 2008 07:18:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5F6HmsC021375;
	Sun, 15 Jun 2008 07:17:48 +0100
Date:	Sun, 15 Jun 2008 07:17:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Horsten <thomas@horsten.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] LASAT sysctl fixup
Message-ID: <20080615061727.GA12120@linux-mips.org>
References: <Pine.LNX.4.40.0806150213050.17906-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0806150213050.17906-100000@jehova.dsm.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 15, 2008 at 02:17:11AM +0100, Thomas Horsten wrote:

> LASAT's sysctl interface was broken, it failed a check during boot
> because a single entry had a sysctl number and the rest were
> unnumbered. When I fixed it I noticed that the whole sysctl file
> needed a spring clean, it was using mutexes where it wasn't needed
> (it's only needed to protect during writes to the EEPROM), so I moved
> that stuff out and generally cleaned the whole thing up.
> 
> So now, LASAT's sysctl/proc interface is working again.
> 
> Signed-off-by: Thomas Horsten <thomas@horsten.com>

Applied.  Thanks!

  Ralf
