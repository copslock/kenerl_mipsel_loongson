Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 23:51:39 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:46586 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122961AbSI0Vvi>; Fri, 27 Sep 2002 23:51:38 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA23848;
	Fri, 27 Sep 2002 23:52:00 +0200 (MET DST)
Date: Fri, 27 Sep 2002 23:51:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alex deVries <adevries@linuxcare.com>
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Format of bootable Indy CDs?
In-Reply-To: <3D94C8BF.5090902@linuxcare.com>
Message-ID: <Pine.GSO.3.96.1020927231854.16597C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 27 Sep 2002, Alex deVries wrote:

> I wrote the ISO you posted on an i386 box with cdrecord.  I suspect my 
> problem I didn't use set the blocksize to 512; exactly how did you burn 
> this CD?

 Blocks on CD media are always 2048 bytes long (disregarding correction
data).  The 512-byte block size as implemented by a few CD drives is
simply an ability to present chunks of native blocks in 512-byte amounts. 
This is just an artifical feature to fulfill a requirement of broken
firmware that asserts that disks have 512-byte sectors.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
