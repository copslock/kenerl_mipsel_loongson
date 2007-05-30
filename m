Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2007 17:59:16 +0100 (BST)
Received: from sith.mimuw.edu.pl ([193.0.96.4]:63277 "EHLO sith.mimuw.edu.pl")
	by ftp.linux-mips.org with ESMTP id S20022661AbXE3Q7N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2007 17:59:13 +0100
Received: by sith.mimuw.edu.pl (Postfix, from userid 1062)
	id 1C64B30A4B8; Wed, 30 May 2007 18:58:42 +0200 (CEST)
Date:	Wed, 30 May 2007 18:58:42 +0200
From:	Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
Message-ID: <20070530165842.GL29894@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl>
X-Operating-System: Linux 2.6.19.1 i686
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <baggins@sith.mimuw.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baggins@sith.mimuw.edu.pl
Precedence: bulk
X-list: linux-mips

On Tue, 29 May 2007, Maciej W. Rozycki wrote:

>  This is a reimplementation of the zs driver for the serial subsystem.  
> Any resemblance to the old driver is purely coincidential. ;-)  I do hope 
> I got the handling of modem lines right -- better do not tackle me about 
> the issue unless you feel too good...

Look functional to me (just booted my DecStation 5000/240) :)
Any chance to get LK201/401 keyboard and vsxxxaa mouse working with this?

Janek
-- 
Jan Rekorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
