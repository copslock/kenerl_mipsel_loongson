Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KIxmEC005786
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 11:59:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KIxmG7005785
	for linux-mips-outgoing; Tue, 20 Aug 2002 11:59:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KIxfEC005769
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 11:59:41 -0700
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA14053;
	Tue, 20 Aug 2002 12:02:28 -0700
Subject: RE: Mips cross toolchain
From: Pete Popov <ppopov@mvista.com>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: Joe George <joeg@clearcore.net>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <NCBBKGDBOEEBDOELAFOFAEGKCPAA.lyle@zevion.com>
References: <NCBBKGDBOEEBDOELAFOFAEGKCPAA.lyle@zevion.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 20 Aug 2002 12:04:06 -0700
Message-Id: <1029870249.11781.88.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tue, 2002-08-20 at 11:47, Lyle Bainbridge wrote:
> 
> 
> -----Original Message-----
> From: Joe George [mailto:joeg@clearcore.net]
> Sent: Tuesday, August 20, 2002 11:29 AM
> To: Lyle Bainbridge
> Cc: linux-mips@oss.sgi.com
> Subject: Re: Mips cross toolchain
> 
> 
> >>I don't know of anyone using big endian with Alchemy at this point.
> >>There may be some and I'd like to hear from them.
> 
> 
> Firstly, thanks to everyone for the advice.
> 
> Ideally I'd use big endian.  Is there any reason the toolchain
> wouldn't support this.  

No.

> I'm only using the Au1500 on-chip peripherals
> with the addition of an external Highpoint HPT371 ATA controller.

Any of the PCI peripherals on the Pb1500 would require the 36 bit code
support.  I ... think I tested the PCI bus support using the 36 bit
patch and BE mode and it worked fine.  Looks like Joe is working on some
bug fixes though so the 36 bit code is not complete yet in oss.

Pete
