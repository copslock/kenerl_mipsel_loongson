Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 19:09:26 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:17537 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023860AbXISSJS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 19:09:18 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id BE70240094;
	Wed, 19 Sep 2007 20:08:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id L+VNJV3kuFYG; Wed, 19 Sep 2007 20:08:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 59C8E4009C;
	Wed, 19 Sep 2007 20:08:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8JI8kmM030357;
	Wed, 19 Sep 2007 20:08:46 +0200
Date:	Wed, 19 Sep 2007 19:08:40 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
In-Reply-To: <46F160BE.9030500@avtrex.com>
Message-ID: <Pine.LNX.4.64N.0709191904460.24627@blysk.ds.pg.gda.pl>
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org>
 <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl> <46F15BB3.50107@avtrex.com>
 <46F160BE.9030500@avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4344/Wed Sep 19 18:42:50 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Sep 2007, David Daney wrote:

> I just checked myself.  'sync' is not emulated.  We will have to make a change
> so that it is not emitted on ISAs that do not support it.

 The problem is if such software is run on a newer processor it may 
silently break.  Tough, I know...  We should have added "sync" emulation 
long ago.  OTOH, perhaps the MIPS I userbase is not that large anymore for 
the emulation to be required with a short transition period only?

  Maciej
