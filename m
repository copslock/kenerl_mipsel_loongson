Received:  by oss.sgi.com id <S305175AbQDUUOW>;
	Fri, 21 Apr 2000 13:14:22 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:24647 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQDUUOK>;
	Fri, 21 Apr 2000 13:14:10 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA26854; Fri, 21 Apr 2000 13:09:24 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA99533
	for linux-list;
	Fri, 21 Apr 2000 13:04:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA02572;
	Fri, 21 Apr 2000 13:04:36 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id C6275A7904; Fri, 21 Apr 2000 13:04:09 -0700 (PDT)
Date:   Fri, 21 Apr 2000 13:04:09 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     Andreas Jaeger <aj@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: GLIBC 2.2 should work on MIPS-Linux
In-Reply-To: <ho8zy7mkeq.fsf@awesome.engr.sgi.com>
Message-ID: <Pine.LNX.4.21.0004211258140.20646-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> - binutils (use Ulf's version) and compiler (egcs 1.1.2 get internal
>   compiler errors in some cases).  I'm trying to get gcc 2.96 CVS
>   running but do appreciate your help in testing and fixing.

My binutils patch is here:

	oss.sgi.com /pub/linux/mips/src/binutils/binutils-000420.diff.gz

We're using Ralf's egcs 1.1.2 patch (from the rpms):

	oss.sgi.com /pub/linux/mips/src/egcs/egcs-1.1.2.diff.gz

Ulf
