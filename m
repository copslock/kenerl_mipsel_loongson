Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 13:05:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19592 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133825AbWCTNFN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2006 13:05:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2KDEr7O010828;
	Mon, 20 Mar 2006 13:14:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2KDEq22010827;
	Mon, 20 Mar 2006 13:14:52 GMT
Date:	Mon, 20 Mar 2006 13:14:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vadivelan@soc-soft.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel
Message-ID: <20060320131452.GA4491@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C01525385@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C01525385@soc-mail.soc-soft.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 20, 2006 at 06:05:51PM +0530, Vadivelan@soc-soft.com wrote:

> Hi Ralf,
> 	I've attached the kernel dmesg below for ur reference.
> 
> ----------------------------------------------------------------
> 
> YAMON> go
> Linux version 2.6.10_mvl401-bcm91250-mips64_fp_be (root@ramkumar) (gcc
> version 3
> .4.3 (MontaVista 3.4.3-25.0.70.0501961 2005-12-18)) #127 Mon Mar 20
> 18:00:26 IST
>  2006
> CPU revision is: 00002d30
> FPU revision is: 00002d30

This kernel is already 15 months old and there have been a vast number of
bug fixes since.  And god knows what Montavista changed in their kernel -
I don't have the faintest idea.  In short, try a modern kernel.  Btw,
Linux 2.6.16 was released today and chances are it'll solve alot of your
issues.

  Ralf
