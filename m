Received:  by oss.sgi.com id <S305166AbPLFNki>;
	Mon, 6 Dec 1999 05:40:38 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:36700 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbPLFNkR>;
	Mon, 6 Dec 1999 05:40:17 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA07158; Mon, 6 Dec 1999 05:47:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA64097
	for linux-list;
	Mon, 6 Dec 1999 05:36:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA36604
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 05:36:38 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA08271
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 05:36:34 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 11uyJ2-0006Eb-00; Mon, 6 Dec 1999 13:35:56 +0000
Subject: Re: Nomenclature: "MIPS32", "MIPS64"
To:     kevink@mips.com (Kevin D. Kissell)
Date:   Mon, 6 Dec 1999 13:35:54 +0000 (GMT)
Cc:     ralf@oss.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <00a201bf3fed$df8c82f0$0ceca8c0@satanas.mips.com> from "Kevin D. Kissell" at Dec 6, 99 02:29:06 pm
Content-Type: text
Message-Id: <E11uyJ2-0006Eb-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> The problems are twofold.  First, while it is of course possible to create
> a kernel that will run on both MIPS64 and pre-MIPS64 MIPS-III and
> MIPS-IV CPUs, it is also possible to create a MIPS64 kernel that
> would not necessarily run on R10000s and vice versa.  Secondly,
> we are referring to two distinct things that ought to be distinguished
> at the source and documentation level.   We need a name for something 
> that is 64-bit-MIPS but not necessarily tied up with any particular CPU 
> and a distinct name for something that is compatible with a particular 
> CPU type.  "MIPS32" and "MIPS64" are already trademarked
> by MIPS to describe the CPUs, so we need another name for the 
> generic OS infrastructure for 64-bit MIPS registers/addresses.

I would suggest that until someone from MIPS legal specifically raises an issue
you don't worry about it. With the sparc people they were quite happy with
Linux/sparc - which denotes Linux for sparc systems (they objected to 
sparclinux as that implied it was their product). In fact given the "/" is
'for' then I don't think there is even a valid trademark issue to be raised.

Its also not in MIPS interest to cause trouble. Its a product for their
system. If they started being silly then everyones lawyers would be advising
them to pull their "xyz product for mips" as a legal precaution.
