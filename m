Received:  by oss.sgi.com id <S305181AbPKWWqK>;
	Tue, 23 Nov 1999 14:46:10 -0800
Received: from [192.48.153.1] ([192.48.153.1]:54143 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305180AbPKWWps>;
	Tue, 23 Nov 1999 14:45:48 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07370
	for <linuxmips@oss.sgi.com>; Tue, 23 Nov 1999 14:52:00 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA52035
	for linux-list;
	Tue, 23 Nov 1999 14:28:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA90845
	for <linux@engr.sgi.com>;
	Tue, 23 Nov 1999 14:28:14 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00882
	for <linux@engr.sgi.com>; Tue, 23 Nov 1999 14:28:11 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from cacc-17.uni-koblenz.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA07786;
	Tue, 23 Nov 1999 23:24:50 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPKWWTR>;
	Tue, 23 Nov 1999 23:19:17 +0100
Date:   Tue, 23 Nov 1999 23:19:17 +0100
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     "Bradley D. LaRonde" <brad@ltc.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Another .text question
Message-ID: <19991123231917.G16508@uni-koblenz.de>
References: <028a01bf3571$c1bc8f80$b8119526@ltc.com> <19991123230723.D16508@uni-koblenz.de> <01e401bf3600$e30a0d90$b8119526@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <01e401bf3600$e30a0d90$b8119526@ltc.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Nov 23, 1999 at 05:20:02PM -0500, Bradley D. LaRonde wrote:

> > Everything is writeable in the kernel case.
> 
> Thing is I'm executing out of ROM, so I have to divide between writeable and
> non-writeable.
> 
> Will you consider switch those two .texts to .datas in the SGI sources?

No problem, just the correct alignment has to be guaranteed.

  Ralf
