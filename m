Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 13:49:21 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:34500 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8226719AbVGNMtD>; Thu, 14 Jul 2005 13:49:03 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id AC995C04D;
	Thu, 14 Jul 2005 14:49:58 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 0A6941BC08D;
	Thu, 14 Jul 2005 14:50:01 +0200 (CEST)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 117DF1A18AD;
	Thu, 14 Jul 2005 14:50:00 +0200 (CEST)
Subject: Re: Au1550 ethernet throughput low
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	jaypee@hotpop.com
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1121270402l.7656l.3l@cavan>
References: <1121270402l.7656l.3l@cavan>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Thu, 14 Jul 2005 17:02:26 +0200
Message-Id: <1121353347.10582.3.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I've got a au1550 board based largely on the pb1550. The ethernet  
> throughput is ~66Mbps using the 2.6 kernel. This also consumes a
> lot of cpu cycles to send.

I get low throughput with DB1200 also, although I did not measure
it (yet). I noticed very slow NFS mounted rootfs and I get a lot of:
NFS server not responding, still trying
NFS server O.K.
(Something like that, I do not have the board here right now).

AMD supplies smc9111 driver in smc9111.c/h. Should I use
this driver or is smc9x.c/h better?

BR,
Matej
