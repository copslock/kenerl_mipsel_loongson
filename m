Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5D8jsnC025168
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 13 Jun 2002 01:45:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5D8jsOo025167
	for linux-mips-outgoing; Thu, 13 Jun 2002 01:45:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from castle.nmd.msu.ru (castle.nmd.msu.ru [193.232.112.53])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5D8jonC025153
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 01:45:51 -0700
Received: (qmail 23773 invoked by uid 577); 13 Jun 2002 08:57:53 -0000
Message-ID: <20020613125753.A23693@castle.nmd.msu.ru>
Date: Thu, 13 Jun 2002 12:57:53 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "David S. Miller" <davem@redhat.com>
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
   netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: NAPI for eepro100
References: <3D0740ED.2060907@ict.ac.cn> <3D07D270.5060902@mandrakesoft.com> <20020612.160532.134201977.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20020612.160532.134201977.davem@redhat.com>; from "David S. Miller" on Wed, Jun 12, 2002 at 04:05:32PM
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 12, 2002 at 04:05:32PM -0700, David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Wed, 12 Jun 2002 19:00:00 -0400
>    
>    for the 'mips' patch, it looks 
>    like the arch maintainer(s) need to fix the PCI DMA support...
> 
> No, it's worse than that.
> 
> See how non-consistent memory is used by the eepro100 driver
> for descriptor bits?  The skb->tail bits?
> 
> That is very problematic.

What's the problem?
If it isn't allowed to do, then what is the meaning of PCI_DMA_BIDIRECTIONAL
mappings?

	Andrey
