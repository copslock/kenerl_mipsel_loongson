Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 19:55:45 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:17311 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDRzo>; Wed, 4 Sep 2002 19:55:44 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA18246;
	Wed, 4 Sep 2002 19:56:05 +0200 (MET DST)
Date: Wed, 4 Sep 2002 19:56:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <3D7643BA.6090807@mvista.com>
Message-ID: <Pine.GSO.3.96.1020904194922.10619M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 85
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Jun Sun wrote:

> For 64bit kernel, do we intend to have one syscall table that support o32, n32 
> and n64 altogether?  Or we will have multiple tables for them?

 There are two tables now, one for o32, currently used when executing o32
userland and the other one ready for native userland.  They can't be
unified as their semantics differ. 

> Where can I find n32/n64 spec?

 Search 'http://techpubs.sgi.com/' and see
'ftp://oss.sgi.com/pub/linux/mips/doc/ABI/'. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
