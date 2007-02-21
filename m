Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 09:38:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64450 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037625AbXBUJiB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 09:38:01 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1L9bw0S031214;
	Wed, 21 Feb 2007 09:37:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1L9btnn031213;
	Wed, 21 Feb 2007 09:37:55 GMT
Date:	Wed, 21 Feb 2007 09:37:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1000 PCMCIA broken in 2.6.20
Message-ID: <20070221093754.GA29944@linux-mips.org>
References: <20070221073848.GA9822@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070221073848.GA9822@roarinelk.homelinux.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 21, 2007 at 08:38:48AM +0100, Manuel Lauss wrote:
> Date:	Wed, 21 Feb 2007 08:38:48 +0100
> From:	Manuel Lauss <mano@roarinelk.homelinux.net>
> To:	linux-mips@linux-mips.org
> Subject: Au1000 PCMCIA broken in 2.6.20
> Content-Type: text/plain; charset=us-ascii
> 
> Hello,
> 
> PCMCIA is broken on my Au1200 platform. Seems to me that accesses to Attribute
> memory are broken; a dump of the CIS reveals the following:
> 
> 1.0: ParseTuple: Bad CIS tuple
> 00000000  01 03 ff ff ff 1c 04 ff  ff ff ff 18 02 ff ff 20  |............... |
> 00000010  04 98 00 00 00 15 20 04  ff ff ff ff ff ff ff ff  |...... .........|
> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> 00000030  ff ff ff ff ff ff ff 21  02 04 01 22 02 ff ff 22  |.......!..."..."|
> 00000040  03 ff ff ff 1a 05 ff ff  ff ff ff 1b 08 ff ff ff  |................|
> 00000050  ff ff ff ff ff 1b 06 ff  ff ff ff ff ff 1b 0a ff  |................|
> 00000060  ff ff ff ff ff ff ff ff  ff 1b 06 ff ff ff ff ff  |................|
> 00000070  ff 1b 0f ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> 00000080  ff ff 1b 06 ff ff ff ff  ff ff 1b 0f ff ff ff ff  |................|
> 00000090  ff ff ff ff ff ff ff ff  ff ff ff 1b 06 ff ff ff  |................|
> 000000a0  ff ff ff 14 00                                    |.....|
> 
> it should look like this:
> 00000000  01 03 d9 01 ff 1c 04 03  d9 01 ff 18 02 df 01 20  |............... |
> 00000010  04 98 00 00 00 15 20 04  01 54 4f 53 48 49 42 41  |...... ..TOSHIBA|
> 00000020  20 54 48 4e 43 46 32 35  36 4d 50 47 20 00 00 00  | THNCF256MPG ...|
> 00000030  00 00 00 00 00 00 ff 21  02 04 01 22 02 01 01 22  |.......!..."..."|
> 00000040  03 02 0c 0f 1a 05 01 03  00 02 0f 1b 08 c0 c0 a1  |................|
> 00000050  01 55 08 00 20 1b 06 00  01 21 b5 1e 4d 1b 0a c1  |.U.. ....!..M...|
> 00000060  41 99 01 55 64 f0 ff ff  20 1b 06 01 01 21 b5 1e  |A..Ud... ....!..|
> 00000070  4d 1b 0f c2 41 99 01 55  ea 61 f0 01 07 f6 03 01  |M...A..U.a......|
> 00000080  ee 20 1b 06 02 01 21 b5  1e 4d 1b 0f c3 41 99 01  |. ....!..M...A..|
> 00000090  55 ea 61 70 01 07 76 03  01 ee 20 1b 06 03 01 21  |U.ap..v... ....!|
> 000000a0  b5 1e 4d 14 00                                    |..M..|
> 
> Reverting "[PATCH] Generic ioremap_page_range: mips conversion" makes it
> work again:
> http://www.linux-mips.org/git?p=linux.git;a=commitdiff_plain;h=8e087929df884dbb13e383d49d192bdd6928ecbf;hp=62dfb5541a025b47df9405ff0219c7829a97d83b
> 
> The socket driver I use is a simplified version of au1000_generic and
> au1000_db1x00 combined. None of those have received any updates since
> the above mentioned patch went it.

Yes, the patch indeed is bogus; the MIPS version is capable of dealing with
longer addresses - which only makes a difference for Alchemy.  The Alchemy
designers did quite a nice job except on the address space layout which
really sucks rocks through a straw.

  Ralf
