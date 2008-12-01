Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2008 10:51:29 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:5253 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24021578AbYLAKv1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2008 10:51:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB1ApQDT005708;
	Mon, 1 Dec 2008 10:51:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB1ApOll005706;
	Mon, 1 Dec 2008 10:51:24 GMT
Date:	Mon, 1 Dec 2008 10:51:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"tiejun.chen" <tiejun.chen@windriver.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Defconfigs and RTC
Message-ID: <20081201105124.GB2277@linux-mips.org>
References: <20081201083307.GA2277@linux-mips.org> <4933A546.4020105@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4933A546.4020105@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 01, 2008 at 04:50:14PM +0800, tiejun.chen wrote:

> Ralf Baechle wrote:
> > Quite a few of the defconfigs have not been updated for quite some time
> > and are beginning to be a bit useless.  Also since we switched to RTC_LIB
> > quite a few systems no longer read their RTCs on bootup so their
> > defconfigs should be updated to enable RTC_CLASS and CONFIG_RTC_HCTOSYS.
> > A hand full of systems is still using read_persistent_clock() to read
> > the RTC on bootup.  The use of this function should preferably be replaced
> > by RTC_CLASS and CONFIG_RTC_HCTOSYS.
> > 
> 
> Can we use RTC_CLASS option directly to replace RTC_LIB on the file,
> arch/mips/Kconfig by default? If so all deconfigs may not be modified.

RTC_CLASS implies RTC_LIB.  It's not a replacement.

  Ralf
