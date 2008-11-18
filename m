Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 04:43:45 +0000 (GMT)
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:27734 "HELO
	smtp118.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S23736471AbYKREnR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 04:43:17 +0000
Received: (qmail 13048 invoked from network); 18 Nov 2008 04:43:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:Reply-To:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=R7bJtJopVkfTH4sAcXCOSN4XBrmshywErsdt91N8bPb4+Ey5BD6XSHLZJUuIukdbwE9y1C53wgeBQdDtKKke2OrRVUvtK4Ea8iN8SK11QRmuHqZDfcrwU2KW3EuQdrzFFtkcHuTV8PdGXcKz7d4jPaX2JbS9xwr8aKNyLmZ3y1s=  ;
Received: from unknown (HELO pogo.local) (david-b@69.226.222.107 with plain)
  by smtp118.sbc.mail.sp1.yahoo.com with SMTP; 18 Nov 2008 04:43:10 -0000
X-YMail-OSG: s1FQGhIVM1kDPC_BliGREG34G0TTcp6IKsvaS882vDoDe.3JIQZIDkrqzFivjc4lPnEyx0VcXieAXUn05D7TOR_b64RvwpTW329iYW9YDUpyvOGTv2P0wxOcKxhGiVHDqK8-
X-Yahoo-Newman-Property: ymail-3
From:	David Brownell <david-b@pacbell.net>
Reply-To: dbrownell@users.sourceforge.net
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH/RFC v1 08/12] [MIPS] BCM63XX: Add USB EHCI support.
Date:	Mon, 17 Nov 2008 20:43:06 -0800
User-Agent: KMail/1.9.10
Cc:	linux-mips@linux-mips.org, linux-usb@vger.kernel.org
References: <1224382023-24364-1-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1224382023-24364-1-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200811172043.07102.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Saturday 18 October 2008, Maxime Bizon wrote:
>  arch/mips/bcm63xx/Kconfig                          |    2 +
>  arch/mips/bcm63xx/Makefile                         |    1 +
>  arch/mips/bcm63xx/dev-usb-ehci.c                   |   50 +++++++
>  .../asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h        |    6 +
>  drivers/usb/host/ehci-bcm63xx.c                    |  152 ++++++++++++++++++++
>  drivers/usb/host/ehci-hcd.c                        |    5 +
>  drivers/usb/host/ehci.h                            |    5 +

Same general comments as for OHCI.  Also, be sure the patch
comments actually include patch comments.  :)
