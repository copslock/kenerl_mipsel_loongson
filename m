Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8RHUgP19975
	for linux-mips-outgoing; Thu, 27 Sep 2001 10:30:42 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8RHUeD19972
	for <linux-mips@oss.sgi.com>; Thu, 27 Sep 2001 10:30:40 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8RHX4B02579;
	Thu, 27 Sep 2001 10:33:04 -0700
Message-ID: <3BB36023.3BC145B6@mvista.com>
Date: Thu, 27 Sep 2001 10:21:39 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geoffrey Espin <espin@idiom.com>
CC: Marc Karasek <marc_karasek@ivivity.com>,
   "'Karsten Merker'" <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?
References: <25369470B6F0D41194820002B328BDD2195AA2@ATLOPS> <3BB20FA9.79D167BA@mvista.com> <20010926145623.A15305@idiom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geoffrey Espin wrote:
> 
> Jun,
> 
> BTW, your nec_candy.c driver didn't work for me (MII/PHY probs?)...
> my old 2.4.0 candy.c version works. 

The setup for the driver is changed.  Did you add the driver setup code?  Look
for arch/mips/korva/candy_setup.c.


> Also, put up for you
> consideration are small korva/{prom.c,setup.c} tweaks.
> 

Can you post them in patch format?  (use diff -u)

Jun
