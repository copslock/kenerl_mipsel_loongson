Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 15:14:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40322 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493284AbZKDOO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 15:14:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA4EFnck018886;
	Wed, 4 Nov 2009 15:15:49 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA4EFjxM018884;
	Wed, 4 Nov 2009 15:15:45 +0100
Date:	Wed, 4 Nov 2009 15:15:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 5/6] [loongson] rtc: enable legacy RTC driver
	on fuloong2f
Message-ID: <20091104141545.GA18408@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com> <e13ed33a99dbf14f223360d414aa2b2c5caa9b1f.1257325319.git.wuzhangjin@gmail.com> <m3eioetvx5.fsf@anduin.mandriva.com> <1257333527.8716.20.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257333527.8716.20.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 07:18:47PM +0800, Wu Zhangjin wrote:

> In reality, fuloong2e, fuloong2f and yeeloong2f work fine with RTC_LIB,
> but relative patches need to append to drivers/rtc/rtc-cmos.c and also
> need a RTC platform device. If what I remembered is right, Gdium also
> need corresponding patches to make it work with RTC_LIB.
> 
> Herein, I just let the basic support for those machines work, and then,
> the RTC_LIB support will be sent out later.
> 
> and a small question: if legacy RTC driver works well on these machines,
> why should we forbid people to use it? I think it's better to remove the
> "select RTC_LIB" line for MIPS, and then, the people will be free to
> choose what they want, and even for the users whose platform not support
> RTC_LIB.

RTC_LIB is the way to go; the non-RTC_LIB drivers are there only for
backward compatbility.  A grep through the defcconfig files for all
platforms on all architectures finds that by now all have set
CONFIG_RTC_LIB and the remaining users of CONFIG_RTC, CONFIG_JS_RTC,
CONFIG_GEN_RTC, CONFIG_EFI_RTC, CONFIG_DS1302 (which all depend on !RTC_LIB)
are all defconfig files which seem to be slowly bitrotting.

Time to axe !RTC_LIB?  I'm tempted.

  Ralf
