Received:  by oss.sgi.com id <S305167AbQBRWno>;
	Fri, 18 Feb 2000 14:43:44 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54882 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQBRWnb>; Fri, 18 Feb 2000 14:43:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA03454; Fri, 18 Feb 2000 14:46:26 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA65407
	for linux-list;
	Fri, 18 Feb 2000 14:29:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA25066
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 18 Feb 2000 14:29:52 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05977
	for <linux@cthulhu.engr.sgi.com>; Fri, 18 Feb 2000 14:29:56 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA05003;
	Fri, 18 Feb 2000 23:29:45 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407898AbQBRVqJ>;
	Fri, 18 Feb 2000 22:46:09 +0100
Date:   Fri, 18 Feb 2000 22:46:09 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Marc Esipovich <marc@mucom.co.il>
Cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Current cvs kernerl fails to compile for decstation
Message-ID: <20000218224609.C24098@uni-koblenz.de>
References: <20000218102505.B369@paradigm.rfc822.org> <Pine.LNX.4.20.0002181504271.6252-100000@mucom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.20.0002181504271.6252-100000@mucom.co.il>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Feb 18, 2000 at 03:05:18PM -0200, Marc Esipovich wrote:

> > #if HZ == 100
> > #define TCP_TW_RECYCLE_TICK (7+2-TCP_TW_RECYCLE_SLOTS_LOG)
> > #elif HZ == 1024
> > #define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
> > #else
> > #error HZ != 100 && HZ != 1024.
> > #endif
> 
> Without looking or knowing the source,  my recommendation is, see where HZ
> is defined, and find out why it's not defined as either 100 or 1024, but
> you know that already ;)

It's 64 because it's not possible to program the DECstation RTC to 100Hz
or 1024Hz.

  Ralf
