Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U2SLJ30528
	for linux-mips-outgoing; Mon, 29 Oct 2001 18:28:21 -0800
Received: from dea.linux-mips.net (a1as03-p77.stg.tli.de [195.252.186.77])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U2SG030524
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 18:28:17 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9U2SDA07769
	for linux-mips@oss.sgi.com; Tue, 30 Oct 2001 03:28:13 +0100
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U1kb029778
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 17:46:37 -0800
Received: from mvista.com (IDENT:ahennessy@penelope.mvista.com [10.0.0.122])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9U1mNB16946;
	Mon, 29 Oct 2001 17:48:24 -0800
Message-ID: <3BDE0673.20F5C29D@mvista.com>
Date: Mon, 29 Oct 2001 17:46:27 -0800
From: Alice Hennessy <ahennessy@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
   "carstenl@mips.com" <carstenl@mips.com>, ahennessy@mvista.com,
   ajob4me@21cn.com
Subject: Re: other info about Toshiba TX3927 board boot problem.
References: <200110290956.f9T9uc028676@oss.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

8route wrote:

> Dear Atsushi:
>   Hi!
>   I found the reset switch on the TX3927 board can work if you switch it
> against the PCI interface when
> ==================================
>   VFS: Mounted root (NFS filesystem).
>   Freeing unused kernel memory: 44k freed
> ========================================
> ,usually I switch it towards the PCI interface.
>
>   And I have fixed the source code of process.c as you said.
> >For TX3927, you must skip those two lines in exit_thread() and
> >flush_thread().
> >
> >               set_cp0_status(ST0_CU1, ST0_CU1);
> >               __asm__ __volatile__("cfc1\t$0,$31");
> >
> >
> But the problem still exists.The serial console output will stop at
> ==================================
>   VFS: Mounted root (NFS filesystem).
>   Freeing unused kernel memory: 44k freed
> ========================================
>
>   I think that maybe the Linux system has booted up OK,but there is
> something wrong with the serial console because serial ports are integrated
> with TX3927.Do you agree?Please consider it in your latest patch.
> >By the way, now I'm planning to send patches for TX CPU boards
> >(including JMR3927) to oss.sgi.com.  If you can wait a while, you can
> >try it.
> Thank you very much.
>
> 8route
> ajob4me@21cn.com
> 10/29/2001

I have already submitted a patch to Ralf for the JMR3927 and am waiting for
his reply.
We should coordinate to make sure we don't overwrite each other.

Alice
