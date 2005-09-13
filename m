Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2005 20:51:20 +0100 (BST)
Received: from smtp103.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.238]:19300
	"HELO smtp103.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225525AbVIMTvC>; Tue, 13 Sep 2005 20:51:02 +0100
Received: (qmail 79553 invoked from network); 13 Sep 2005 19:50:55 -0000
Received: from unknown (HELO ?192.168.1.111?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp103.biz.mail.mud.yahoo.com with SMTP; 13 Sep 2005 19:50:54 -0000
Subject: Re: deletion of boards
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Sylvain Munaut <tnt@246tNt.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <43272A02.7030603@246tNt.com>
References: <1126575034.11755.85.camel@localhost.localdomain>
	 <43272A02.7030603@246tNt.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 13 Sep 2005 12:51:04 -0700
Message-Id: <1126641064.11755.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Tue, 2005-09-13 at 21:35 +0200, Sylvain Munaut wrote:
> Pete Popov wrote:
> > The AMD Pb1000, Pb1100, Pb1500, and Hydrogen3 boards are not up to date
> > in 2.6 and seem to be of very little interest to anyone. Any objections
> > if I remove them to reduce the clutter?
> > 
> > Pete
> > 
> > 
> 
> Theses files were of some help when bringing up new board based on thos
> processors.

Why not use the Db1x equivalent? If you have an au1000 based board, you
should probably base your port on the db1000 board, not the pb1000
anyway.

I didn't get a clear answer on whether it's ok to remove those boards
but I guess that's normal. The problem with keeping boards around that
very few people are interested in is that no one maintains them, the
code is broken, and quite honestly I think it creates confusion for
developers that have a custom board based on, let's say, the Au1500.
Unless that developer knows that the pb1000 code is broken, how would he
know to base his code on the db1000 instead of the pb1000? If the
support for these boards is broken now, it will only get worst. Anytime
someone makes mods to supported boards, it's bound to break something in
the already unsupported ones and make that code even more unusable.

Pete
