Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5CNZhnC018210
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 12 Jun 2002 16:35:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5CNZhG3018209
	for linux-mips-outgoing; Wed, 12 Jun 2002 16:35:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pizda.ninka.net (IDENT:root@pizda.ninka.net [216.101.162.242])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5CNZdnC018197;
	Wed, 12 Jun 2002 16:35:39 -0700
Received: from localhost (IDENT:davem@localhost.localdomain [127.0.0.1])
	by pizda.ninka.net (8.9.3/8.9.3) with ESMTP id QAA00328;
	Wed, 12 Jun 2002 16:33:44 -0700
Date: Wed, 12 Jun 2002 16:33:44 -0700 (PDT)
Message-Id: <20020612.163344.31410429.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, saw@saw.sw.com.sg,
   linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: NAPI for eepro100
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D07D6A6.7090308@mandrakesoft.com>
References: <3D07D270.5060902@mandrakesoft.com>
	<20020612.160532.134201977.davem@redhat.com>
	<3D07D6A6.7090308@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 12 Jun 2002 19:17:58 -0400

   Oh crap, you're right...   eepro100 in general does funky stuff with the 
   way packets are handled, mainly due to the need to issue commands to the 
   NIC engine instead of the normal per-descriptor owner bit way of doing 
   things.

The question is, do the descriptor bits have to live right before
the RX packet data buffer or can other schemes be used?
