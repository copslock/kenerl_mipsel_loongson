Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 16:53:49 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:37823 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEOxs>; Thu, 5 Sep 2002 16:53:48 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA08381;
	Thu, 5 Sep 2002 16:54:09 +0200 (MET DST)
Date: Thu, 5 Sep 2002 16:54:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: "Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <200209051420.QAA26367@copcs01.mips.com>
Message-ID: <Pine.GSO.3.96.1020905162433.7444C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Hartvig Ekner wrote:

> I don't know the ultimate reasons why SGI choose ILP32 for n32, but one
> could certainly be portability.

 It depends on how you define "portability".  While it might help some
broken software, it will hurt good one.

> As defined, n32 provides all the benefits of 64-bit data (yes, you have
> to use long long to get to it), and 100% backward compatability with 

 So you can't use long to keep a file position pointer (off_t is quite a
new invention) and have to go for long long, for example?  Weird and
definitely doesn't help portability. 

> o32 sources that assume (sizeof(void *)) = sizeof(long), plus binary data

 Thay should be fixed, instead.  Using "void *" as a data container
doesn't work in general and one who does so should be banished.  And the
other way round, there is no problem -- if one keeps 32-bit pointers in
64-bit longs, there is no bit loss. 

> file compatability with o32 as all structures are exactly identical between
> o32 and n32.

 Why don't use o32 as is then, instead of creating a slightly different
ABI?  If some software needs binary data to be identical, then it has to
select fixed-size types, e.g. int32_t, explicitly.  While int32_t and
friends are quite a new standard, other ways were used for years to set up
such aspects, e.g. autoconf, imake, hand-written system-specific
preprocessor macros, etc., etc.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
