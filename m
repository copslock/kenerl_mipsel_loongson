Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 13:08:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2945 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037768AbWLHNIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Dec 2006 13:08:06 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB8D86dl007582;
	Fri, 8 Dec 2006 13:08:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB8D86Tu007581;
	Fri, 8 Dec 2006 13:08:06 GMT
Date:	Fri, 8 Dec 2006 13:08:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] add STB810 support (Philips PNX8550-based)
Message-ID: <20061208130806.GA7439@linux-mips.org>
References: <20061208114035.000049c4.vitalywool@gmail.com> <20061208130543.GB5797@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208130543.GB5797@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 08, 2006 at 01:05:43PM +0000, Ralf Baechle wrote:

Hmmm...

  CC      arch/mips/philips/pnx8550/common/setup.o
arch/mips/philips/pnx8550/common/setup.c:27:34: error: linux/serial_pnx8xxx.h: No such file or directory
arch/mips/philips/pnx8550/common/setup.c: In function 'plat_mem_setup':
arch/mips/philips/pnx8550/common/setup.c:147: error: 'PNX8XXX_UART_LCR_8BIT' undeclared (first use in this function)
arch/mips/philips/pnx8550/common/setup.c:147: error: (Each undeclared identifier is reported only once
arch/mips/philips/pnx8550/common/setup.c:147: error: for each function it appears in.)
make[1]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
make: *** [arch/mips/philips/pnx8550/common] Error 2

   Ralf
