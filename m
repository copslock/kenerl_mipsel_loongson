Received:  by oss.sgi.com id <S305188AbQDVHmf>;
	Sat, 22 Apr 2000 00:42:35 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:5660 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305185AbQDVHmT>;
	Sat, 22 Apr 2000 00:42:19 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA08381; Sat, 22 Apr 2000 00:37:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id AAA68941; Sat, 22 Apr 2000 00:40:32 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA78003
	for linux-list;
	Sat, 22 Apr 2000 00:25:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA71483
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 22 Apr 2000 00:25:35 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA02507
	for <linux@cthulhu.engr.sgi.com>; Sat, 22 Apr 2000 00:25:23 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id ECFD281E; Sat, 22 Apr 2000 09:25:19 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 651AA8FFD; Sat, 22 Apr 2000 09:18:46 +0200 (CEST)
Date:   Sat, 22 Apr 2000 09:18:46 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     Andreas Jaeger <aj@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: binutils 4 kernel   Was: GLIBC 2.2 should work on MIPS-Linux
Message-ID: <20000422091846.F443@paradigm.rfc822.org>
References: <ho8zy7mkeq.fsf@awesome.engr.sgi.com> <Pine.LNX.4.21.0004211258140.20646-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0004211258140.20646-100000@calypso.engr.sgi.com>; from Ulf Carlsson on Fri, Apr 21, 2000 at 01:04:09PM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 01:04:09PM -0700, Ulf Carlsson wrote:
> My binutils patch is here:
> 
> 	oss.sgi.com /pub/linux/mips/src/binutils/binutils-000420.diff.gz
> 
> We're using Ralf's egcs 1.1.2 patch (from the rpms):
> 
> 	oss.sgi.com /pub/linux/mips/src/egcs/egcs-1.1.2.diff.gz

Ok - this combinations compiles an little endian dec mips kernel for
me - Ill try to boot it in a second :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
