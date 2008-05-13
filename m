Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 00:31:30 +0100 (BST)
Received: from smtp-out113.alice.it ([85.37.17.113]:41742 "EHLO
	smtp-out113.alice.it") by ftp.linux-mips.org with ESMTP
	id S20030389AbYEMXb1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 00:31:27 +0100
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out113.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 14 May 2008 01:31:19 +0200
Received: from FBCMCL01B07.fbc.local ([192.168.171.45]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 14 May 2008 01:31:19 +0200
Received: from raver.lan ([82.55.114.254]) by FBCMCL01B07.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 14 May 2008 01:29:51 +0200
From:	Matteo Croce <matteo@openwrt.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH]: cpmac bugfixes and enhancements
Date:	Wed, 14 May 2008 01:31:16 +0200
User-Agent: KMail/1.9.9
Cc:	jgarzik@pobox.com, ralf@linux-mips.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
References: <200805041904.22726.matteo@openwrt.org> <200805140058.32890.matteo@openwrt.org> <20080513160642.a96dccbf.akpm@linux-foundation.org>
In-Reply-To: <20080513160642.a96dccbf.akpm@linux-foundation.org>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805140131.16473.matteo@openwrt.org>
X-OriginalArrivalTime: 13 May 2008 23:29:52.0656 (UTC) FILETIME=[3E8E7100:01C8B551]
Return-Path: <matteo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matteo@openwrt.org
Precedence: bulk
X-list: linux-mips

Il Wednesday 14 May 2008 01:06:42 Andrew Morton ha scritto:
> On Wed, 14 May 2008 00:58:32 +0200 Matteo Croce <matteo@openwrt.org> wrote:
> 
> > This one is cleaner:
> > 
> > 
> > Signed-off-by: Matteo Croce <matteo@openwrt.org>
> > Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> 
> It has no changelog.  We can neither effectively review it nor commit
> it without one.
> 
> Each bugfix and each enhancement should be described, please.
> 

Here's the changelog:

* Resolve some locking issues using atomic_inc/atomic_dec
* move status code in cpmac_check_status
* unmark the BROKEN flag in Kconfig
* move code which should have been in platform code in arch/mips/ar7/platform.c
* fixed an IRQ storm which lets the kernel hang
* fixed a double call to netif_start_queue which causes a kernel panic
* don't fail to register the PHY, works on many devices now
