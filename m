Received:  by oss.sgi.com id <S42263AbQEaFR3>;
	Tue, 30 May 2000 22:17:29 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:47986 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42283AbQEaFRB>;
	Tue, 30 May 2000 22:17:01 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id WAA03379; Tue, 30 May 2000 22:09:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id WAA60142; Tue, 30 May 2000 22:13:24 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA11510
	for linux-list;
	Tue, 30 May 2000 22:02:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA98949
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 May 2000 22:02:46 -0700 (PDT)
	mail_from (neuroinc@unidial.com)
Received: from unidial.com (unidial.com [206.112.0.9]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA06591
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 May 2000 21:58:19 -0700 (PDT)
	mail_from (neuroinc@unidial.com)
Received: from unidial.com (IDENT:root@1Cust173.tnt32.chi5.da.uu.net [63.28.50.173])
	by unidial.com (8.9.3/8.9.3) with ESMTP id AAA25587;
	Wed, 31 May 2000 00:54:34 -0400 (EDT)
Message-ID: <39349D3D.9883ACAC@unidial.com>
Date:   Wed, 31 May 2000 00:03:57 -0500
From:   Alan Hoyt <neuroinc@unidial.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     jimix@watson.ibm.com
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: MIPS64 ABI
References: <392EB5F0.2464DF60@unidial.com>
		<Pine.LNX.4.21.0005261052310.15277-100000@calypso.engr.sgi.com> <14642.43917.729281.720220@kitch0.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


It seems like oss.sgi.com is up and running again - the
/pub/linux/mips/doc/ABI/ should have most of what you might need.  I
placed what small amount of material I have at
http://www.unidial.com/~neuroinc/index.html - take a look and let me know
if it's of value.

 - Alan Hoyt -

Jimi X wrote:

> >>>>> "UC" == Ulf Carlsson <ulfc@calypso.engr.sgi.com> writes:
> >>>>> "AH" == Alan Hoyt <neuroinc@unidial.com> writes:
>
>  AH> At one time, I thought I saw a copy somewhere on oss.sgi.com -
>  AH> but I don't remember which version.  I checked my archives and
>  AH> found a copy of System V ABI MIPS supplement 3.0 in PDF
>  AH> (approx. 463K),
>
> The 3.0 supplement is 32-bit only, I need the 64-bit.
>
>  AH> 3.1 (approx. 651K) and the processor conformace guide 1.2.2
>  AH> (approx 282k).  I can email you a copy if you would like.
>
> Are they 64-bit? If so, please send 3.1 and the PSG 1.2.2. and once the
> oss is up perhaps someone can place them there.
> I have recieved a few "me too" requests so placeing them there would
> be a benifit to all.
>
>  UC> These documents are available at
>  UC> http://www.sco.com/developer/devspecs/,
>
> yeah, but only the the 3.0 supplement (32-bit)
>
>  UC> but we have copies of them at oss.sgi.com too.  Look in
>  UC> /pub/linux/mips/docs/ or sometihng.  I think oss.sgi.com is down
>  UC> for the moment.
>
> I will look there, though it still seems to be down.
>
> Thanks,
>
> -Jimi X
