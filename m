Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 21:28:24 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:56523 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22156535AbYJVU2W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2008 21:28:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9MKSDi3017978;
	Wed, 22 Oct 2008 21:28:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9MKSDw9017976;
	Wed, 22 Oct 2008 21:28:13 +0100
Date:	Wed, 22 Oct 2008 21:28:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] defined a macro for lemote 2e box IO base
Message-ID: <20081022202812.GB10625@linux-mips.org>
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 23, 2008 at 12:48:58AM +0000, Zhang Le wrote:

> +#ifdef CONFIG_64BIT
> +#define LEMOTE_IO_PORT_BASE 0xffffffffbfd00000
> +#else
> +#define LEMOTE_IO_PORT_BASE 0xbfd00000
> +#endif

This sort of #ifdefery is one of the reasons why it's better to define
physical addresses of devices, not virtual addresses in header files.

  Ralf
