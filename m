Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBE28C510599
	for linux-mips-outgoing; Thu, 13 Dec 2001 18:08:12 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBE28Ao10596
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 18:08:10 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBE186B05578;
	Thu, 13 Dec 2001 17:08:06 -0800
Subject: Re: No bzImage target for MIPS
From: Pete Popov <ppopov@mvista.com>
To: Krishna Kondaka <krishna@sanera.net>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <200112140047.fBE0l9n02204@icarus.sanera.net>
References: <200112140047.fBE0l9n02204@icarus.sanera.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Dec 2001 17:10:40 -0800
Message-Id: <1008292240.27799.134.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2001-12-13 at 16:47, Krishna Kondaka wrote:
> Hi,
> 
> 	There is no "bzImage" target in the mips linux Makefiles. Could
> 	you tell me why this is missing? If I want to generate a 
> 	compressed image for linux on MIPS, how do I do it?

Download the linux-mips drop-in tree from sourceforge.net. Take a look
at arch/mips/zboot.  The only zImage support in that directory is for
the Alchemy Pb1000 board.  That's one way to do it and I basically
copied it from the ppc tree. You'll have to do some work to add support
for whatever board you want, but the example should be sufficient, if
you're a developer. If you're a casual user, unfortunately you're out of
luck.

Pete
