Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 16:56:24 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:29456 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224974AbVHZP4H>; Fri, 26 Aug 2005 16:56:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A86DAF59CE; Fri, 26 Aug 2005 17:52:51 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06006-03; Fri, 26 Aug 2005 17:52:51 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7B69AF59CD; Fri, 26 Aug 2005 17:52:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j7QFqtP4001270;
	Fri, 26 Aug 2005 17:52:55 +0200
Date:	Fri, 26 Aug 2005 16:53:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dan Malek <dan@embeddededge.com>
Cc:	ppopov@embeddedalley.com,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: patch / rfc
In-Reply-To: <0cc66f0b0b5afa994744547699f687bf@embeddededge.com>
Message-ID: <Pine.LNX.4.61L.0508261650360.9561@blysk.ds.pg.gda.pl>
References: <1125006681.14435.1065.camel@localhost.localdomain>
 <Pine.LNX.4.61L.0508261340460.9561@blysk.ds.pg.gda.pl>
 <1125069898.14435.1215.camel@localhost.localdomain>
 <0cc66f0b0b5afa994744547699f687bf@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1042/Fri Aug 26 10:00:27 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 26 Aug 2005, Dan Malek wrote:

> If you do this, I suggest using another PowerPC-ism.  They
> have a ppc_md data structure that is filled with indirect function
> pointers to machine dependent functions.  We could create
> a mips_md that does this same thing.  The reason I like this
> is it collects all machine dependent information in a single
> place, so it's easy to see what functions/data are available
> and what you may need to do.  It's also clear when used
> that anything in this structure is a machine/board dependent
> function.  In the proper places, you then do what is shown above:

 Well, that's actually Alpha-ism, which has been that port since 1998 or 
so and is a long-term plan for our multi-platform support too. :-)  If you 
want to implement it right now, please go ahead!

  Maciej
