Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GHfjZ03982
	for linux-mips-outgoing; Tue, 16 Oct 2001 10:41:45 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GHfhD03979
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 10:41:43 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9GHi2B25377;
	Tue, 16 Oct 2001 10:44:02 -0700
Message-ID: <3BCC714F.B04C6D2B@mvista.com>
Date: Tue, 16 Oct 2001 10:41:35 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Andersson <peter@dark-past.mine.nu>
CC: linux-mips@oss.sgi.com
Subject: Re: Linux 2.4 kernel with sound support
References: <5.1.0.14.0.20011016193856.00a518e0@192.168.1.5>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Peter Andersson wrote:
> 
> Does anyone know where i can find a mips linux 2.4 kernel with audio
> support? I am running an sgi indy with a R5000 processor, but kernels
> compiled for R4400 works great.
> 
> Thanks
> 
> Peter

AFAIK, the following boards/sound drivers work

it8172	ite8172.c
pb1000	au1000.c 
ddb5477	nec_vrc5477.c 

Jun
