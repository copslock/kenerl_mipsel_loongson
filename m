Received:  by oss.sgi.com id <S305179AbQCVQCy>;
	Wed, 22 Mar 2000 08:02:54 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:52782 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305174AbQCVQCc>;
	Wed, 22 Mar 2000 08:02:32 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA19851; Wed, 22 Mar 2000 07:57:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA47806; Wed, 22 Mar 2000 08:02:30 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA06365
	for linux-list;
	Wed, 22 Mar 2000 07:24:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA32831
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Mar 2000 07:24:25 -0800 (PST)
	mail_from (natorro@adem.fciencias.unam.mx)
Received: from adem.fciencias.unam.mx (adem.fciencias.unam.mx [132.248.28.57]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA02827
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Mar 2000 07:23:56 -0800 (PST)
	mail_from (natorro@adem.fciencias.unam.mx)
From:   natorro@adem.fciencias.unam.mx
Received: from localhost (natorro@localhost)
	by adem.fciencias.unam.mx (8.8.7/8.8.7) with SMTP id JAA08020
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Mar 2000 09:17:12 -0600
Date:   Wed, 22 Mar 2000 09:17:11 -0600 (CST)
To:     linux@cthulhu.engr.sgi.com
Subject: Installing GNU Pascal Compiler
In-Reply-To: <Pine.LNX.3.96.1000317152030.821A-100000@adem.fciencias.unam.mx>
Message-ID: <Pine.LNX.3.96.1000322091118.8003A-100000@adem.fciencias.unam.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi, I have just installed the Hard Hat distribution and now
I really need to install a Pascal Compiler, I downloaded the
source and the sources of GCC version 2.8.1 I tried to install it
doing all the stuff it says, but when I do "make LANGUAGES=pascal"
it complains about some flags, I took the flags out from the Makefile
and after it it complains more, I don't really undestand what it says,
does anyone here has installed this compiler sucessfully???
I typed "gcc --version" and it prints version 2.7.2 
I haven't installed any packages apart from the rpm's that came
with the distribution.

Any help will be greatly appreciated, thanks a lot.
Cheers
natorro
