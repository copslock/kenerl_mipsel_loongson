Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 16:54:07 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:64717 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038440AbXBFQyC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 16:54:02 +0000
Received: (qmail 16814 invoked by uid 101); 6 Feb 2007 16:52:50 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 6 Feb 2007 16:52:50 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l16GqW5v024492;
	Tue, 6 Feb 2007 08:52:41 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7QLJC>; Tue, 6 Feb 2007 08:52:32 -0800
Message-ID: <45C8B24B.1000204@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Alan <alan@lxorguk.ukuu.org.uk>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date:	Tue, 6 Feb 2007 08:52:27 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 06 Feb 2007 16:52:28.0427 (UTC) FILETIME=[2F7155B0:01C74A0F]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Thank Alan. I made the changes yesterday but I'll wait another day
before reposting, in case other interested people have more comments.

Marc

Alan wrote:
>  >       unsigned char           hub6;                   /* this should 
> be in the 8250 driver */
>  >       unsigned char           unused[3];
>  > +     void                            *data;                  /* 
> generic platform data pointer */
>  >   };
> 
> Convention is "private_data"
> 
>  >
>  >   /*
>  > diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
>  > index 3c8a6aa..b3550cc 100644
>  > --- a/include/linux/serial_reg.h
>  > +++ b/include/linux/serial_reg.h
>  > @@ -37,6 +37,7 @@ #define UART_IIR_MSI                0x00 /* Modem stat
>  >   #define UART_IIR_THRI               0x02 /* Transmitter holding 
> register empty */
>  >   #define UART_IIR_RDI                0x04 /* Receiver data interrupt */
>  >   #define UART_IIR_RLSI               0x06 /* Receiver line status 
> interrupt */
>  > +#define UART_IIR_BUSY                0x07 /* DesignWare APB Busy 
> Detect */
> 
> Please move this down a line to break it from "official" values and call
> it DESIGNWARE_UART_IIR_BUSY, so it is obviously designware specific.
> 
> Otherwise looks much less invasive and messy
> 
