Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJI9LE08826
	for linux-mips-outgoing; Wed, 19 Dec 2001 10:09:21 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJI9Io08823
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 10:09:18 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fBJH9Dn4004039;
	Wed, 19 Dec 2001 09:09:13 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fBJH9C3w004035;
	Wed, 19 Dec 2001 09:09:12 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 19 Dec 2001 09:09:11 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Geoffrey Espin <espin@idiom.com>, linux-mips@oss.sgi.com
Subject: Re: kmalloc/pci_alloc and skbuff's
In-Reply-To: <3C205853.EE642541@niisi.msk.ru>
Message-ID: <Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> What's wrong with GFP_DMA ? Doesn't it solve exactly this problem ?

Personally I don't like the hack but you have to ask what he needs.
kmalloc grabs memory from the CPU cache. GFP_DMA insures that cache memory
is continues. I think Geoffrey needs to use a specific memory address in 
PCI space. Tho I like Geoffrey to try using GFP_DMA. The reason I don't
like the hack is that skbuff's is bus independent. Not all ethernet cards
are PCI based. Please try using GFP_DMA and let us know if it worked. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/
