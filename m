Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 11:53:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:12040 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225002AbUJEKxf>; Tue, 5 Oct 2004 11:53:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 092FCE1CAA; Tue,  5 Oct 2004 12:53:30 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08607-09; Tue,  5 Oct 2004 12:53:29 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 62334E1C99; Tue,  5 Oct 2004 12:53:29 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i95AraWG019969;
	Tue, 5 Oct 2004 12:53:37 +0200
Date: Tue, 5 Oct 2004 11:53:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: sara@procsys.com, linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Assembler errors in rtld.c
In-Reply-To: <20041005.191608.59649656.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.58L.0410051152440.20503@blysk.ds.pg.gda.pl>
References: <41626E7D.2070405@procsys.com> <20041005.191608.59649656.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 5 Oct 2004, Atsushi Nemoto wrote:

> Also, you might have to pass -fno-unit-at-a-time to gcc 3.4.  (at
> least glibc 2.3.2 requires it).

 Which is also fixed in the CVS. ;-)

  Maciej
