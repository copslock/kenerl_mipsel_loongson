Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA924aw21108
	for linux-mips-outgoing; Thu, 8 Nov 2001 18:04:36 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA924X021104
	for <linux-mips@oss.sgi.com>; Thu, 8 Nov 2001 18:04:33 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA925vB28450;
	Thu, 8 Nov 2001 18:05:57 -0800
Message-ID: <3BEB39AA.5E715AD8@mvista.com>
Date: Thu, 08 Nov 2001 18:04:26 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: balaji.ramalingam@philips.com
CC: linux-mips@oss.sgi.com
Subject: Re: kernel bug in linux2.4.3
References: <OFAC4A18E3.D2E86AAC-ON88256AFD.00051578@diamond.philips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

balaji.ramalingam@philips.com wrote:
> 
> Hello,
> 
> I took the linux kernel 2.4.3 from ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/src/.
> This kernel was ported for MIPS32 ISA and its supposed to work with all the
> mips 4kc core. I took the kernel and ported for our Philips processor PR3950,
> which is based on a mips 4kc core.
> 
> I have some issues in the reserve_bootmem() & the paging_init() in the
> arch/mips/kernel/setup.c. Itseems that they fail in the alloc_bootmem ().
> I commented these functions and got till console_init() to get the print messages
> on my screen. I got the message as Kernel Bug in bootmem.c
> 

Does PR3950 have ll/sc instructions?  If not, make sure the config file
reflects that properly.  Otherwise alloc_bootmem() will hang for ever. 
Commenting them out certainly is not the solution. :-)

Jun
