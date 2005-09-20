Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 12:00:34 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:2467 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8225294AbVITLAO>; Tue, 20 Sep 2005 12:00:14 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 81C15C024;
	Tue, 20 Sep 2005 13:00:05 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 2F9451BC08C;
	Tue, 20 Sep 2005 13:00:08 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id B80BB1A18B0;
	Tue, 20 Sep 2005 13:00:07 +0200 (CEST)
Subject: Re: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0509201140160.23494@blysk.ds.pg.gda.pl>
References: <20050920032818.GA7199@nevyn.them.org>
	 <Pine.LNX.4.61L.0509201140160.23494@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Date:	Tue, 20 Sep 2005 13:00:04 +0200
Message-Id: <1127214005.2149.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > This caused incorrect checksums in some UDP packets for NFS root.  The
> > problem was mild when using a 10.0.1.x IP address, but severe when
> > using 192.168.1.x.
> 
>  Ah!  So *that* is the reason for the absolutely abysmal NFS performance 
> of the SWARM with 2.6!  I have had no time to track it down -- thanks a 
> lot!

Is this for MIPS64 only?
Because, on dbau1200 we also have poor NFS performance :-(

BR,
Matej
