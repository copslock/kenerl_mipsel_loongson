Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA22314; Mon, 2 Jun 1997 11:25:56 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA29640 for linux-list; Mon, 2 Jun 1997 11:25:43 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.41]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA29610; Mon, 2 Jun 1997 11:25:39 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA05161; Mon, 2 Jun 1997 11:25:27 -0700
Date: Mon, 2 Jun 1997 11:25:27 -0700
Message-Id: <199706021825.LAA05161@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "David S. Miller" <davem@jenolan.rutgers.edu>
Cc: shaver@neon.ingenia.ca, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
Subject: Re: ah...
In-Reply-To: <199705302211.SAA00360@jenolan.caipgeneral>
References: <199705302159.OAA04831@fir.engr.sgi.com>
	<199705302211.SAA00360@jenolan.caipgeneral>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 > 
 > How can you tell if you have an IRIX binary which needs the old or new
 > socket constants?  Is it at the COFF/ELF file format boundary?

     Yes.  An IRIX 4 (COFF) binary needs the old constants.  An IRIX 5 or
6 (ELF) binary needs the new constants.
