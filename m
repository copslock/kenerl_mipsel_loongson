Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 16:40:08 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:56739 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225929AbUFKPkE>; Fri, 11 Jun 2004 16:40:04 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DC6BE4787C; Fri, 11 Jun 2004 17:39:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id C376347485; Fri, 11 Jun 2004 17:39:57 +0200 (CEST)
Date: Fri, 11 Jun 2004 17:39:57 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Daney <ddaney@avtrex.com>
Cc: gcc@gcc.gnu.org, linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
In-Reply-To: <40C9D101.3070001@avtrex.com>
Message-ID: <Pine.LNX.4.55.0406111737200.13062@jurand.ds.pg.gda.pl>
References: <40C8B29B.3090501@avtrex.com> <Pine.LNX.4.55.0406111554420.13062@jurand.ds.pg.gda.pl>
 <40C9D101.3070001@avtrex.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jun 2004, David Daney wrote:

> Could you point me to where in the kernel source this is handled?  I 
> will try to see what when wrong.

 For 2.4 it's arch/mips{,64}/kernel/traps.c, functions do_bp() and
do_tr().

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
