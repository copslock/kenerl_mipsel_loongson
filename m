Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2003 00:50:47 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60922 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225202AbTGCXun>;
	Fri, 4 Jul 2003 00:50:43 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA00589
	for <linux-mips@linux-mips.org>; Thu, 3 Jul 2003 16:50:20 -0700
Message-ID: <3F04C13B.F1B92A1B@mvista.com>
Date: Thu, 03 Jul 2003 17:50:19 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: AU1500 BE USB problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

My db1500 usb works in LE mode.  In BE mode it does not.  Below is
the first problem I've seen (may not be the first/only problem).  
This is a 2.4.18 kernel.

This problem shows up in sohci_submit_urb(), but looks like it is caused
by FILL_CONTROL_URB().  Since FILL_CONTROL_URB() is depreciated I've
also tried its replacement usb_fill_control_urb() with no difference.

This is generic usb/ohci code.  Isn't this code already le/be safe?
Shouldn't this just work?

The au1500 hardware has a bit that will "swap usb data but not ohci
control structs".  I see this same problem with that bit set or clear.

Not sure if hcca->frame_no is considered an ohci control struct or
usb data, but since it doesn't seam to be swapped when I change the
bit, I'm guessing it is probably considered a control struct.

Any thoughts on what I might be missing here?


Here is the le/be diff:
< hcc[32]:0xa02bd080=0x00000a1d
---
> hcc[32]:0xa02bd080=0x00000a1c
...
< frame_no = (x1=0x0d57,x2=0x0d57,x3=0x0d57)
< frame_no = (y1=0x00000d57,y2=0x00000d57,y3=0x00000d57)
< ...URB:[ d92] dev: 0,ep: 0-O,type:CTRL,flags:   0,len:0/0,stat:0(0)
---
> frame_no = (x1=0x0000,x2=0x0000,x3=0x0000)
> frame_no = (y1=0x00000000,y2=0x00000000,y3=0x00000d56)
> #...URB:[   0] dev: 0,ep: 0-O,type:CTRL,flags:   0,len:0/0,stat:0(0)


The above output comes from this patch to sohci_get_current_frame_number():
< 
<       return le16_to_cpu (ohci->hcca->frame_no);
---
>       u16 x1, x2, x3;
>       u32 y1, y2, y3;
> 
>       {
>               u32 i, l;
>               u32* p;
>               l = sizeof(struct ohci_hcca)/4;
>               p = ohci->hcca;
>               for ( i = 0; i < l; i++ )
>               {
>                       printk( "hcc[%02d]:0x%08x=0x%08x\n", 
>                               i, p, *p );
>                       p++;
>               }
>       }
> 
>       x1 = ohci->hcca->frame_no;
>       x2 = le16_to_cpu(x1);
>       x3 = ((u16*)ohci->hcca)[64];
> 
>       y1 = ohci->hcca->frame_no;
>       y2 = le32_to_cpu(y1);
>       y3 = ((u32*)ohci->hcca)[32];
> 
> printk( "frame_no = (x1=0x%04x,x2=0x%04x,x3=0x%04x)\n",x1,x2,x3 );
> printk( "frame_no = (y1=0x%08x,y2=0x%08x,y3=0x%08x)\n",y1,y2,y3 );
> 
>       return le16_to_cpu(ohci->hcca->frame_no);
