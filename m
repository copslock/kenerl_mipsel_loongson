Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAUIZ1P26572
	for linux-mips-outgoing; Fri, 30 Nov 2001 10:35:01 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAUIYxo26569
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 10:34:59 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fAUHZWB01545;
	Fri, 30 Nov 2001 09:35:32 -0800
Subject: RE: pcmcia
From: Pete Popov <ppopov@mvista.com>
To: "Guillermo A. Loyola" <gmo@broadcom.com>
Cc: linux-mips <linux-mips@oss.sgi.com>,
   sforge
	 <linux-mips-kernel@lists.sourceforge.net>
In-Reply-To: <E1EBEF4633DBD3118AD1009027E2FFA0025D0513@mail.sv.broadcom.com>
References: <E1EBEF4633DBD3118AD1009027E2FFA0025D0513@mail.sv.broadcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 30 Nov 2001 09:35:01 -0800
Message-Id: <1007141701.22949.140.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-11-30 at 00:39, Guillermo A. Loyola wrote:
> > The pcmcia variable ioaddr_t should be a 32 bit type for my socket
> > driver.  Is there any harm to other mips pcmcia socket drivers if we
> > apply the patch below?
> 
> We need the same here, how about doing this instead:
> 
> #ifdef __i386__
> typedef u_short   ioaddr_t;
> #else
> typedef u_int	ioaddr_t;
> #endif

That probably makes more sense.  I wasn't sure if it's only x86 that
needs? ioaddr_t to be a 16 bit type.  

Pete
