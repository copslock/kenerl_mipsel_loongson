Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 15:48:41 +0000 (GMT)
Received: from p508B6E6D.dip.t-dialin.net ([IPv6:::ffff:80.139.110.109]:22661
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225980AbTACPsk>; Fri, 3 Jan 2003 15:48:40 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h03FmWx11578;
	Fri, 3 Jan 2003 16:48:32 +0100
Date: Fri, 3 Jan 2003 16:48:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Juan Quintela <quintela@mandrakesoft.com>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix possible buffer overflow problem in promlib
Message-ID: <20030103164832.A11536@linux-mips.org>
References: <m2hecrbb3p.fsf@demo.mitica> <Pine.GSO.4.21.0301022047090.4873-100000@vervain.sonytel.be> <20030103135422.A7796@linux-mips.org> <20030103142956.GI31256@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030103142956.GI31256@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Jan 03, 2003 at 03:29:56PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 03, 2003 at 03:29:56PM +0100, Thiemo Seufer wrote:

> > > What about making ppbuf static, to reduce stack usage?
> > 
> > By the time when prom_printf() is called stack overflow is not really a
> > consideration anymore, something fatal has happened before.
> 
> I don't think printing e.g. "LINUX started..." indicates something fatal. :-)

So use printk :-)

  Ralf
