Received:  by oss.sgi.com id <S305166AbPLFLS3>;
	Mon, 6 Dec 1999 03:18:29 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:56642 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbPLFLSE>;
	Mon, 6 Dec 1999 03:18:04 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA08952; Mon, 6 Dec 1999 03:25:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA96135
	for linux-list;
	Mon, 6 Dec 1999 03:12:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA57096
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 03:12:03 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07766
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 03:12:00 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLFLIu>;
	Mon, 6 Dec 1999 09:08:50 -0200
Date:   Mon, 6 Dec 1999 09:08:50 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     tsbogend@alpha.franken.de
Cc:     "Jakma, Paul" <Paul.Jakma@compaq.com>,
        "'Ralf Baechle'" <ralf@oss.sgi.com>,
        "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indy ISDN on linux?
Message-ID: <19991206090850.A765@uni-koblenz.de>
References: <15AD5D7936F8D21198240000F831776E3E7F78@dboexc1.dbo.cpqcorp.net> <19991205193539.B6564@hub-fue.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <19991205193539.B6564@hub-fue.franken.de>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Dec 05, 1999 at 07:35:39PM +0100, Thomas Bogendoerfer wrote:

> > I assume his work will be rolled into isdn4linux? Would anyone know of a
> > timeframe?
> 
> my plan is to integrate my changes into isdn4linux. My current patches
> are based on an older isdn4linux version, so I have figure out, what I
> need to update and see how a clean integration will be possible (the
> Indy ISDN hardware is based on the "normal" Siemens ISDN chips, which could
> be found on many cheap ISDN cards. But unlike PC boards it uses two interrupts
> instead of one, which makes integration a little bit hairy).
> 
> At the moment I don´t have a clue, when I'll find time to even bring up 
> my Linux Indy kernel to the current version. I could generate a diff file,
> if you want to see, what needs to be done.

I won't be able to do this as I only have POTS, not ISDN at home and anyway
the other works that I have to do is going slower than expected :-(

Could the two ISDN interrupts be just combined into a single one thereby
hiding the Indy special features completly from the ISDN code?

  Ralf
