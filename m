Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 16:44:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9932 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023254AbXFRPoj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 16:44:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5IFbJTZ015845;
	Mon, 18 Jun 2007 16:37:19 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5IFbIPc015844;
	Mon, 18 Jun 2007 16:37:18 +0100
Date:	Mon, 18 Jun 2007 16:37:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Message-ID: <20070618153718.GA13597@linux-mips.org>
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
X-archive-position: 15451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 18, 2007 at 04:22:39PM +0200, Franck Bui-Huu wrote:

> Since very few boards are using GEN_RTC:
> 
> 	$ git grep -l "GEN_RTC=y" arch/mips/configs/
> 	arch/mips/configs/bigsur_defconfig
> 	arch/mips/configs/yosemite_defconfig

Btw, you missed emma2rh_defconfig which builds GEN_RTC as a module.  Silly
because it doesn't initialize rtc_mips_get_time or rtc_mips_set_time so
hasn't possible a chance to work as anything but a dummy rtc.

  Ralf
