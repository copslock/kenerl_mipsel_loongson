Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA38621 for <linux-archive@neteng.engr.sgi.com>; Wed, 27 Jan 1999 09:41:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA51370
	for linux-list;
	Wed, 27 Jan 1999 09:40:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA07572
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 27 Jan 1999 09:40:47 -0800 (PST)
	mail_from (asnmaz01@asc.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02674
	for <linux@cthulhu.engr.sgi.com>; Wed, 27 Jan 1999 09:40:45 -0800 (PST)
	mail_from (asnmaz01@asc.edu)
Received: from asc.edu (138.26.15.137) by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.DC7A4200@vera.dpo.uab.edu>; Wed, 27 Jan 1999 11:40:38 -0600
Message-ID: <36AF5027.80A9F6CD@asc.edu>
Date: Wed, 27 Jan 1999 11:43:03 -0600
From: "Mark A. Zottola" <asnmaz01@asc.edu>
X-Mailer: Mozilla 4.5 [en] (Win95; I)
X-Accept-Language: en
MIME-Version: 1.0
To: SGI Linux Group <linux@cthulhu.engr.sgi.com>
Subject: FORTRAN Compoiler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I am leading the effort to build a Beowulf cluster out of Indigo2's on
the UAB campus. My student Andrew posted our intentions to this list a
few days ago. While we are in the process of getting started in the
porting process, I would like to do some benchmarking on the System we
currently have. Therefore I need a compiler (or much less optimally -
compilers) which run on MIPS architecture and can be used both with
LINUX and IRIX. A tall order to be sure. I really do NOT want to use the
gnu f77 compiler (and I do not know whether it will work on IRIX or
not).

I realize this is slightly off topic (ok greatly off topic), but any
hints would be greatly appreciated! Thanks!
--
*********
Mark A. Zottola                       Alabama Research and Education
Network
119 Rust Research Center              Nichols Research Corporation
University of Alabama-Birmingham      VOICE:  (205) 934-3893
Birmingham, AL  35294                 EMAIL:  asnmaz01@csimail.asc.edu
