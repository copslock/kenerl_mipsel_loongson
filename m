Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 12:58:40 +0000 (GMT)
Received: from cantor.suse.de ([195.135.220.2]:12960 "EHLO mx1.suse.de")
	by ftp.linux-mips.org with ESMTP id S23815134AbYKUM6c (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 12:58:32 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 6BEE3429CD;
	Fri, 21 Nov 2008 13:58:31 +0100 (CET)
From:	Andreas Schwab <schwab@suse.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
References: <49260E4C.8080500@caviumnetworks.com>
	<20081121100035.3f5a640b@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0811211126420.26004@anakin>
	<alpine.LFD.1.10.0811211059290.20023@ftp.linux-mips.org>
X-Yow:	RELATIVES!!
Date:	Fri, 21 Nov 2008 13:58:30 +0100
In-Reply-To: <alpine.LFD.1.10.0811211059290.20023@ftp.linux-mips.org> (Maciej
	W. Rozycki's message of "Fri, 21 Nov 2008 11:14:30 +0000 (GMT)")
Message-ID: <jezljtxmkp.fsf@sykes.suse.de>
User-Agent: Gnus/5.110009 (No Gnus v0.9) Emacs/22.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <schwab@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@suse.de
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> Otherwise it looks like the attribute is useless -- it looks like it can 
> only be used for functions where GCC can determine the function does not 
> return anyway.  Which means it is redundant.

The purpose of the attribute is to tell the _callers_ of this function
that it does not return.  It does not change how the attributed function
itself is compiled.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
