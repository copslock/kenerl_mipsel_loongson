Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJA8Ec04636
	for linux-mips-outgoing; Wed, 19 Dec 2001 02:08:14 -0800
Received: from niisi.wave.ras.ru (niisi.wave.ras.ru [194.85.104.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJA85o04633
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 02:08:08 -0800
Received: (from uucp@localhost)
	by niisi.wave.ras.ru (8.9.1/8.9.1) with UUCP id QAA26965;
	Wed, 19 Dec 2001 16:00:31 +0300
Received: from niisi.msk.ru (t01.systud.msk.su [193.232.173.1]) by systud.msk.su (8.8.5/8.7.3) with ESMTP id MAA05541; Wed, 19 Dec 2001 12:09:44 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA03348; Wed, 19 Dec 2001 12:03:25 +0300 (MSK)
Message-ID: <3C205853.EE642541@niisi.msk.ru>
Date: Wed, 19 Dec 2001 12:05:23 +0300
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Geoffrey Espin <espin@idiom.com>
CC: linux-mips@oss.sgi.com
Subject: Re: kmalloc/pci_alloc and skbuff's
References: <20011218123848.A75986@idiom.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geoffrey Espin wrote:
> 
> The Markham board (Korva/VR41xx variant) which I'm trying to get
> submitted, has a PCI problem.  It doesn't allow a PCI device to
> see all the DRAM.  DMA-able data must be in a special 4MB range,
> which is currently set at 0x01c00000 (the last 4MB of a 32MB
> system). SKB's must be allocated within this area for a
> (say, Ethernet) PCI device to access. There appears to be no way
> to tell kmalloc(), used in alloc_skb(), to allocate memory from
> any special address range.
> 

What's wrong with GFP_DMA ? Doesn't it solve exactly this problem ?

Regards,
Gleb.
