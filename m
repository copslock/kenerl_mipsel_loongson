Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 12:52:16 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13565 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225213AbTHDLwM>; Mon, 4 Aug 2003 12:52:12 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA17309;
	Mon, 4 Aug 2003 13:51:58 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 4 Aug 2003 13:51:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: RM7k cache_flush_sigtramp
In-Reply-To: <16174.7469.845997.741559@gladsmuir.mips.com>
Message-ID: <Pine.GSO.3.96.1030804134034.17066B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Dominic,

> I think it would be better to provide cache manipulation calls defined
> top-down (by their purpose); but so long as we are stuck with calls
> which are defined as performing particular low-level actions, it's
> surely dangerous to guess that we know what they are used for so we
> can trim the functions accordingly...

 The API is not cast in stone -- if there's a justifiable benefit,
appropriate fuctions can be added; either completely new ones (possibly
inlined) or as an extension to cacheflush() (which still has 30 bits
freely available). 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
