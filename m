Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 11:07:36 +0000 (GMT)
Received: from host188-210-dynamic.20-79-r.retail.telecomitalia.it ([79.20.210.188]:13988
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20026909AbXLKLH1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 11:07:27 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J22uK-0005wd-2h
	for linux-mips@linux-mips.org; Tue, 11 Dec 2007 12:04:14 +0100
Subject: Still no 2.6.24 on ip32 [was: Re: 2.6.24-rc1 does not boot on SGI]
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <475D7FE2.7080703@kanux.com>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
	 <1193599031.14874.1.camel@scarafaggio>
	 <20071029150625.GB4165@linux-mips.org>
	 <1194268551.4842.3.camel@scarafaggio>  <1194281699.4192.3.camel@casa>
	 <1197287929.17265.6.camel@scarafaggio>  <475D7FE2.7080703@kanux.com>
Content-Type: text/plain
Date:	Tue, 11 Dec 2007 12:04:55 +0100
Message-Id: <1197371095.7889.24.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno lun, 10/12/2007 alle 14.05 -0400, Ricardo Mendoza ha scritto:
[...]
> > Calling initcall 0xffffffff80497028: psmouse_init+0x0/0x90()
> > maceisa enable: 49
> > crime_int 00000020 enabled
> > *irq 13, crime_int=00002000, crime_mask=003003a0, mace_int=00000000*
> > irq 13, desc: ffffffff80448390, depth: 1, count: 0, unhandled: 0
> > ->handle_irq():  ffffffff80065eb0, handle_bad_irq+0x0/0x2c0
> > ->chip(): ffffffff8043e320, 0xffffffff8043e320
> > ->action(): 0000000000000000
> >   IRQ_DISABLED set
> 
> I recommend you pull latest git. Looks like some issue that Ralf and I
> fixed a few weeks ago.

I just checked that my repository is up to date, so my problem is still
there (thus I don't know if it is the same problem you fixed).

BTW, what was the problem you fixed? I would like to have a look to it,
to better understand what's going on there.

Thanks,
Giuseppe
