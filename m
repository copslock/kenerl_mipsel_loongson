Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 11:06:58 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:29199
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8226018AbUGFKGw>; Tue, 6 Jul 2004 11:06:52 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Bhmqe-0004Ok-00; Tue, 06 Jul 2004 12:06:48 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Bhmqd-0003DQ-00; Tue, 06 Jul 2004 12:06:47 +0200
Date: Tue, 6 Jul 2004 12:06:47 +0200
To: Thomas Kunze <thomas.kunze@xmail.net>
Cc: a.voropay@vmb-service.ru, linux-mips@linux-mips.org
Subject: Re: Linux on SNI RM300E ?
Message-ID: <20040706100647.GB21982@rembrandt.csv.ica.uni-stuttgart.de>
References: <038c01c46334$38621de0$0200000a@ALEC> <1089105260.40ea6d6cf2f9c@www.x-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089105260.40ea6d6cf2f9c@www.x-mail.net>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thomas Kunze wrote:
> Quoting Alexander Voropay <a.voropay@vmb-service.ru>:
> 
> >  AFAIK, the RM300E is an ARC compatible. (?)
> i don't no. i saw something like that on the net. but nothing about that in the manuals
> that i have.

It is, AFAIK. But the woody kernel is for a SGI Indy/Indigo2, not for
RM300E. The linux-mips.org tree has only support for RM200C, adding
support for RM300E is probably not that complicated if it is similiar
enough.

> >  So, try to load "arcdiag" utility instead of kernel :
> > 
> > ftp://ftp.sra.co.jp/pub/os/NetBSD/misc/arc/
> > 
> i've downloaded the arcdiag-0.2 and served it via tftp. but the RM300E don't like that
> file. it only says "Bad magic number". what does this mean (little/bigendian)? 

Wrong endianness. Your machine apparently has big endian firmware.


Thiemo
