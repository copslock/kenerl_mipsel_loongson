Received:  by oss.sgi.com id <S305171AbQDFVcH>;
	Thu, 6 Apr 2000 14:32:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60430 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbQDFVbx>; Thu, 6 Apr 2000 14:31:53 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA02664; Thu, 6 Apr 2000 14:35:40 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA09404
	for linux-list;
	Thu, 6 Apr 2000 14:19:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA09586
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Apr 2000 14:18:46 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01962
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Apr 2000 14:18:09 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 740537FC; Thu,  6 Apr 2000 23:18:06 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 583918FC3; Thu,  6 Apr 2000 23:05:05 +0200 (CEST)
Date:   Thu, 6 Apr 2000 23:05:05 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: cause of early indigo2 crash
Message-ID: <20000406230505.E13727@paradigm.rfc822.org>
References: <20000405223413.B996@paradigm.rfc822.org> <Pine.GSO.4.10.10004061050160.28032-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.GSO.4.10.10004061050160.28032-100000@dandelion.sonytel.be>; from Geert Uytterhoeven on Thu, Apr 06, 2000 at 10:51:17AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 06, 2000 at 10:51:17AM +0200, Geert Uytterhoeven wrote:
> What's here? Usually it tells the function where it crashes.
> 
> > Thats it - Might the first area be DMA bounce buffer only which have to
> > be initialized in the memory controller ?
> 
> I see these panics sometimes as well. Where does the crash happen? Please
> lookup in System.map.

Its in drivers/scsi/scsi_dma.c 

It happens due to no available scsi dma buffers which is caused by
the fact that MAX_DMA_ADDRESS is below the lowest free memory segment
(Kernel overlaps). If i increase the MAX_DMA_ADDRESS include/asm/dma.h.

As most of the drivers dont use the MAX_DMA_ADDRESS (zone allocator should
have made it obsolete) i suggest leaving it like it is and changing
arch/mips/mm/init.c to:

#if defined(CONFIG_ISA) || defined(CONFIG_PCI)
        if (low < max_dma)
                zones_size[ZONE_DMA] = low;
        else {
                zones_size[ZONE_DMA] = max_dma;
                zones_size[ZONE_NORMAL] = low - max_dma;
        }
#else
        zones_size[ZONE_DMA] = low;
#endif

as the dma.h comment says that this only applies to standard PC 
dma controllers.

If no one objects ill commit this.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
