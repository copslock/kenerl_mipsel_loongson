Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2004 14:21:41 +0000 (GMT)
Received: from p508B7AF5.dip.t-dialin.net ([IPv6:::ffff:80.139.122.245]:47203
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225385AbUBTOVk>; Fri, 20 Feb 2004 14:21:40 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1KELdex012352;
	Fri, 20 Feb 2004 15:21:39 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1KELcOj012351;
	Fri, 20 Feb 2004 15:21:38 +0100
Date: Fri, 20 Feb 2004 15:21:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Joost <Joost@stack.nl>
Cc: linux-mips@linux-mips.org
Subject: Re: fore atm card in indy?
Message-ID: <20040220142138.GD23404@linux-mips.org>
References: <Pine.LNX.4.58.0402181631050.30510@brilsmurf.chem.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402181631050.30510@brilsmurf.chem.tue.nl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 18, 2004 at 04:35:31PM +0100, Joost wrote:

> My indy seems to be equipped with a Fore ATM device (GIA-200).
> Would someone know if there is a way to get it back into action?

You'll not like this answer ...  but write a driver :-)

It seems many GIO cards are based on already Linux-supported PCI chips,
so there's a certain chance this won't even be hard.

  Ralf
