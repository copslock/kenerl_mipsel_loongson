Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 18:22:34 +0000 (GMT)
Received: from smtp.nildram.co.uk ([195.112.4.54]:35334 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20034756AbXLLSWZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 18:22:25 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 760A52B7BE8;
	Wed, 12 Dec 2007 18:22:22 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J2WDx-00021s-79; Wed, 12 Dec 2007 18:22:25 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	peter fuerst <pf@pfrst.de>
Mail-Followup-To: peter fuerst <pf@pfrst.de>,Ralf Baechle <ralf@linux-mips.org>,  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Kumba <kumba@gentoo.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <Pine.LNX.3.96.1071211004847.199A@PCD-4H>
	<87hcinlr8k.fsf@firetop.home>
Date:	Wed, 12 Dec 2007 18:22:25 +0000
In-Reply-To: <87hcinlr8k.fsf@firetop.home> (Richard Sandiford's message of
	"Wed\, 12 Dec 2007 18\:09\:31 +0000")
Message-ID: <878x3zlqn2.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rsandifo@nildram.co.uk> writes:
> through KSEG2 or an uncached XKPHYS address, is it not also physically

er, I meant KSEG1 of course.  Same mistake later.

Richard
