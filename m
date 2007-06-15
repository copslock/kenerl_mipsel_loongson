Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 15:42:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53966 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022450AbXFOOmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 15:42:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5FEcdIr011127;
	Fri, 15 Jun 2007 15:39:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5FEccnF011126;
	Fri, 15 Jun 2007 15:38:38 +0100
Date:	Fri, 15 Jun 2007 15:38:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
	code.
Message-ID: <20070615143838.GA11094@linux-mips.org>
References: <11818164023940-git-send-email-fbuihuu@gmail.com> <20070614111748.GA8223@alpha.franken.de> <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl> <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com> <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl> <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com> <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl> <20070615132613.GA16133@linux-mips.org> <cda58cb80706150724i1cbbfd1aw51d23d18e35f6266@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706150724i1cbbfd1aw51d23d18e35f6266@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 15, 2007 at 04:24:36PM +0200, Franck Bui-Huu wrote:

> Do you think it's possible to work out a common version of this
> calibration without to many hacks ? Or should we simply move the
> current generic one into the dec code and resolve this point later ?

I think that this will be pretty easy and only moderately timeconsuming.

  Ralf
