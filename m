Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 20:50:41 +0100 (WEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60863 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023148AbZFETue (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2009 20:50:34 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n55JoN2V018444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Jun 2009 12:50:24 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n55JoNcL000614;
	Fri, 5 Jun 2009 12:50:23 -0700
Date:	Fri, 5 Jun 2009 12:50:23 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	matthieu castet <castet.matthieu@free.fr>
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, biblbroks@sezampro.rs
Subject: Re: add bcm47xx watchdog driver
Message-Id: <20090605125023.d968c58e.akpm@linux-foundation.org>
In-Reply-To: <4A282D98.6020004@free.fr>
References: <4A282D98.6020004@free.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 04 Jun 2009 22:24:56 +0200
matthieu castet <castet.matthieu@free.fr> wrote:

> This add watchdog driver for broadcom 47xx device.
> It uses the ssb subsytem to access embeded watchdog device.
> 
> ...
>
> --- linux-2.6.orig/drivers/watchdog/Kconfig	2009-05-25 22:22:02.000000000 +0200
> +++ linux-2.6/drivers/watchdog/Kconfig	2009-05-25 22:26:06.000000000 +0200
> @@ -764,6 +764,12 @@
>  	help
>  	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
>  
> +config BCM47XX_WDT
> +    tristate "Broadcom BCM47xx Watchdog Timer"
> +    depends on BCM47XX
> +    help
> +      Hardware driver for the Broadcom BCM47xx Watchog Timer.

Shouldn't there be some SSB dependencies in Kconfig here?
