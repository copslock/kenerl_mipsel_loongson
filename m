Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 16:03:32 +0000 (GMT)
Received: from brilsmurf.chem.tue.nl ([IPv6:::ffff:131.155.84.68]:15530 "EHLO
	brilsmurf.chem.tue.nl") by linux-mips.org with ESMTP
	id <S8225220AbUBXQDU>; Tue, 24 Feb 2004 16:03:20 +0000
Received: from brilsmurf.chem.tue.nl (localhost [127.0.0.1])
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1OG3JvI030497
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-mips@linux-mips.org>; Tue, 24 Feb 2004 17:03:20 +0100
Received: from localhost (joost@localhost)
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1OG3JSA030959
	for <linux-mips@linux-mips.org>; Tue, 24 Feb 2004 17:03:19 +0100
X-Authentication-Warning: brilsmurf.chem.tue.nl: joost owned process doing -bs
Date:	Tue, 24 Feb 2004 17:03:19 +0100 (CET)
From:	Joost <Joost@stack.nl>
X-X-Sender: joost@brilsmurf.chem.tue.nl
To:	linux-mips@linux-mips.org
Subject: Re: fore atm card in indy?
In-Reply-To: <20040223204649.GF1046@mind.be>
Message-ID: <Pine.LNX.4.58.0402241658390.21389@brilsmurf.chem.tue.nl>
References: <Pine.LNX.4.58.0402181631050.30510@brilsmurf.chem.tue.nl>
 <20040220142138.GD23404@linux-mips.org> <20040223204649.GF1046@mind.be>
ReplyTo: Joost@stack.nl
User-Agent: 007
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Joost@stack.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joost@stack.nl
Precedence: bulk
X-list: linux-mips

> > You'll not like this answer ...  but write a driver :-)
> > It seems many GIO cards are based on already Linux-supported PCI chips,
> > so there's a certain chance this won't even be hard.
> There is already a driver for the PCI and SBUS versions of this card. It
> lives in drivers/atm/fore200e*. You 'only' need to add code for the
> GIO32 specifics.

Thank you both for your answer. I've only taken a quick
peek, and got rather scared :-) Maybe I'll try again
when I have more time (exams coming up).

Thanks again!
