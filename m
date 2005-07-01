Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 16:07:45 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:61190 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226156AbVGAPHZ>; Fri, 1 Jul 2005 16:07:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BE155F59AB; Fri,  1 Jul 2005 17:07:13 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06978-06; Fri,  1 Jul 2005 17:07:13 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8EB33F599C; Fri,  1 Jul 2005 17:07:13 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j61F47tZ007207;
	Fri, 1 Jul 2005 17:07:10 +0200
Date:	Fri, 1 Jul 2005 16:04:15 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
In-Reply-To: <20050701144640.GA30720@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0507011602540.30138@blysk.ds.pg.gda.pl>
References: <20050630173409Z8226102-3678+735@linux-mips.org>
 <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org>
 <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org>
 <Pine.LNX.4.61L.0507010940280.30138@blysk.ds.pg.gda.pl>
 <20050701133910.GA24716@nevyn.them.org> <Pine.LNX.4.61L.0507011450180.30138@blysk.ds.pg.gda.pl>
 <20050701144640.GA30720@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/963/Fri Jul  1 15:27:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Daniel Jacobowitz wrote:

> Sure - send them to me, or better yet, put them in bugzilla and make
> sure you copy me.  I can't promise you timely response just now because
> I'm about twelve feet under on this current project at work, but I'll
> do everything I can.

 OK, one is already there as bug #933 and I'll add the rest.

> We're going to have automated MIPS regression testing sometime this
> year, too.

 Oh, that would be most welcome.

  Maciej
