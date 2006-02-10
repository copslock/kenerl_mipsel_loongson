Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 11:38:50 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:19211 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133571AbWBJLih (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 11:38:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1ABh8PP005779;
	Fri, 10 Feb 2006 11:43:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1A1Ye9l020402;
	Fri, 10 Feb 2006 01:34:40 GMT
Date:	Fri, 10 Feb 2006 01:34:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>,
	MIPS Linux List <linux-mips@linux-mips.org>,
	Stuart Anderson <anderson@netsweng.com>,
	David Daney <ddaney@avtrex.com>, richard@codesourcery.com
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060210013440.GA5436@linux-mips.org>
References: <20060123150507.GA18665@linux-mips.org> <87wtg6c43s.fsf@talisman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wtg6c43s.fsf@talisman.home>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 07, 2006 at 08:21:11PM +0000, Richard Sandiford wrote:

> Ralf Baechle <ralf@linux-mips.org> writes:
> > I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> > below.
> 
> Sorry in advance if this is a dup, but...

No, not a dupe.

> and this requires val (%1) to be a 64-bit value.  In the case I saw,
> gcc was using $3 for the 32-bit val, and wasn't expecting $4 to be
> clobbered.

Thanks, makes perfect sense.  I tried various other obscure things and
your patch was holding up, so I just applied it.

Thanks,

  Ralf

PS: If in the future you could include a Signed-off-by: line.
