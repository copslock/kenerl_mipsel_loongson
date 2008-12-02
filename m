Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2008 01:30:57 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:45788 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S24039940AbYLBBan (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Dec 2008 01:30:43 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mB21UTLD029062;
	Mon, 1 Dec 2008 17:30:29 -0800 (PST)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Dec 2008 17:30:29 -0800
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 2 Dec 2008 02:30:25 +0100
Message-ID: <49349011.4000602@windriver.com>
Date:	Tue, 02 Dec 2008 09:32:01 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Defconfigs and RTC
References: <20081201083307.GA2277@linux-mips.org> <4933A546.4020105@windriver.com> <20081201105124.GB2277@linux-mips.org>
In-Reply-To: <20081201105124.GB2277@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2008 01:30:25.0659 (UTC) FILETIME=[8D349CB0:01C9541D]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Dec 01, 2008 at 04:50:14PM +0800, tiejun.chen wrote:
> 
>> Ralf Baechle wrote:
>>> Quite a few of the defconfigs have not been updated for quite some time
>>> and are beginning to be a bit useless.  Also since we switched to RTC_LIB
>>> quite a few systems no longer read their RTCs on bootup so their
>>> defconfigs should be updated to enable RTC_CLASS and CONFIG_RTC_HCTOSYS.
>>> A hand full of systems is still using read_persistent_clock() to read
>>> the RTC on bootup.  The use of this function should preferably be replaced
>>> by RTC_CLASS and CONFIG_RTC_HCTOSYS.
>>>
>> Can we use RTC_CLASS option directly to replace RTC_LIB on the file,
>> arch/mips/Kconfig by default? If so all deconfigs may not be modified.
> 
> RTC_CLASS implies RTC_LIB.  It's not a replacement.
> 

I meas if we use directly RTC_CLASS on the file, arch/mips/Kconfig, as the
following:
==
config MIPS
        bool
        default y
        select HAVE_IDE
        select HAVE_OPROFILE
        select HAVE_ARCH_KGDB
        # Horrible source of confusion.  Die, die, die ...
        select EMBEDDED
        select RTC_LIB --> RTC_CLASS
===

If so RTC_Class and RTC_HCTOSYS options will be enabled for all platforms by
default as you expect. I think it will be given a hint for the developers that
they should develop their RTC towards supporting RTC_CLASS in the future, not
other choices. And it may be helpful to have an unified RTC mode quickly.

Thanks & Best Regards
Tiejun

>   Ralf
> 
