Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MK0uc28460
	for linux-mips-outgoing; Tue, 22 Jan 2002 12:00:56 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MK0pP28457
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 12:00:52 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0MIxEB30419;
	Tue, 22 Jan 2002 10:59:14 -0800
Message-ID: <3C4DB6DA.7F3E7386@mvista.com>
Date: Tue, 22 Jan 2002 11:00:42 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerald Champagne <gerald.champagne@esstech.com>
CC: linux-mips@oss.sgi.com
Subject: Re: ide dma in latest cvs
References: <3C4CA8C8.5010801@esstech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gerald Champagne wrote:
> 
> Does the latest CVS version work with an IDE controller in DMA mode?
> 
> I have an NEC VR5432 based system working with the IDE controller, but it
> crashes when used in dma mode.  I've tracked it down to the following code
> called from ide_build_sglist():
> 
> - blk_rq_map_sg() is called to build a list of blocks to be transferred.
>    It sets address = NULL for every entry (other fields like "page" are
>    set to valid values).
> 
> - dma_cache_wback_inv(addr, size) is called for each block entry.  This
>    routine crashes because the address parameter is always set to zero
>    when the routine is called.
> 

Did you check what the address is and why it is zero?  It seems to me this
might be key ...

Jun
