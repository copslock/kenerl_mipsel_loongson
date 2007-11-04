Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 17:47:28 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:28639 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20030801AbXKDRrU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 17:47:20 +0000
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id B974148F89;
	Sun,  4 Nov 2007 17:34:11 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1IojZ0-0003Ga-R2; Sun, 04 Nov 2007 17:47:10 +0000
Date:	Sun, 4 Nov 2007 17:47:10 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071104174710.GA9363@networkno.de>
References: <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472D8110.2080506@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Nigel Stephens wrote:
> > Aha, that probably explains it. Franck is using the "SDE for Linux
> > v6.05" toolchain, and in that version of GCC -march=mips32r2 implies a
> 
> [snip]
> 
> BTW, are there any other toolchains out there that support smartmips ASE ?

Latest GCC upstream supports it (in SVN since 2007-07-05).


Thiemo
