Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 12:46:14 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:49899 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8226142AbVGALp6>; Fri, 1 Jul 2005 12:45:58 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 8B72DC050
	for <linux-mips@linux-mips.org>; Fri,  1 Jul 2005 13:45:42 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 6EA3F1BC079
	for <linux-mips@linux-mips.org>; Fri,  1 Jul 2005 13:45:44 +0200 (CEST)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 69AE31A18AE
	for <linux-mips@linux-mips.org>; Fri,  1 Jul 2005 13:45:45 +0200 (CEST)
Subject: DB1200
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Linux/MIPS Development <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Fri, 01 Jul 2005 13:45:46 +0200
Message-Id: <1120218346.10628.18.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi all,

I am using DB1200 from AMD and have checked this mailing list
and "the rest of the Internet" for information about
Linux and MAE on this board.

It seems there are only few users of this board and there
is a lot of work to be done. I am willing to do it, but
would just like some directions, hints, ... of other
users.

I tried contacting AMD, but until now did not receive any
answer. I tested MAE with their binary images (thank to
Ruslan V.Pisarev) and it works. My main concern is MAE 
(probably this is the main concern for all users
using AU1200, otherwise they wouldn't use it).

What should be done?
Wait for AMD to release the source of the drivers and 
maiplayer, if ever? And probably for 2.4 kernel only :-(
Write new drivers? What would the design be?
I think the best way to use the MAE would be trough 
MPlayer (or xine, ...), like using Dxr3 card or H+, which
is MPEG2 acceleartion card.

Any suggestions?

Thanks and BR,
Matej
