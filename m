Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2008 08:48:55 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:18394 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S24020990AbYLAIsv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2008 08:48:51 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mB18mhwX016599;
	Mon, 1 Dec 2008 00:48:43 -0800 (PST)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Dec 2008 00:48:43 -0800
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Dec 2008 09:48:40 +0100
Message-ID: <4933A546.4020105@windriver.com>
Date:	Mon, 01 Dec 2008 16:50:14 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Defconfigs and RTC
References: <20081201083307.GA2277@linux-mips.org>
In-Reply-To: <20081201083307.GA2277@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2008 08:48:40.0877 (UTC) FILETIME=[9BF6B5D0:01C95391]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Quite a few of the defconfigs have not been updated for quite some time
> and are beginning to be a bit useless.  Also since we switched to RTC_LIB
> quite a few systems no longer read their RTCs on bootup so their
> defconfigs should be updated to enable RTC_CLASS and CONFIG_RTC_HCTOSYS.
> A hand full of systems is still using read_persistent_clock() to read
> the RTC on bootup.  The use of this function should preferably be replaced
> by RTC_CLASS and CONFIG_RTC_HCTOSYS.
> 

Can we use RTC_CLASS option directly to replace RTC_LIB on the file,
arch/mips/Kconfig by default? If so all deconfigs may not be modified.

Best Regards
Tiejun

>   Ralf
> 
> 
