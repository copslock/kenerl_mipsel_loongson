Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7RGpFR29350
	for linux-mips-outgoing; Mon, 27 Aug 2001 09:51:15 -0700
Received: from inet-tsb.toshiba.co.jp (inet-tsb.toshiba.co.jp [202.33.96.40])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7RGpCd29346
	for <linux-mips@oss.sgi.com>; Mon, 27 Aug 2001 09:51:12 -0700
Received: from tis2.tis.toshiba.co.jp (tis2 [133.199.160.66])
	by inet-tsb.toshiba.co.jp (3.7W:TOSHIBA-ISC-2000030918) with ESMTP id BAA23320;
	Tue, 28 Aug 2001 01:50:13 +0900 (JST)
Received: from mx2.toshiba.co.jp by tis2.tis.toshiba.co.jp (8.8.4+2.7Wbeta4/3.3W9-95082317)
	id BAA13191; Tue, 28 Aug 2001 01:50:12 +0900 (JST)
Received: from eecksm.sdel.toshiba.co.jp by toshiba.co.jp (8.7.1+2.6Wbeta4/3.3W9-TOSHIBA-GLOBAL SERVER) id BAA20244; Tue, 28 Aug 2001 01:50:12 +0900 (JST)
Received: from HirooPC (kddlos0144.mobile.toshiba.co.jp [10.16.11.63])
	by eecksm.sdel.toshiba.co.jp (Postfix) with SMTP
	id 6E630BAE3F; Tue, 28 Aug 2001 01:50:08 +0900 (JST)
From: "Hiroo Hayashi" <hiroo.hayashi@toshiba.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: RE: bus error by write transaction (RE: [patch] linux 2.4.5: Make __dbe_table available to modules)
Date: Mon, 27 Aug 2001 11:49:15 -0500
Message-ID: <FFEHJOJAGEIJIPPEKDNGGEJMCDAA.hiroo.hayashi@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.GSO.3.96.1010824181047.14758B-100000@delta.ds2.pg.gda.pl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

> > Note that most MIPS documents use word 'load' and 'store' for instruction,
> > and 'read' and 'write' for bus transaction.  You have to distinguish them.
> 
>  Don't I?

I understood that (singular) you distinguish them.
I thought someone misunderstood in this thread.

> > (Here I'm ignoring I/O access to make the point clear.)
> 
>  How do you define an I/O access for MIPS?
uncached access.  Off cource there can be exception.

> > The data on a write bus transaction may be a data modified by a store
> > instruction which was issued some years ago :-)  What the OS can do?
> 
>  Report it and panic.

I agree with you.

>   The problem with bus errors on MIPS is that one
> can't distinguish between errors on reads and writes.

But I did not understand that there is MIPS CPU which cause Bus Error Exception
as a result of  a bus error for a write bus transaction or a read bus transaction
which caused by cache miss for a store instruction.  It's messy...

Hiroo
