Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5CNIrnC017957
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 12 Jun 2002 16:18:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5CNIrTM017956
	for linux-mips-outgoing; Wed, 12 Jun 2002 16:18:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5CNImnC017953;
	Wed, 12 Jun 2002 16:18:49 -0700
Received: from adsl-17-114-120.asm.bellsouth.net ([68.17.114.120] helo=mandrakesoft.com)
	by www.linux.org.uk with esmtp (Exim 3.33 #5)
	id 17IHQT-0004V8-00; Thu, 13 Jun 2002 00:21:17 +0100
Message-ID: <3D07D6A6.7090308@mandrakesoft.com>
Date: Wed, 12 Jun 2002 19:17:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, saw@saw.sw.com.sg,
   linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: NAPI for eepro100
References: <3D0740ED.2060907@ict.ac.cn>	<3D07D270.5060902@mandrakesoft.com> <20020612.160532.134201977.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

David S. Miller wrote:
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


Oh crap, you're right...   eepro100 in general does funky stuff with the 
way packets are handled, mainly due to the need to issue commands to the 
NIC engine instead of the normal per-descriptor owner bit way of doing 
things.

Well, I accept patches to that clean eepro100 up...   I'm not terribly 
motivated to clean it up myself, as we have e100 and an e100 maintainer 
we can beat on if such uglies arise :)

	Jeff
