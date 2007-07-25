Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2007 13:52:55 +0100 (BST)
Received: from 87-237-56-54.northerncolo.co.uk ([87.237.56.54]:43983 "EHLO
	totally.trollied.org.uk") by ftp.linux-mips.org with ESMTP
	id S20021506AbXGYMww (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jul 2007 13:52:52 +0100
Received: from localhost ([127.0.0.1] helo=totally.trollied.org.uk)
	by totally.trollied.org.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <movement@totally.trollied.org.uk>)
	id 1IDgM1-000302-AH; Wed, 25 Jul 2007 13:52:37 +0100
Received: (from movement@localhost)
	by totally.trollied.org.uk (8.13.7/8.13.7/Submit) id l6PCqZiN011533;
	Wed, 25 Jul 2007 13:52:35 +0100
Date:	Wed, 25 Jul 2007 13:52:35 +0100
From:	John Levon <levon@movementarian.org>
To:	Dajie Tan <jiankemeng@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	inux-mips <linux-mips@linux-mips.org>, phil.el@wanadoo.fr,
	oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] Add support for profiling Loongson 2E
Message-ID: <20070725125235.GD8454@totally.trollied.org.uk>
References: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com> <20070724144051.GA17256@linux-mips.org> <5861a7880707242041w32811dal6e2765747cbada32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5861a7880707242041w32811dal6e2765747cbada32@mail.gmail.com>
X-Url:	http://www.movementarian.org/
User-Agent: Mutt/1.5.9i
Return-Path: <movement@totally.trollied.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levon@movementarian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 25, 2007 at 07:41:21AM +0400, Dajie Tan wrote:

> >Why do you need this change?  It almost looks as if you're papering over
> >a bug where add_sample should not be called at all.
> 
> Yeah,this change is to enhance the robust of oprofile. When using
> performace counter manually(writting control register in a module, no
> need to use the oprofile),I usually make kernel panic if I do not
> initialize the oprofile and enable the overflow interrupt carelessly.
> So, this change can avoid this panic. :D

This panic is good and should stay. It shows that you've made a mistake.

john
