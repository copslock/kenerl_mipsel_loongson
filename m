Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5D8n4nC025387
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 13 Jun 2002 01:49:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5D8n4XA025386
	for linux-mips-outgoing; Thu, 13 Jun 2002 01:49:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pizda.ninka.net (IDENT:root@pizda.ninka.net [216.101.162.242])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5D8mvnC025363;
	Thu, 13 Jun 2002 01:48:57 -0700
Received: from localhost (IDENT:davem@localhost.localdomain [127.0.0.1])
	by pizda.ninka.net (8.9.3/8.9.3) with ESMTP id BAA03164;
	Thu, 13 Jun 2002 01:47:00 -0700
Date: Thu, 13 Jun 2002 01:47:00 -0700 (PDT)
Message-Id: <20020613.014700.26430433.davem@redhat.com>
To: saw@saw.sw.com.sg
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
   netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: NAPI for eepro100
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020613125753.A23693@castle.nmd.msu.ru>
References: <3D07D270.5060902@mandrakesoft.com>
	<20020612.160532.134201977.davem@redhat.com>
	<20020613125753.A23693@castle.nmd.msu.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

   From: Andrey Savochkin <saw@saw.sw.com.sg>
   Date: Thu, 13 Jun 2002 12:57:53 +0400

   On Wed, Jun 12, 2002 at 04:05:32PM -0700, David S. Miller wrote:
   > No, it's worse than that.
   > 
   > See how non-consistent memory is used by the eepro100 driver
   > for descriptor bits?  The skb->tail bits?
   > 
   > That is very problematic.
   
   What's the problem?
   If it isn't allowed to do, then what is the meaning of PCI_DMA_BIDIRECTIONAL
   mappings?

It's slow.  Not wrong, just inefficient.

Descriptors were meant to be done using consistent mappings, not
"pci_map_*()"'d memory.  The latter is meant to be used for long
linear DMA transfers to/from the device.  It is not meant for things
the cpu pokes small bits of data in and out of, that is what
consistent DMA memory is for.
