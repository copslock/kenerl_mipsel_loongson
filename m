Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 14:22:48 +0100 (BST)
Received: from mail.spb.artcoms.ru ([IPv6:::ffff:82.114.120.253]:16035 "EHLO
	mrelay.spb.artcoms.ru") by linux-mips.org with ESMTP
	id <S8224947AbVGTNWc>; Wed, 20 Jul 2005 14:22:32 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mrelay.spb.artcoms.ru (Postfix) with ESMTP
	id 6ADA9132F7; Wed, 20 Jul 2005 17:24:22 +0400 (MSD)
Received: from mrelay.spb.artcoms.ru ([127.0.0.1])
 by localhost (megera.artcoms.ru [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00833-10; Wed, 20 Jul 2005 17:24:22 +0400 (MSD)
Received: from ALEC (unknown [192.168.249.108])
	by mrelay.spb.artcoms.ru (Postfix) with SMTP
	id 2E612132EF; Wed, 20 Jul 2005 17:24:22 +0400 (MSD)
Message-ID: <012b01c58d2e$54a18250$6cf9a8c0@ALEC>
Reply-To: "Alexander Voropay" <alec@artcoms.ru>
From:	"Alexander Voropay" <alec@artcoms.ru>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org> <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain> <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl> <f07e6e05072002197b529b72@mail.gmail.com> <010901c58d28$15e2a3b0$6cf9a8c0@ALEC> <Pine.LNX.4.61L.0507201347350.30702@blysk.ds.pg.gda.pl>
Subject: Re: bal instruction in gcc 3.x
Date:	Wed, 20 Jul 2005 17:24:15 +0400
Organization: Art Communications
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at spb.artcoms.ru
Return-Path: <alec@artcoms.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alec@artcoms.ru
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> There were discussions as to whether reuse R_MIPS_PC16 for 
> branches or not.  Unfortunately I don't remember the conclusion -- you'd 
> have to find it out yourself.

http://sourceware.org/ml/binutils/2003-02/msg00447.html  (follow thread)

Seems, binutils people have removed this in more recent binutils versions.
MIPS SDE is more conservative there.

--
-=AV=-
