Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jan 2005 10:04:33 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:46571
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224932AbVA2KER>; Sat, 29 Jan 2005 10:04:17 +0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CupSi-0000ju-00
	for linux-mips@linux-mips.org; Sat, 29 Jan 2005 11:04:16 +0100
Received: from [213.39.178.184] (helo=c178184.adsl.hansenet.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CupSi-0002t0-00
	for linux-mips@linux-mips.org; Sat, 29 Jan 2005 11:04:16 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
To:	linux-mips@linux-mips.org
Subject: Re: bitrot in drivers/net/au1000_eth.c
Date:	Sat, 29 Jan 2005 11:04:48 +0100
User-Agent: KMail/1.7.1
References: <200501281501.19162.eckhardt@satorlaser.com> <41FA6FF0.4060302@embeddedalley.com> <20050128102056.A9216@cox.net>
In-Reply-To: <20050128102056.A9216@cox.net>
Organization: Sator Laser GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291104.48853.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Friday 28 January 2005 18:20, Matt Porter wrote:
> I suggest everyone take a look at the effort posted to netdev:
>
> http://oss.sgi.com/archives/netdev/2004-12/msg00643.html
>
> It's an attempt at a phy abstraction layer that goes the next
> logical step after the minimal support provided in mii.h.

Ok, this is a major enhancement to the current ad-hoc MII handling and 
probably the way to go in the future. My main concern is if/when this patch 
will be applied to the kernel, but until then I'll probably stick with the 
current code, keeping it alive as good as possible.

Is anyone aware of the acceptance/state of that patch or have further info?

Uli
