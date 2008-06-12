Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 13:42:34 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:30607 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28578665AbYFLMmb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 13:42:31 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 6D823FE41A5;
	Thu, 12 Jun 2008 14:42:30 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id E3D763EE99C;
	Thu, 12 Jun 2008 14:41:02 +0200 (CEST)
Received: from lenovo.local (mla78-1-82-240-17-188.fbx.proxad.net [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id BB9C4900EC;
	Thu, 12 Jun 2008 14:41:02 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	"Daniel Laird" <daniel.j.laird@nxp.com>
Subject: Re: [PATCH] : Add support for NXP PNX833x (STB222/5) into linux =?utf-8?q?kernel=E2=80=8F?= (UPDATE)
Date:	Thu, 12 Jun 2008 14:41:00 +0200
User-Agent: KMail/1.9.9
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <64660ef00806120529l5c5979a0j6eb81c0dfc36fabb@mail.gmail.com>
In-Reply-To: <64660ef00806120529l5c5979a0j6eb81c0dfc36fabb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200806121441.01705.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: E3D763EE99C.5F9EF
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hi Daniel,

Le Thursday 12 June 2008 14:29:47 Daniel Laird, vous avez écrit :
> linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h
> linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h
> +
> +/* Initialize GPIO to a known state */
> +static inline void pnx833x_gpio_init(void)
> +{
> +	PNX833X_PIO_DIR = 0;
> +	PNX833X_PIO_DIR2 = 0;
> +	PNX833X_PIO_SEL = 0;
> +	PNX833X_PIO_SEL2 = 0;
> +	PNX833X_PIO_INT_EDGE = 0;
> +	PNX833X_PIO_INT_HI = 0;
> +	PNX833X_PIO_INT_LO = 0;

It would be better if you for instance map a structure to your PIO registers, 
like this :

struct pnx833x_pio_reg {
	u32	in;
	u32	out;
	[..]
};

Then the gpio code would ioremap this registers like this in 
pnx833x_gpio_init :

	struct pnx833x_pio_reg *gpio_reg = ioremap_nocache(0xF00, sizeof(struct 
pnx833x_gpio_reg));
	[..]

So that you could use writel/readl like this :

	writel(0, &gpio_reg->in);

which looks nicer.
-- 
Cordialement, Florian Fainelli
------------------------------
