Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAU9dhK32676
	for linux-mips-outgoing; Fri, 30 Nov 2001 01:39:43 -0800
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAU9deo32673
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 01:39:40 -0800
Received: from 63.70.210.4 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Fri, 30 Nov 2001 00:39:24 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from nt-sjcb-0501.sv.broadcom.com (mail.sv.broadcom.com
 [10.19.192.19]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id
 AAA19508; Fri, 30 Nov 2001 00:39:36 -0800 (PST)
Received: by mail.sv.broadcom.com with Internet Mail Service (
 5.5.2653.19) id <X4N1TBCV>; Fri, 30 Nov 2001 00:39:36 -0800
Message-ID: <E1EBEF4633DBD3118AD1009027E2FFA0025D0513@mail.sv.broadcom.com>
From: "Guillermo A. Loyola" <gmo@broadcom.com>
To: "'Pete Popov'" <ppopov@mvista.com>, linux-mips <linux-mips@oss.sgi.com>,
   sforge <linux-mips-kernel@lists.sourceforge.net>
Subject: RE: pcmcia
Date: Fri, 30 Nov 2001 00:39:35 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 10199A36172370-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> The pcmcia variable ioaddr_t should be a 32 bit type for my socket
> driver.  Is there any harm to other mips pcmcia socket drivers if we
> apply the patch below?

We need the same here, how about doing this instead:

#ifdef __i386__
typedef u_short   ioaddr_t;
#else
typedef u_int	ioaddr_t;
#endif

Gmo.
