Received:  by oss.sgi.com id <S305155AbQDUIsj>;
	Fri, 21 Apr 2000 01:48:39 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54388 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305157AbQDUIsR>; Fri, 21 Apr 2000 01:48:17 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA00658; Fri, 21 Apr 2000 01:52:20 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id BAA47950; Fri, 21 Apr 2000 01:47:46 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA41775
	for linux-list;
	Fri, 21 Apr 2000 01:38:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA28706
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Apr 2000 01:38:14 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA05293
	for <linux@cthulhu.engr.sgi.com>; Fri, 21 Apr 2000 01:38:13 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA27033;
	Fri, 21 Apr 2000 01:38:11 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA10869;
	Fri, 21 Apr 2000 01:38:07 -0700 (PDT)
Message-ID: <006401bfab6d$2a6cedb0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Cc:     "Linux/MIPS fnet" <linux-mips@fnet.fr>
Subject: More oddities in traps.c
Date:   Fri, 21 Apr 2000 10:39:51 +0200
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

So while we're on the topic of cruft in arch/mips/kernel/traps.c,
does anyone know why the cache error exception vector is
overwritten with a copy of the TLB miss handler as part of
vector setup on R4xxx and R5xxx CPUs?
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
