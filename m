Received:  by oss.sgi.com id <S42294AbQEaPwp>;
	Wed, 31 May 2000 08:52:45 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33552 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42289AbQEaPw2>; Wed, 31 May 2000 08:52:28 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA01425; Wed, 31 May 2000 08:29:16 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA74253; Wed, 31 May 2000 08:23:58 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA12976
	for linux-list;
	Wed, 31 May 2000 08:18:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA98945
	for <linux@engr.sgi.com>;
	Wed, 31 May 2000 08:18:52 -0700 (PDT)
	mail_from (scott@tridsys.com)
Received: from mailserver.tridsys.com (news.tridsys.com [207.86.66.211]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09588
	for <linux@engr.sgi.com>; Wed, 31 May 2000 08:17:00 -0700 (PDT)
	mail_from (scott@tridsys.com)
Received: from dull.tridsys.com (dull.tridsys.com [207.86.66.203]) by mailserver.tridsys.com (NTMail 4.30.0013/NY2276.00.00796d4c) with ESMTP id wggnaaaa for <linux@engr.sgi.com>; Wed, 31 May 2000 11:15:53 -0400
From:   "Scott Thomas" <scott@tridsys.com>
To:     <linux@cthulhu.engr.sgi.com>
Subject: problem with download
Date:   Wed, 31 May 2000 11:17:52 -0400
Message-ID: <002901bfcb13$63798a30$fe01a8c0@scott.tridsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello all,
I've just recently acquired an old SGI Indy and planned to install
Linux on it.  I've downloaded the hardhat-sgi-5.1.tar.gz file several
times (from ftp.linux.sgi.com).  the ftp downloads the entire file,
but never sees the EOF.

when I try to un-tar it, it chokes since I believe the EOF marker
is missing.  I'm in the process of trying the mirror sites, but I was
wondering if anyone else has had this problem, and if so how
did they overcome it?

btw, I noticed nothing has been posted to http://www.linux.sgi.com
for over a year.  is anyone still working/interested in linux-mips?

--
Scott Thomas
Program Manager
Trident Systems Inc.
Phone: (703) 359-6226
  Fax: (703) 273-6608
Email: scott@tridsys.com
  Web: http://www.tridsys.com
