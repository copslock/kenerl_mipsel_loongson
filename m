Received:  by oss.sgi.com id <S305167AbQBRWly>;
	Fri, 18 Feb 2000 14:41:54 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:18274 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQBRWlb>; Fri, 18 Feb 2000 14:41:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA06925; Fri, 18 Feb 2000 14:44:26 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA49263
	for linux-list;
	Fri, 18 Feb 2000 14:30:16 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA69223
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 18 Feb 2000 14:30:12 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06744
	for <linux@cthulhu.engr.sgi.com>; Fri, 18 Feb 2000 14:30:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA05023;
	Fri, 18 Feb 2000 23:29:59 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBRVg2>;
	Fri, 18 Feb 2000 22:36:28 +0100
Date:   Fri, 18 Feb 2000 22:36:28 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Current cvs kernerl fails to compile for decstation
Message-ID: <20000218223628.A24098@uni-koblenz.de>
References: <20000218102505.B369@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000218102505.B369@paradigm.rfc822.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Feb 18, 2000 at 10:25:05AM +0100, Florian Lohoff wrote:

> #if HZ == 100
> #define TCP_TW_RECYCLE_TICK (7+2-TCP_TW_RECYCLE_SLOTS_LOG)
> #elif HZ == 1024
> #define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
> #else
> #error HZ != 100 && HZ != 1024.
> #endif

How about making that:

#if HZ == 100
#define TCP_TW_RECYCLE_TICK (7+2-TCP_TW_RECYCLE_SLOTS_LOG)
#elif HZ == 64
#define TCP_TW_RECYCLE_TICK (6+2-TCP_TW_RECYCLE_SLOTS_LOG)
#elif HZ == 1024
#define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
#else
#error HZ != 100 && HZ != 1024.
#endif

Without further reading the context that would by my first attempt.

> Hrmpf ...

Imagine, and tomorrow I'm going to break all networking drivers :-)

  Ralf
