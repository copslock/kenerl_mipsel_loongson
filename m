Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2007 11:51:19 +0100 (BST)
Received: from smtp.nildram.co.uk ([195.149.33.74]:16564 "EHLO
	smtp.nildram.co.uk") by ftp.linux-mips.org with ESMTP
	id S20026286AbXJMKvK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 13 Oct 2007 11:51:10 +0100
Received: from firetop.home (85-211-25-104.dyn.gotadsl.co.uk [85.211.25.104])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 47C862DE924;
	Sat, 13 Oct 2007 11:51:03 +0100 (BST)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1IgeaG-000368-IL; Sat, 13 Oct 2007 11:51:04 +0100
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,Martin Michlmayr <tbm@cyrius.com>,  David Daney <ddaney@avtrex.com>,  MIPS Linux List <linux-mips@linux-mips.org>, rsandifo@nildram.co.uk
Cc:	Martin Michlmayr <tbm@cyrius.com>, David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
References: <20071012172254.GA10835@linux-mips.org>
	<470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org>
	<470FBE08.8090004@avtrex.com> <20071012184909.GA4832@linux-mips.org>
	<20071012191446.GK3163@deprecation.cyrius.com>
	<20071012191645.GB4832@linux-mips.org>
Date:	Sat, 13 Oct 2007 11:51:04 +0100
In-Reply-To: <20071012191645.GB4832@linux-mips.org> (Ralf Baechle's message of
	"Fri\, 12 Oct 2007 20\:16\:45 +0100")
Message-ID: <87d4vj9tk7.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:
> On Fri, Oct 12, 2007 at 09:14:46PM +0200, Martin Michlmayr wrote:
>> > For the moment the receipe to reproduce is to checkout
>> > 7b94a571d6f31ac6303d62c2aafcae40b66f24a3 from the linux-mips.org kernel
>> > tree (that's on linux-2.6.18-stable) and build malta_defconfig with
>> > gcc 4.2.2 and binutils 2.17 or 2.18, both configured for mipsel-linux.
>> 
>> Okay, I can see it.  I'll submit a testcase.
>
> Thanks :-)

FWIW, I've added some notes about the underlying cause.  I think this
could in principle happen with any gcc release.

Richard
