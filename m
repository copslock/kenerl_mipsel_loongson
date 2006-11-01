Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 18:50:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7318 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039636AbWKASuO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 18:50:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kA1Iocj0028234;
	Wed, 1 Nov 2006 18:50:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kA1Ioa5N028233;
	Wed, 1 Nov 2006 18:50:36 GMT
Date:	Wed, 1 Nov 2006 18:50:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wim Van Sebroeck <wim@iguana.be>
Cc:	Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	"Randy. Dunlap" <rdunlap@xenotime.net>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061101185036.GD4736@linux-mips.org>
References: <20061101184633.GA7056@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101184633.GA7056@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 01, 2006 at 07:46:33PM +0100, Wim Van Sebroeck wrote:

> Thomas: I moved start and stop code into seperate functions. I also
> deleted the #include <rm9k_wdt.h> because the file doesn't exist.

You just didn't see it, include/asm-mips/mach-excite/rm9k_wdt.h.

  Ralf
