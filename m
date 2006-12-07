Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 12:23:35 +0000 (GMT)
Received: from mx.globalone.ru ([194.84.254.251]:47017 "EHLO mx.globalone.ru")
	by ftp.linux-mips.org with ESMTP id S20039158AbWLGMXa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 12:23:30 +0000
Received: from mx.globalone.ru (localhost [127.0.0.1])
	by mx.globalone.ru (8.13.1/8.13.1) with ESMTP id kB7CNNwF020577
	for <linux-mips@linux-mips.org>; Thu, 7 Dec 2006 15:23:24 +0300
Received: from smtp.globalone.ru (smtp.globalone.ru [172.16.38.5])
	by mx.globalone.ru (8.13.1/8.13.1) with ESMTP id kB7CN9nU020398
	for <linux-mips@linux-mips.org>; Thu, 7 Dec 2006 15:23:09 +0300
Received: from voropaya ([172.16.38.7]) by smtp.globalone.ru
          (Netscape Messaging Server 4.15) with SMTP id J9WL2L00.5GX for
          <linux-mips@linux-mips.org>; Thu, 7 Dec 2006 15:23:09 +0300 
Message-ID: <385101c719fa$80448100$e90d11ac@spb.in.rosprint.ru>
From:	"Alexander Voropay" <a.voropay@orange-ftgroup.ru>
To:	<linux-mips@linux-mips.org>
References: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org> <20061207094639.GA30260@lst.de>
Subject: Re: [MIPS] Import updates from i386's i8259.c
Date:	Thu, 7 Dec 2006 15:21:55 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Scanned-By: MIMEDefang 2.56 on 172.16.38.2
Return-Path: <a.voropay@equant.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@orange-ftgroup.ru
Precedence: bulk
X-list: linux-mips

"Christoph Hellwig" <hch@lst.de> wrote:

>> Import many updates from i386's i8259.c, especially genirq transitions.
> 
> Shouldn't we try to share i8259.c over the various architectures that
> use this controller?  With the generic hardirq framework that should be
> possible.

 The "i8259" should be under "ISA" or "EISA" Kconfig option.
AFAIK, all known ISA chipsets contains dual i8259 controllers:
LPC on the PCI-ISA bridge (Cobalt, Malta, ...), 
Intel 82430 EISA Mongoose chipset (Indigo2 IP22, Magnum/Jazz, SNI RM-200, ...)

--
-=AV=-
