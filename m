Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 14:48:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8613 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031202AbYBLOsS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Feb 2008 14:48:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1CEmFXd001432;
	Tue, 12 Feb 2008 14:48:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1CEmERv001431;
	Tue, 12 Feb 2008 14:48:14 GMT
Date:	Tue, 12 Feb 2008 14:48:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"M. Warner Losh" <imp@bsdimp.com>
Cc:	macro@linux-mips.org, florian.fainelli@telecomint.eu,
	linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
Message-ID: <20080212144814.GB499@linux-mips.org>
References: <200802071932.23965.florian.fainelli@telecomint.eu> <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl> <20080210.154401.1655407815.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080210.154401.1655407815.imp@bsdimp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 10, 2008 at 03:44:01PM -0700, M. Warner Losh wrote:

> The Acer Pica machines, as well as the Deskstation Tynes, had devices
> mapped outside of this range...  Of course Ralf will be able to say
> more, if he chooses to jump into the way-back machine...

Yes, I recall.  Unfortunately I don't have my PICA anymore; it's been a
hell of a machine by the standards of its days.  Anyway, designs which
just like the PICA need some ioremap - and preferably available early
during bootup - have been developed after the PICA and are still being
developped.

  Ralf
