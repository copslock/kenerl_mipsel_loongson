Received:  by oss.sgi.com id <S305156AbQEIXOr>;
	Tue, 9 May 2000 23:14:47 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36446 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQEIXOT>; Tue, 9 May 2000 23:14:19 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA01193; Tue, 9 May 2000 16:18:34 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA25367; Tue, 9 May 2000 16:13:36 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA68835
	for linux-list;
	Wed, 3 May 2000 21:03:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA60627
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 May 2000 21:03:08 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA04598
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 May 2000 21:03:07 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-7.uni-koblenz.de (cacc-7.uni-koblenz.de [141.26.131.7])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id GAA14758;
	Thu, 4 May 2000 06:02:49 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405679AbQECSNr>;
	Wed, 3 May 2000 20:13:47 +0200
Date:   Wed, 3 May 2000 20:13:47 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Netscape support.
Message-ID: <20000503201347.A780@uni-koblenz.de>
References: <391053CB.AC28C02D@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <391053CB.AC28C02D@mips.com>; from carstenl@mips.com on Wed, May 03, 2000 at 06:28:59PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 03, 2000 at 06:28:59PM +0200, Carsten Langgaard wrote:

> Has anyone got netscape or another browser up and running on their MIPS
> machine running linux ?

I had Mozilla running under Linux about two years ago and have sent all
the necessary patches to the maintainers at that time.  It was not
terribly stable, though.  Resizing the window crashed Mozilla but aside
of that it was running just fine.  I gave up tracking the problem since
my Indy by far didn't have enough memory to deal with GDB + Emacs as
GDB frontend + Mozilla.  I guess you need 192mb or more to debug that
resize crash ...  As for text browsers I've built Lynx which was running
just out of the box.  There is a few more text browsers like w3m or Links,
haven't yet tried those under Linux.

  Ralf
