Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 11:40:32 +0100 (CET)
Received: from mx1.moondrake.net ([212.85.150.166]:56408 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493064AbZKDKk0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 11:40:26 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 6112C274003; Wed,  4 Nov 2009 11:40:25 +0100 (CET)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 5A2C1274002;
	Wed,  4 Nov 2009 11:40:24 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id AF40382919;
	Wed,  4 Nov 2009 11:51:51 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 744A0FF855;
	Wed,  4 Nov 2009 11:40:38 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 5/6] [loongson] rtc: enable legacy RTC driver on fuloong2f
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	<e13ed33a99dbf14f223360d414aa2b2c5caa9b1f.1257325319.git.wuzhangjin@gmail.com>
Organization: Mandriva
Date:	Wed, 04 Nov 2009 11:40:38 +0100
In-Reply-To: <e13ed33a99dbf14f223360d414aa2b2c5caa9b1f.1257325319.git.wuzhangjin@gmail.com> (Wu Zhangjin's message of "Wed,  4 Nov 2009 17:06:07 +0800")
Message-ID: <m3eioetvx5.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> writes:

Hi,

> RTC_LIB is selected by MIPS by default, and therefore, the legacy RTC driver is
> disabled. but fortunately, RTC_LIB not works on fulong, so, enabling the legcy
> RTC driver is needed, otherwise, the tools like hwclock will not work.
>
> because loongson family machines, including fuloong2e, fuloong2f and
> yeeloong2f need to enable legacy RTC driver, so we use MACH_LOONGSON
> here.

There are loongson machines which are working fine with RTC_LIB (for
instance the gdium which is using a m41t83 on i2c) so would be better to
be more restrictive imho.

Arnaud
