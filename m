Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 11:36:39 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35476 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029899AbXKELgh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 11:36:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5BaKxf028649;
	Mon, 5 Nov 2007 11:36:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5BaIZO028648;
	Mon, 5 Nov 2007 11:36:18 GMT
Date:	Mon, 5 Nov 2007 11:36:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>, Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071105113618.GD27893@linux-mips.org>
References: <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de> <472E2955.3000803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472E2955.3000803@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 04, 2007 at 09:19:33PM +0100, Franck Bui-Huu wrote:

> > Latest GCC upstream supports it (in SVN since 2007-07-05).
> > 
> 
> Good news although gcc 4.3 release is planed for end of January.
> 
> Is SDE gcc going to be obsolete after this release ?

As for the kernel I don't really care.  The policy is that a working kernel
must be buildable with a stock gcc.  Which at times is painful, search for
all the great use of .word in include/asm-mips/ ...  This doesn't say
anything against taking advantage of other toolchains such SDE; it's just
the functionality must be there with a vanilla GNU toolchain of the miminum
supported version which currently still is 3.2.

  Ralf
