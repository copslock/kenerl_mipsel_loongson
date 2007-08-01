Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 17:21:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:21962 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021444AbXHAQVM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 17:21:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l71GLB71015914;
	Wed, 1 Aug 2007 17:21:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l71GLBLm015913;
	Wed, 1 Aug 2007 17:21:11 +0100
Date:	Wed, 1 Aug 2007 17:21:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
Message-ID: <20070801162110.GB14756@linux-mips.org>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <20070801163926.038c48db@the-village.bc.nu> <Pine.LNX.4.64N.0708011639030.20314@blysk.ds.pg.gda.pl> <20070801165812.3bdb269f@the-village.bc.nu> <Pine.LNX.4.64N.0708011657190.20314@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0708011657190.20314@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 01, 2007 at 05:00:21PM +0100, Maciej W. Rozycki wrote:

> #ifdef CONFIG_64BIT_PHYS_ADDR
> typedef unsigned long long phys_t;
> #else
> typedef unsigned long phys_t;
> #endif
> 
> so no problem here as long as you enable CONFIG_64BIT_PHYS_ADDR which is 
> implied in such a case.

Which happens to be the solution that is Linus-incompatible so I may
eventually have to change it ;-)

  Ralf
