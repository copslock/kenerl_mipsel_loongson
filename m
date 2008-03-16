Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2008 15:45:27 +0000 (GMT)
Received: from smtp-out114.alice.it ([85.37.17.114]:19213 "EHLO
	smtp-out114.alice.it") by ftp.linux-mips.org with ESMTP
	id S28597274AbYCPPpZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Mar 2008 15:45:25 +0000
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out114.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Mar 2008 16:45:10 +0100
Received: from FBCMCL01B02.fbc.local ([192.168.69.83]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Mar 2008 16:45:10 +0100
Received: from raver.openwrt ([79.19.114.153]) by FBCMCL01B02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Mar 2008 16:45:09 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date:	Sun, 16 Mar 2008 16:45:06 +0100
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de>
In-Reply-To: <20080315104009.GA6533@alpha.franken.de>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803161645.06364.technoboy85@gmail.com>
X-OriginalArrivalTime: 16 Mar 2008 15:45:10.0189 (UTC) FILETIME=[B75A1DD0:01C8877C]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Saturday 15 March 2008 11:40:09 Thomas Bogendoerfer ha scritto:
> On Fri, Mar 14, 2008 at 04:46:09PM +0100, Matteo Croce wrote:
> > This is a bit better
> 
> is it possible to try without the serial changes first ?
> 
> Use 
> 
>        uart_port[0].type = PORT_16550A;
> 
> in arch/mips/ar7/platform.c.
> 
> Does it work ?
> 
> Thomas.
> 

Tried I get teh usual broken serial output:

IP6 oover IPv4 tuneliing driver
NET: eggistered protooll family 17
VFS: Monteed root (squahfss filesystem)reaadonly.
