Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 15:41:54 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:28143 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225234AbVHJOlf>; Wed, 10 Aug 2005 15:41:35 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 10 Aug 2005 10:35:29 -0400
Message-ID: <42FA1311.4060903@timesys.com>
Date:	Wed, 10 Aug 2005 10:45:37 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: 24K malta
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <42FA0B9E.4030900@timesys.com>
In-Reply-To: <42FA0B9E.4030900@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2005 14:35:29.0687 (UTC) FILETIME=[C18F6270:01C59DB8]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Current CVS fails to build the malta_defconfig with:


scripts/kconfig/mconf arch/mips/Kconfig
arch/mips/Kconfig:690: can't open file "arch/mips/tx4938/Kconfig"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2


Greg Weeks
