Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2007 00:01:20 +0000 (GMT)
Received: from blu139-omc1-s10.blu139.hotmail.com ([65.55.175.150]:38923 "EHLO
	blu139-omc1-s10.blu139.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20030868AbXLGABM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2007 00:01:12 +0000
Received: from BLU127-W9 ([65.55.162.182]) by blu139-omc1-s10.blu139.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Dec 2007 16:00:44 -0800
Message-ID: <BLU127-W9F2B1A00F26057FD989498A680@phx.gbl>
X-Originating-IP: [157.185.36.161]
From:	Nathan Eggan <nathan_eggan@live.com>
To:	linux-mips mailing list <linux-mips@linux-mips.org>
Subject: Re: Bug in Au1x00 UART or USB drivers for 2.6 kernels?
Date:	Fri, 7 Dec 2007 00:00:44 +0000
Importance: Normal
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 07 Dec 2007 00:00:44.0561 (UTC) FILETIME=[36B27810:01C83864]
Return-Path: <nathan_eggan@live.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan_eggan@live.com
Precedence: bulk
X-list: linux-mips


A'ight... I just finished pulling down a copy of the Linux-mips kernel 2.6.23.9 and building it for my DBAu1500.  I was hoping this would fix the issue I'm experiencing with the serial ports and the USB bus.  (For those that didn't catch the previous emails, I'm suffering byte substitution in a very regular pattern on the Au1500's UARTs when I put activity on the USB bus.)

Unfortunately, the new kernel appears to have no effect.  :(  It performs the same as the previous.

For the record, my tested setup was:
- Linux 2.6.23 with the MIPS patches
- Busybox 1.7.3 (doubt this is relevant)
- compiled with uClibc-0.9.28 & gcc-3.4.5 (this probably isn't relevant either)

All the tests I've discussed to date were down with the test code previously included in this thread, and the serial port was set for 115,200bps 8-N-1.  (I've heard the 115k number can be taboo for some unknown reason, but we really need the speed on the UART.  :(  (It's already slow enough!)  So, I'm not sure too many folks would be happy if I halve it 56k to try to make it work.

A few other notes:
- As previously stated, a 2.4.26 kernel I tried worked fine; so this looks to be a 2.6 kernel issue.  (I've now tried 2.6.17, 2.6.21, and 2.6.23.9 and all have the same issue.)
- I also tried using an FTDI USB-to-serial dongle and experienced NO errors.  So, this is clearly an interplay issue between the UART and the USB bus.

Any other others?

Thanks again!
Nate
_________________________________________________________________
Put your friends on the big screen with Windows Vista® + Windows Live™.
http://www.microsoft.com/windows/shop/specialoffers.mspx?ocid=TXT_TAGLM_CPC_MediaCtr_bigscreen_102007
From ralf@linux-mips.org Fri Dec  7 11:37:58 2007
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2007 11:38:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19932 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031765AbXLGLh6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Dec 2007 11:37:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB7BbMin007612;
	Fri, 7 Dec 2007 11:37:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB71tKbv001304;
	Fri, 7 Dec 2007 01:55:20 GMT
Date:	Fri, 7 Dec 2007 01:55:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: Fix Au1x SD controller IRQ
Message-ID: <20071207015519.GA1231@linux-mips.org>
References: <20071206071156.GA20211@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071206071156.GA20211@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 06, 2007 at 08:11:56AM +0100, Manuel Lauss wrote:

> With the introduction of MIPS_CPU_IRQ_BASE, the hardcoded IRQ number
> of the au1100/au1200 SD controller(s) is no longer valid.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Thanks, applied.

  Ralf
