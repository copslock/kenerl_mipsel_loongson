Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OJEUw12716
	for linux-mips-outgoing; Thu, 24 Jan 2002 11:14:30 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OJEQP12695
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 11:14:26 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0OICfB00317;
	Thu, 24 Jan 2002 10:12:41 -0800
Message-ID: <3C504EF6.D41EB019@mvista.com>
Date: Thu, 24 Jan 2002 10:14:14 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm@momenco.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Does anyone know how HHL boots?
References: <20020124015042.B29933@momenco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matthew Dharm wrote:
> 
> I'm somewhat curious...
> 
> MontaVista has HHL support for several MIPS boards... including one that my
> company makes. 

I suppose you are referring to Ocelot.  It is supported in HHL2.0.

> We've never actually seen their HHL distribution for our
> board, tho...

Strange.  You should get one set of CD's.  I am not sure about the business
arrangment.  Please contact support@mvista.com.

> and we're wondering, how does it boot?

Kernel is booted through netboot.  Root fs is NFS.  It is documented in the
CD's.

Jun
