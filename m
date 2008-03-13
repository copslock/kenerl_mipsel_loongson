Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 00:32:04 +0000 (GMT)
Received: from smtp-out25.alice.it ([85.33.2.25]:43535 "EHLO
	smtp-out25.alice.it") by ftp.linux-mips.org with ESMTP
	id S28583128AbYCMAcC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Mar 2008 00:32:02 +0000
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out25.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 01:31:56 +0100
Received: from FBCMCL01B07.fbc.local ([192.168.171.45]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 01:31:56 +0100
Received: from raver.openwrt ([79.26.114.120]) by FBCMCL01B07.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 01:30:27 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date:	Thu, 13 Mar 2008 01:31:54 +0100
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com> <20080312111629.0fa15d9c@the-village.bc.nu>
In-Reply-To: <20080312111629.0fa15d9c@the-village.bc.nu>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803130131.54570.technoboy85@gmail.com>
X-OriginalArrivalTime: 13 Mar 2008 00:30:27.0500 (UTC) FILETIME=[6F7B1EC0:01C884A1]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Wednesday 12 March 2008 12:16:29 Alan Cox ha scritto:
> On Wed, 12 Mar 2008 02:30:06 +0100
> Matteo Croce <technoboy85@gmail.com> wrote:
> 
> > Ugly but we need it
> 
> Too ugly - NAK
> 
> However please send an explanation of the problem and lets find a nicer
> way to do it or bury it in arch code.
> 
> 

This is my problem:

ffi_cmdset_000: DDisabling erae-ssuspend-progrm ddue to code bokeenness.
cmdlinparrt partition arssing not avaiabll
RedBoo ppartition parsngg not availabl
NET: Rgiistered protocl  family 1
NET: Regsteered protocol ammily 10
IPv6 overIPPv4 tunnelingdriiver
NET: Regsteered protocolfammily 17
FS:: Mounted roo (ssquashfs filessttem) readonly.
Freeing nuused kernel meorry: 120k freed

I'll try to find a nicer way to fix it
