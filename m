Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 06:22:08 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:60615 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224788AbVASGVz>;
	Wed, 19 Jan 2005 06:21:55 +0000
Received: MO(mo00)id j0J6Lq3g005567; Wed, 19 Jan 2005 15:21:52 +0900 (JST)
Received: MDO(mdo00) id j0J6LqS1021660; Wed, 19 Jan 2005 15:21:52 +0900 (JST)
Received: 4UMRO00 id j0J6Lpnn018581; Wed, 19 Jan 2005 15:21:51 +0900 (JST)
	from rally (localhost [127.0.0.1]) (authenticated)
Date: Wed, 19 Jan 2005 15:21:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-Id: <20050119152151.7b756560.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.61L.0501190533450.26851@blysk.ds.pg.gda.pl>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
	<20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
	<20050119143146.09982d63.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190533450.26851@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Wed, 19 Jan 2005 05:35:29 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Wed, 19 Jan 2005, Yoichi Yuasa wrote:
> 
> > >  Neither of these uses any CONFIG_* macros.
> > 
> > I'm making patch for giu.c and icu.c.
> > These patches need it. 
> 
>  Then please just include what you need within these patches.  That's the 
> usual way of doing stuff.

Ok, I'll send a patch including get back and add new line.

Thanks,

Yoichi
