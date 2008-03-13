Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 00:39:05 +0000 (GMT)
Received: from smtp-out25.alice.it ([85.33.2.25]:46085 "EHLO
	smtp-out25.alice.it") by ftp.linux-mips.org with ESMTP
	id S28583201AbYCMAjC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Mar 2008 00:39:02 +0000
Received: from FBCMMO02.fbc.local ([192.168.68.196]) by smtp-out25.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 01:38:57 +0100
Received: from FBCMCL01B06.fbc.local ([192.168.69.87]) by FBCMMO02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 01:38:57 +0100
Received: from raver.openwrt ([79.26.114.120]) by FBCMCL01B06.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 01:38:55 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date:	Thu, 13 Mar 2008 01:38:55 +0100
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com> <20080312093145.GA6270@alpha.franken.de>
In-Reply-To: <20080312093145.GA6270@alpha.franken.de>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803130138.55582.technoboy85@gmail.com>
X-OriginalArrivalTime: 13 Mar 2008 00:38:56.0013 (UTC) FILETIME=[9E940BD0:01C884A2]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Wednesday 12 March 2008 10:31:46 Thomas Bogendoerfer ha scritto:
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 289942f..869b6df 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -40,6 +40,7 @@
> >  #define PORT_NS16550A	14
> >  #define PORT_XSCALE	15
> >  #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> > +#define PORT_AR7	16
> 
> this doesn't look correct.
> 
> Thomas.
> 

Isn't it 16?
