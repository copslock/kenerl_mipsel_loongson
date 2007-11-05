Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 23:30:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:41965 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576713AbXKEXa2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 23:30:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5NUQ9c024546;
	Mon, 5 Nov 2007 23:30:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5NUPRs024545;
	Mon, 5 Nov 2007 23:30:25 GMT
Date:	Mon, 5 Nov 2007 23:30:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>, Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071105233025.GB12514@linux-mips.org>
References: <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de> <472E2955.3000803@gmail.com> <20071105113618.GD27893@linux-mips.org> <472F8C82.4080406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472F8C82.4080406@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 05, 2007 at 10:34:58PM +0100, Franck Bui-Huu wrote:

> It's actually hard to know the advantages of using SDE over a stock gcc.
> The only difference I'm aware of is the smartmips ASE support in SDE.
> But since this support is going to be added in stock gccs, I don't see
> any advantages now and I'm wondering if I can give up using SDE...

In general terms the toolchain has been more reliable and had better
support for MIPS processors before FSF gcc.

  Ralf
