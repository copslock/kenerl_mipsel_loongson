Received:  by oss.sgi.com id <S305157AbQCQQ3Z>;
	Fri, 17 Mar 2000 08:29:25 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:49001 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCQQ3J>; Fri, 17 Mar 2000 08:29:09 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA03327; Fri, 17 Mar 2000 08:32:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA70388
	for linux-list;
	Fri, 17 Mar 2000 08:18:13 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA68876
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Mar 2000 08:18:10 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA00833
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Mar 2000 08:18:09 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA10351
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Mar 2000 08:18:08 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA12642
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Mar 2000 08:18:06 -0800 (PST)
Message-ID: <00b801bf902c$ddb30140$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Include coherency problem, sigaction and otherwise
Date:   Fri, 17 Mar 2000 17:21:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Invesitgating some non-fatal but odd behaviour, we
have traced it to the fact that the defintions of various
sigaction flags are defined for MIPS/Linux user code
in /usr/include/sigaction.h, but defined for the kernel in
/usr/include/asm/signal.h, and that the two definitions
are not consistent.  Does anyone know how this
came about?  

I have the impresson that the /usr/include stuff in the 
"Hard Hat" distribution for MIPS is keyed to a 2.0.x kernel, 
and that an update of /usr/include (as opposed to a downgrade 
of the kernel headers) may be in order.    Frankly, I don't like 
the fact that the user and kernel includes don't pull everything 
out of common files in include/linux and include/asm - I suppose 
it must have been to reduce the number of compilations
that depend on kernel includes - but I don't see that
we can do much about that from here in MIPS-land.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
