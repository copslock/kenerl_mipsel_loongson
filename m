Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:52:09 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:33258 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225424AbSLSLwI>; Thu, 19 Dec 2002 11:52:08 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA00415;
	Thu, 19 Dec 2002 12:52:17 +0100 (MET)
Date: Thu, 19 Dec 2002 12:52:17 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
In-Reply-To: <m28yynnes2.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021219124513.27339H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

> In the kernel for IP22 (I suppose the same for other architectures),
> it has only two Assembler warnings.  And they are all in the fast
> path :(
> 
> one is in entry.S:excetp_vec3_r4000

 That's damn performace-critical.  Thats why the VCED and VCEI handlers
are inlined there (unlike the rest) in the first place.

> and the other is in head.S:ejtag_debug_handler

 That's non-critical, but I see no reason to degrade code because of
deficiencies of tools.  Tools should be fixed instead. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
