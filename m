Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VMuVe23260
	for linux-mips-outgoing; Wed, 31 Oct 2001 14:56:31 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VMuU023257
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 14:56:30 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9VMwBB10287;
	Wed, 31 Oct 2001 14:58:11 -0800
Message-ID: <3BE08194.35FBCB82@mvista.com>
Date: Wed, 31 Oct 2001 14:56:20 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Scott A McConnell <samcconn@cotw.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Kernel panic: Caught reserved exception - should not happen.
References: <3BE07787.5FF7DB8A@cotw.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Scott A McConnell wrote:
> 
> I have been getting a fair amount of the above type of errors when
> compiling on a mipsel box.
> 
> 2.4.5 kernel on a NEC VR5432 box. Anyone aware of known problems?
> 

What is the exception vector?  Is it the "watch exception"? 

Jun
