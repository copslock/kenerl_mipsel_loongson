Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 09:29:55 +0000 (GMT)
Received: from [62.38.112.228] ([62.38.112.228]:3983 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133716AbWCJJ3q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2006 09:29:46 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id D563D32C25;
	Fri, 10 Mar 2006 11:38:17 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: [PATCH] IDT Interprise Processor Support for Linux  2.6.x
Date:	Fri, 10 Mar 2006 11:37:58 +0200
User-Agent: KMail/1.9
Cc:	linux-mips@linux-mips.org
References: <73943A6B3BEAA1468EE1A4A090129F4316B15A73@corpbridge.corp.idt.com> <20060310051510.GB16755@curie-int.vc.shawcable.net>
In-Reply-To: <20060310051510.GB16755@curie-int.vc.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101137.58865.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Friday 10 March 2006 7:15 am, Robin H. Johnson wrote:
> I'm not Ralf, but I gave your patch a quick once-over anyway for the
> hell of it.
>
> I see a lot of duplicated code, esp in arch/mips/idt-boards and the
> network drivers.
>
> Is it possible to have a kernel capable of booting on all IDT boards?
> Could such a kernel detect what board it's actually running on - or
> enough elements of the board configuration to provide more generic
> drivers?

Without going into details of the code or the hardware, I would advise against 
that. linux/arch follows that principle: separate the platform-specific code.
Even if the code is similar, it is better to separate it. Especially for such 
processors (like IDT's), which suggest that the system is embedded. We don't 
want an all-capable kernel, but the smallest one that can cover the hardware.
