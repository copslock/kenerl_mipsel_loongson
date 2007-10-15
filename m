Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 17:20:46 +0100 (BST)
Received: from smtp.nildram.co.uk ([195.112.4.54]:43535 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20036896AbXJOQUi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 17:20:38 +0100
Received: from firetop.home (85-211-25-104.dyn.gotadsl.co.uk [85.211.25.104])
	by smtp.nildram.co.uk (Postfix) with ESMTP
	id BBB3D2B8A98; Mon, 15 Oct 2007 17:19:15 +0100 (BST)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1IhSf0-0007BR-5G; Mon, 15 Oct 2007 17:19:18 +0100
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>, rsandifo@nildram.co.uk
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>,
	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
References: <20071012172254.GA10835@linux-mips.org>
	<470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org>
	<470FBE08.8090004@avtrex.com> <20071012184909.GA4832@linux-mips.org>
	<20071012191446.GK3163@deprecation.cyrius.com>
	<20071012191645.GB4832@linux-mips.org> <87d4vj9tk7.fsf@firetop.home>
	<Pine.LNX.4.64N.0710151553200.16262@blysk.ds.pg.gda.pl>
Date:	Mon, 15 Oct 2007 17:19:18 +0100
In-Reply-To: <Pine.LNX.4.64N.0710151553200.16262@blysk.ds.pg.gda.pl> (Maciej
	W. Rozycki's message of "Mon\, 15 Oct 2007 15\:59\:51 +0100 \(BST\)")
Message-ID: <87ve98ic55.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Sat, 13 Oct 2007, Richard Sandiford wrote:
>> FWIW, I've added some notes about the underlying cause.  I think this
>> could in principle happen with any gcc release.
>
>  It has been seen with GCC 3.4 and IIRC SDE has a hack in binutils to 
> disable this error as a workaround.  I guess the problem has always been 
> there since explicit relocs were added to GCC; it is just it hardly ever 
> happens.

Agreed.  And in options-speak, "explicit relocs" means both -mexplicit-relocs
and -msplit-addresses.  The associated gas warning was disabled in the
initial revision of sourceware binutils:

1.1          (rth      03-May-99): #if 0 /* GCC code motion plus incomplete dead code elimination
1.1          (rth      03-May-99):       can leave a %hi without a %lo.  */
1.1          (rth      03-May-99):        if (pass == 1)
1.1          (rth      03-May-99):          as_warn_where (l->fixp->fx_file, l->fixp->fx_line,
1.1          (rth      03-May-99):                         _("Unmatched %%hi reloc"));
1.1          (rth      03-May-99): #endif

so I think this problem has been seen with GCC 2 as well as 3 and 4.

Richard
