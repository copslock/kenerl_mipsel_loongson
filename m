Received:  by oss.sgi.com id <S305159AbPLESnX>;
	Sun, 5 Dec 1999 10:43:23 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61453 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbPLESnF>; Sun, 5 Dec 1999 10:43:05 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA04284; Sun, 5 Dec 1999 10:51:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA60151
	for linux-list;
	Sun, 5 Dec 1999 10:35:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA62553
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 5 Dec 1999 10:35:50 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA01195
	for <linux@cthulhu.engr.sgi.com>; Sun, 5 Dec 1999 10:35:48 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m11ugVa-0027chC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 5 Dec 1999 19:35:42 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m11ugVX-002OkjC; Sun, 5 Dec 99 19:35 MET
Date:   Sun, 5 Dec 1999 19:35:39 +0100
From:   Thomas Bogendoerfer <tsbogend@hub-fue.franken.de>
To:     "Jakma, Paul" <Paul.Jakma@compaq.com>
Cc:     "'Ralf Baechle'" <ralf@oss.sgi.com>,
        "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indy ISDN on linux?
Message-ID: <19991205193539.B6564@hub-fue.franken.de>
Reply-To: tsbogend@alpha.franken.de
References: <15AD5D7936F8D21198240000F831776E3E7F78@dboexc1.dbo.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.5us
In-Reply-To: <15AD5D7936F8D21198240000F831776E3E7F78@dboexc1.dbo.cpqcorp.net>; from Jakma, Paul on Fri, Dec 03, 1999 at 01:43:11PM -0000
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Dec 03, 1999 at 01:43:11PM -0000, Jakma, Paul wrote:
> > Thomas Bogendörfer has implemented the full ISDN support for 
> > the IP22.  The bad news is that his job keeps him to busy to add some 
> > finishing touches and contribute the code back.

thanks Ralf for answering.

> I assume his work will be rolled into isdn4linux? Would anyone know of a
> timeframe?

my plan is to integrate my changes into isdn4linux. My current patches
are based on an older isdn4linux version, so I have figure out, what I
need to update and see how a clean integration will be possible (the
Indy ISDN hardware is based on the "normal" Siemens ISDN chips, which could
be found on many cheap ISDN cards. But unlike PC boards it uses two interrupts
instead of one, which makes integration a little bit hairy).

At the moment I don´t have a clue, when I'll find time to even bring up 
my Linux Indy kernel to the current version. I could generate a diff file,
if you want to see, what needs to be done.

Thomas.
