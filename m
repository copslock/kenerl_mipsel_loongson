Received:  by oss.sgi.com id <S305167AbPLFMj2>;
	Mon, 6 Dec 1999 04:39:28 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:38190 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbPLFMjN>; Mon, 6 Dec 1999 04:39:13 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA02466; Mon, 6 Dec 1999 04:48:05 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA66481
	for linux-list;
	Mon, 6 Dec 1999 04:36:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA85103
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 04:36:50 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA01726
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 04:36:48 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m11uxNg-0027VFC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 6 Dec 1999 13:36:40 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m11uxNb-002Ol3C; Mon, 6 Dec 99 13:36 MET
Date:   Mon, 6 Dec 1999 13:36:35 +0100
From:   Thomas Bogendoerfer <tsbogend@hub-fue.franken.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     tsbogend@alpha.franken.de, "Jakma, Paul" <Paul.Jakma@compaq.com>,
        "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indy ISDN on linux?
Message-ID: <19991206133635.A2697@hub-fue.franken.de>
Reply-To: tsbogend@alpha.franken.de
References: <15AD5D7936F8D21198240000F831776E3E7F78@dboexc1.dbo.cpqcorp.net> <19991205193539.B6564@hub-fue.franken.de> <19991206090850.A765@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <19991206090850.A765@uni-koblenz.de>; from Ralf Baechle on Mon, Dec 06, 1999 at 09:08:50AM -0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 09:08:50AM -0200, Ralf Baechle wrote:
> Could the two ISDN interrupts be just combined into a single one thereby
> hiding the Indy special features completly from the ISDN code?

sure, but I don't think this kludge will be necessary. Since all of the PC
boards differ from each other, there is already a custom setup routine
which deals with these differences. I'm already using it, but I still
needed to change common code. I've already talked to Karsten Keil
(isdn4linux Maintainer) about that issue, and I'm sure is solvable.

Thomas.
