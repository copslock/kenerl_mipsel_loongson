Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 13:45:51 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:49946 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133436AbWBTNpm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 13:45:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KDqcYZ017143;
	Mon, 20 Feb 2006 13:52:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KDqcw5017142;
	Mon, 20 Feb 2006 13:52:38 GMT
Date:	Mon, 20 Feb 2006 13:52:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <imr@rtschenk.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add topology_init
Message-ID: <20060220135238.GB10598@linux-mips.org>
References: <43F9C400.5080200@rtschenk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9C400.5080200@rtschenk.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 02:28:32PM +0100, Rojhalat Ibrahim wrote:

> A recent patch introduced cpu topology in sysfs.
> When you run a kernel with SMP and sysfs enabled,
> you now get an Oops on boot. The following patch
> fixes that by adding topology_init to
> arch/mips/kernel/smp.c. The code is copied from
> arch/s390/kernel/smp.c.
> 
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>

Thanks, applied.

Your mailer converts tabs to space (Or did you do cut and paste?), which
made git think your patch was corrupt and so I had to apply it manually ...

  Ralf
