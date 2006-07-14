Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 08:32:04 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:42908 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133365AbWGNHby (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 08:31:54 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id D8AA2DB;
	Fri, 14 Jul 2006 09:31:44 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id AD2A51BC087;
	Fri, 14 Jul 2006 09:31:46 +0200 (CEST)
Received: from [192.168.80.1] (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 50C081A18A5;
	Fri, 14 Jul 2006 09:31:46 +0200 (CEST)
Subject: Re: Suspend to RAM
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Dusko Dobranic <dusko.dobranic@micronasnit.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <44B65D71.7080905@micronasnit.com>
References: <44B65D71.7080905@micronasnit.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Fri, 14 Jul 2006 09:31:47 +0200
Message-Id: <1152862307.5876.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> Does anyone has successfully implemented Suspend to RAM feature on MIPS32R2?

We did that on the DB1200 board.

> How can I restart kernel after putting system to sleep?

Your bootloader should support this. U-Boot does, at least
for the Alchemy CPU. 
Look for the mails from the Rodolfo Giometti. He posted
patches to this mailing list and to the U-Boot mailing list
to support resume for the au1x00 CPU.

BR,
Matej
