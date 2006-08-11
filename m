Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 20:47:09 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2960 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20045061AbWHKTrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 20:47:05 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7BK7FcY004352;
	Fri, 11 Aug 2006 21:07:16 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7BK7FJG004351;
	Fri, 11 Aug 2006 21:07:15 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	thomas@koeller.dyndns.org
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200608102319.13679.thomas@koeller.dyndns.org>
References: <200608102319.13679.thomas@koeller.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 11 Aug 2006 21:07:14 +0100
Message-Id: <1155326835.24077.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Iau, 2006-08-10 am 23:19 +0200, ysgrifennodd
thomas@koeller.dyndns.org:
> +	wd_regs = ioremap_nocache(rr->start, rr->end + 1 - rr->start);

If this fails ?

> +	res = misc_register(&miscdev);
> +	if (res)
> +		iounmap(wd_regs);
> +	register_reboot_notifier(&wdt_gpi_shutdown);
> +	return res;

Failure path appears incomplete, surely you don't want to register a
reboot notifier then unload and error ?

> +			copy_to_user((void __user *)arg, &wdinfo, size);

This function returns an error and should be checked. (The tricks with
IOC bits and verify_area aren't enough to be sure it won't error and
actually probably aren't worth doing)

> +	printk(KERN_WARNING "%s: watchdog expired - resetting system\n",
> +	       wdt_gpi_name);
> +
> +	*(volatile char *) flagaddr |= 0x01;
> +	*(volatile char *) resetaddr = powercycle ? 0x01 : 0x2;
> +	iob();
> +	while (1) continue;

cpu_relax();
> +
> +	return IRQ_HANDLED;

Unreachable code.

Also if this is a software watchdog why is it better than using
softdog ?

Otherwise it looks pretty sound.
