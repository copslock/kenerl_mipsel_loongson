Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 14:43:45 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:62639 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQNnn>; Tue, 17 Jun 2003 14:43:43 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23969;
	Tue, 17 Jun 2003 15:44:32 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 15:44:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@trasno.org>
cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <86d6hcriwm.fsf@trasno.mitica>
Message-ID: <Pine.GSO.3.96.1030617154243.22214F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Juan Quintela wrote:

> maciej> So you need to explicitly configure it?  That's very bad.
> 
> You bet:
> - you force everybody to use early_printk (you only want it for
>   debugging).
> - you configure early_printk for everybody (never have to configure
>   it).
> 
> You can't have the cake and eat it :(

 I'm not sure what you mean.  Please elaborate.

> Why do you ever will want not to use early_printk?

 I won't, but someone else certainly will.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
