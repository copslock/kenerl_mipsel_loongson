Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 16:21:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40613 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023252AbXFRPVt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 16:21:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5IFENq0005206;
	Mon, 18 Jun 2007 16:14:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5IFENBl005205;
	Mon, 18 Jun 2007 16:14:23 +0100
Date:	Mon, 18 Jun 2007 16:14:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Message-ID: <20070618151422.GA4864@linux-mips.org>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164024053-git-send-email-fbuihuu@gmail.com> <20070614.212913.82089068.nemoto@toshiba-tops.co.jp> <20070617000448.GA30807@linux-mips.org> <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 18, 2007 at 04:22:39PM +0200, Franck Bui-Huu wrote:

> were an interface for _generic_ rtc only. But all the following
> platforms don't seem to use the generic rtc though it initialises
> these function pointers... Any idea why ?

Because unless drivers/char/Kconfig is getting changed to prevent that is
is possible to enable CONFIG_GEN_RTC, so this code was necessary for
correctness.  Aside I think it did simply propagate through cutnpaste.
That at least was the reason in the 2.4 days when the old kernel
configuration language made it way to painful to deal with such
configurations.  These days I think we should rather get rid of genrtc.
Genrtc used to be nice candy but like most sweets long term it results in
caries ;-)

  Ralf
