Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DHQQk16712
	for linux-mips-outgoing; Wed, 13 Jun 2001 10:26:26 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DHQQP16709
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 10:26:26 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5DHPU032253;
	Wed, 13 Jun 2001 10:25:31 -0700
Message-ID: <3B27A139.8050107@pacbell.net>
Date: Wed, 13 Jun 2001 10:22:01 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i586; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matthew Dharm <mdharm@momenco.com>
CC: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: USB controllers?
References: <NEBBLJGMNKKEEMNLHGAICEODCBAA.mdharm@momenco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matthew Dharm wrote:

>Out of curiosity, is anyone here running their MIPS-based system with
>USB enabled?  It's not my day job, but something I deal with anyway,
>so I thought I'd ask and see if (a) anyone has tried it, and (b)
>anyone needs any help.
>

We have USB working on two (or three) mips boards -- the ITE8172 and the 
Alchemy PB1000. Both little endian though.  I think the USB on the NEC 
DDB boards might be working as well but I'm not sure.  One of our guys 
had to do quite a bit of work initially to get usb working on mips but 
the patches were accepted by the maintainter.

Pete
