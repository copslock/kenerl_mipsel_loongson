Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B8hcRw016748
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 01:43:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B8hc8n016747
	for linux-mips-outgoing; Thu, 11 Jul 2002 01:43:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B8hSRw016737;
	Thu, 11 Jul 2002 01:43:29 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id MAA03223;
	Thu, 11 Jul 2002 12:47:49 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id MAA24622; Thu, 11 Jul 2002 12:47:04 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA13258; Thu, 11 Jul 2002 12:44:23 +0400 (MSK)
Message-ID: <3D2D465C.FA06D50A@niisi.msk.ru>
Date: Thu, 11 Jul 2002 12:48:28 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Jon Burgess <Jon_Burgess@eur.3com.com>, linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com> <20020711021554.A3207@dea.linux-mips.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, Jul 10, 2002 at 03:16:21PM +0100, Jon Burgess wrote:
> 
> > This may be caused by the cache routines running from the a cached kseg0, it
> > looks like it can be fixed by making sure that the are always called via
> > KSEG1ADDR(fn) which looks like it could be done with a bit of fiddling of the
> > setup_cache_funcs code. I have included a patch below which starts this, but I
> > haven't caught all combinations of how the routines are called.
> 
> While that could be done it's not a good idea; running code in KSEG1 is
> very slow.
> 

Unfortunately, it's required by manuals for some processors. As I know,
IDT HW manuals clearly state cache flush routines must operate from
uncached code and must access uncached data only. Examples are R30x1 CPU
series.

Regards,
Gleb.
