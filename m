Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NKDFF03933
	for linux-mips-outgoing; Thu, 23 Aug 2001 13:13:15 -0700
Received: from inet-tsb.toshiba.co.jp (inet-tsb.toshiba.co.jp [202.33.96.40])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NKDCd03930
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 13:13:13 -0700
Received: from tis2.tis.toshiba.co.jp (tis2 [133.199.160.66])
	by inet-tsb.toshiba.co.jp (3.7W:TOSHIBA-ISC-2000030918) with ESMTP id FAA14539;
	Fri, 24 Aug 2001 05:12:35 +0900 (JST)
Received: from mx2.toshiba.co.jp by tis2.tis.toshiba.co.jp (8.8.4+2.7Wbeta4/3.3W9-95082317)
	id FAA10611; Fri, 24 Aug 2001 05:12:35 +0900 (JST)
Received: from eecksm.sdel.toshiba.co.jp by toshiba.co.jp (8.7.1+2.6Wbeta4/3.3W9-TOSHIBA-GLOBAL SERVER) id FAA07209; Fri, 24 Aug 2001 05:12:34 +0900 (JST)
Received: from HirooPC (kddlos0115.mobile.toshiba.co.jp [10.16.11.34])
	by eecksm.sdel.toshiba.co.jp (Postfix) with SMTP
	id 848A0BAE3F; Fri, 24 Aug 2001 05:12:30 +0900 (JST)
From: "Hiroo Hayashi" <hiroo.hayashi@toshiba.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: bus error by write transaction (RE: [patch] linux 2.4.5: Make __dbe_table available to modules)
Date: Thu, 23 Aug 2001 15:11:33 -0500
Message-ID: <FFEHJOJAGEIJIPPEKDNGOEJGCDAA.hiroo.hayashi@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.GSO.3.96.1010823172522.21718E-100000@delta.ds2.pg.gda.pl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

> > I consider external signaling of write failures may be useful for kernel
> > debugging purposes. I agree it's hard (or even impossible) to achieve
> > proper behaviour on write failures for user space. There is a small
> > chance to kill another process, for example, write transactions may
> > delay due to write buffer. So, the kernel may only print something.
> 
>  Or, more severly and importantly, a write-back cache.  We provide such
> diagnostics but it's dubious for writes.  You are right, it might be
> useful for debugging in some cases, though.

Yes, most MIPS CPU except very old one use writeback cache.

Note that most MIPS documents use word 'load' and 'store' for instruction,
and 'read' and 'write' for bus transaction.  You have to distinguish them.

On a system with writeback cache, a write bus transaction is issued when
a modified cache line is replaced by a cache miss for either load
instruction or store instruction.

(Here I'm ignoring I/O access to make the point clear.)

The data on a write bus transaction may be a data modified by a store
instruction which was issued some years ago :-)  What the OS can do?

Hiro
