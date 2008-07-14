Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 15:13:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34280 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20038817AbYGNON0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 15:13:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EEDXic030228;
	Mon, 14 Jul 2008 15:13:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EEDVoM030202;
	Mon, 14 Jul 2008 15:13:31 +0100
Date:	Mon, 14 Jul 2008 15:13:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mips_machtype from EMMA2RH machines
Message-ID: <20080714141331.GC5963@linux-mips.org>
References: <20080714135430.F2578DE7B3@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080714135430.F2578DE7B3@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 14, 2008 at 03:54:30PM +0200, Thomas Bogendoerfer wrote:

> +#error  "Unknown NEC board";

No quotes, no trailing semikolons in a #error statement - they actually
are part of the string in #error which will look like this:

$ cat c.c 
#error  "Unknown NEC board";
$ gcc -o c.o c.c
c.c:1:2: error: #error "Unknown NEC board";
$

  Ralf
