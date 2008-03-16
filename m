Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2008 15:49:40 +0000 (GMT)
Received: from smtp-out25.alice.it ([85.33.2.25]:4102 "EHLO
	smtp-out25.alice.it") by ftp.linux-mips.org with ESMTP
	id S28597321AbYCPPti (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Mar 2008 15:49:38 +0000
Received: from FBCMMO03.fbc.local ([192.168.68.197]) by smtp-out25.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Mar 2008 16:49:33 +0100
Received: from FBCMCL01B07.fbc.local ([192.168.171.45]) by FBCMMO03.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Mar 2008 16:49:33 +0100
Received: from raver.openwrt ([79.19.114.153]) by FBCMCL01B07.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Mar 2008 16:47:59 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date:	Sun, 16 Mar 2008 16:49:30 +0100
User-Agent: KMail/1.9.9
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803130131.54570.technoboy85@gmail.com> <20080313090109.GB6012@alpha.franken.de>
In-Reply-To: <20080313090109.GB6012@alpha.franken.de>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803161649.30531.technoboy85@gmail.com>
X-OriginalArrivalTime: 16 Mar 2008 15:48:00.0250 (UTC) FILETIME=[1CB75DA0:01C8877D]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Thursday 13 March 2008 10:01:09 Thomas Bogendoerfer ha scritto:
> On Thu, Mar 13, 2008 at 01:31:54AM +0100, Matteo Croce wrote:
> > Il Wednesday 12 March 2008 12:16:29 Alan Cox ha scritto:
> > > On Wed, 12 Mar 2008 02:30:06 +0100
> > > Matteo Croce <technoboy85@gmail.com> wrote:
> > > 
> > > > Ugly but we need it
> > > 
> > > Too ugly - NAK
> > > 
> > > However please send an explanation of the problem and lets find a nicer
> > > way to do it or bury it in arch code.
> > > 
> > > 
> > 
> > This is my problem:
> > 
> > ffi_cmdset_000: DDisabling erae-ssuspend-progrm ddue to code bokeenness.
> > cmdlinparrt partition arssing not avaiabll
> > RedBoo ppartition parsngg not availabl
> > NET: Rgiistered protocl  family 1
> > NET: Regsteered protocol ammily 10
> > IPv6 overIPPv4 tunnelingdriiver
> > NET: Regsteered protocolfammily 17
> > FS:: Mounted roo (ssquashfs filessttem) readonly.
> > Freeing nuused kernel meorry: 120k freed
> > 
> > I'll try to find a nicer way to fix it
> 
> don't use AFE mode and treat it like a normal 16550 (PORT_16550A). You
> could also try to use UPIO_MEM32. That's how my console driver
> (different OS) works for AR7 without the hack to wait for LSR_TEMP and 
> LSR_THRE.
> 
> Thomas.
> 

What do you mean by don't using AFE? Just removing UART_CAP_AFE from the .fcr field?
I've tried but it doesn't work.

I tried also UPIO_MEM32 instead of UPIO_MEM (with PORT_AR7) but it doesn't works
