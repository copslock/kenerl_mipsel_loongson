Received:  by oss.sgi.com id <S305167AbPLFRrJ>;
	Mon, 6 Dec 1999 09:47:09 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:35958 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbPLFRqs>;
	Mon, 6 Dec 1999 09:46:48 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA00768; Mon, 6 Dec 1999 09:49:51 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA82809
	for linux-list;
	Mon, 6 Dec 1999 09:43:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA02147;
	Mon, 6 Dec 1999 09:42:46 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id JAA27220;
	Mon, 6 Dec 1999 09:42:41 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14411.62865.239197.617852@liveoak.engr.sgi.com>
Date:   Mon, 6 Dec 1999 09:42:41 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     tsbogend@alpha.franken.de, "Jakma, Paul" <Paul.Jakma@compaq.com>,
        "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indy ISDN on linux?
In-Reply-To: <19991206090850.A765@uni-koblenz.de>
References: <15AD5D7936F8D21198240000F831776E3E7F78@dboexc1.dbo.cpqcorp.net>
	<19991205193539.B6564@hub-fue.franken.de>
	<19991206090850.A765@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
...
 > Could the two ISDN interrupts be just combined into a single one thereby
 > hiding the Indy special features completly from the ISDN code?

     That ought to be possible, at the very least by tieing the enable
and disable of the ISDN interrupts together.
