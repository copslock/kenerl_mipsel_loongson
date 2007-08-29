Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 12:23:02 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:19662 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022210AbXH2LWy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 12:22:54 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5E66F400C7;
	Wed, 29 Aug 2007 13:22:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 0+OB58oY4Wt7; Wed, 29 Aug 2007 13:22:46 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6D5AF400C4;
	Wed, 29 Aug 2007 13:22:46 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l7TBMi49024042;
	Wed, 29 Aug 2007 13:22:44 +0200
Date:	Wed, 29 Aug 2007 12:22:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
cc:	Mike Frysinger <vapier.adi@gmail.com>,
	Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
	blinux-list@redhat.com, cluster-devel@redhat.com,
	discuss@x86-64.org, jffs-dev@axis.com, linux-acpi@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	linux-scsi@vger.kernel.org, mpt_linux_developer@lsi.com,
	netdev@vger.kernel.org, osst-users@lists.sourceforge.net,
	parisc-linux@parisc-linux.org, tpmdd-devel@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: [PATCH] Prefix each line of multiline printk(KERN_<level>
 "foo\nbar") with KERN_<level>
In-Reply-To: <Pine.LNX.4.64.0708261305020.31149@anakin>
Message-ID: <Pine.LNX.4.64N.0708291205020.26167@blysk.ds.pg.gda.pl>
References: <1187999098.32738.179.camel@localhost> <Pine.LNX.4.64.0708261028120.31149@anakin>
 <8bd0f97a0708260354xb4c8546od0cc19a590820f32@mail.gmail.com>
 <Pine.LNX.4.64.0708261305020.31149@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4100/Wed Aug 29 10:32:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 26 Aug 2007, Geert Uytterhoeven wrote:

> What I mean is that probably there used to be a printk() call starting with
> `\n'. Then someone added a `KERN_ERR' in front of it.

 I gather '\n' at the beginning is to assure the following line is output 
on a separate line rather than as a continuation of another one which may 
have been output without a trailing '\n'.  A situation where printk() is 
called with a string containing no trailing '\n' may be discouraged, but 
there are some more or less justified exceptions.  For example the SCSI 
disk spin-up code is one.

 Therefore it may be reasonable for more critical messages -- perhaps not 
ones at KERN_ERR, but certainly KERN_CRIT and higher ones -- that may 
potentially happen asynchronously to start with '\n'.  In this case a call 
would look like this:

	printk("\n" KERN_CRIT "The actual message.\n");

Of course based on "console_loglevel" and "default_message_level" the 
leading '\n' may still get swallowed from what gets printed to the console 
terminal, but in reality I do not think that poses a problem, as these 
both can be set by a system administrator according to the local policy.

  Maciej
