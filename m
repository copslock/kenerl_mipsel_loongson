Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 21:21:47 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:31900 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133540AbWADVV1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 21:21:27 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 6D740C0B5;
	Wed,  4 Jan 2006 22:23:44 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 09C1C1BC07F;
	Wed,  4 Jan 2006 22:23:50 +0100 (CET)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 9E92E1A18B6;
	Wed,  4 Jan 2006 22:23:49 +0100 (CET)
Subject: Re: smc91x support
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	ppopov@embeddedalley.com
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1131636585.4890.14.camel@localhost.localdomain>
References: <1131634331.18165.30.camel@localhost.localdomain>
	 <1131636585.4890.14.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Wed, 04 Jan 2006 22:23:52 +0100
Message-Id: <1136409832.11317.54.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi 

> > smc91x platform support; requires patch to smc91x.h which was sent
> >         upstream.
> > 
> > Any news about this?
> > What is the patch required for smc91x.h?
> 
> I have to check with Nicolas Pitre.

Pete, did you see this:
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-January/033064.html

Will it work for MIPS and especially for DBAU12100?

BR,
Matej
