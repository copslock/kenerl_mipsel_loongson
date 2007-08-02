Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 11:17:52 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:21777 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021968AbXHBKRq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 11:17:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0DA78E1C75;
	Thu,  2 Aug 2007 12:17:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O++MuccFlfGI; Thu,  2 Aug 2007 12:17:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A4507E1C63;
	Thu,  2 Aug 2007 12:17:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l72AHmJq005015;
	Thu, 2 Aug 2007 12:17:48 +0200
Date:	Thu, 2 Aug 2007 11:17:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <20070802101503.GD22697@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0708021117130.22591@blysk.ds.pg.gda.pl>
References: <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
 <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com>
 <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com>
 <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl> <46B0B6B4.5090103@ru.mvista.com>
 <46B0BE52.4000302@ru.mvista.com> <Pine.LNX.4.64N.0708021024200.22591@blysk.ds.pg.gda.pl>
 <20070802101503.GD22697@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Aug 2007, Ralf Baechle wrote:

> Lockdep would trigger on ioremap from an interrupt almost immediately.
> But I guess not a whole lot of people are using it, probably because they
> think they're safe from locking problems on uniprocessors ...

 Either this or they are not aware of its existence. ;-)

  Maciej
