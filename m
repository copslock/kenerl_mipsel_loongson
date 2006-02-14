Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 09:55:41 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24584 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133421AbWBNJzc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 09:55:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5308DF5A2C;
	Tue, 14 Feb 2006 11:01:52 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13880-09; Tue, 14 Feb 2006 11:01:52 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1350DE1C65;
	Tue, 14 Feb 2006 11:01:52 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1EA1iEn018207;
	Tue, 14 Feb 2006 11:01:45 +0100
Date:	Tue, 14 Feb 2006 10:01:51 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060213232329.GA8286@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0602140950200.14255@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
 <20060124122700.GA8527@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver>
 <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl>
 <20060203150232.GA25701@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
 <20060213225927.GB4226@deprecation.cyrius.com> <20060213232329.GA8286@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="328795856-308165493-1139911311=:14255"
X-Virus-Scanned: ClamAV 0.87.1/1287/Mon Feb 13 22:29:18 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--328795856-308165493-1139911311=:14255
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Feb 2006, Martin Michlmayr wrote:

> OK, I got it down to:
> 
>   CC      drivers/tc/lk201.o
> drivers/tc/lk201.c: In function ‘lk201_rx_char’:
> drivers/tc/lk201.c:361: warning: implicit declaration of function ‘handle_scancode’
> drivers/tc/lk201.c: In function ‘lk201_init’:
> drivers/tc/lk201.c:405: error: invalid lvalue in assignment
> drivers/tc/lk201.c:406: error: invalid lvalue in assignment
> make[2]: *** [drivers/tc/lk201.o] Error 1
> 
> But this driver really needs to be ported to the new input interface.

 The driver has been ported by JBG (thanks!) -- it's the zs.c driver that 
needs to be ported to the new serial infrastructure.  But that's tough if 
to be done properly (DMA and synchronous modes are not handled well by the 
serial core), so not at the moment, sorry.  I'll think about minimal 
functionality to keep it going though and perhaps lk201.c could be changed 
to work with current zs.c as is (dz.c has already been ported -- I have no 
way of testing it, so I somewhat lack incentive to go through it and 
verify if it's at least as good as the old driver in 2.4.)...

 I'm not sure what your patch is meant to do, but if changing rate to 
period you need to invert the values as well -- period = 1 / rate -- and 
the hardware expects rates in cps IIRC; mind the units, though.

  Maciej
--328795856-308165493-1139911311=:14255--
