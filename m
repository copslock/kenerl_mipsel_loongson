Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 19:36:44 +0100 (BST)
Received: from mail.timesys.com ([65.117.135.102]:26571 "EHLO
	exchange.timesys.com") by ftp.linux-mips.org with ESMTP
	id S8133554AbVJFSg2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 19:36:28 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 6 Oct 2005 14:33:52 -0400
Message-ID: <43456EA9.8020209@timesys.com>
Date:	Thu, 06 Oct 2005 14:36:25 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"Cooper, John" <john.cooper@timesys.com>
Subject: PREEMPT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 18:33:52.0500 (UTC) FILETIME=[803F3340:01C5CAA4]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Does anyone know of any current problems with CONFIG_PREEMPT on a 4kc 
malta board? We're seeing some oddness in the floating point emulator 
with PREEMPT_RT and wondered if it was in our RT code, or if it's from 
the base kernel code.

Greg W
