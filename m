Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 10:54:57 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:58306 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133409AbWFTJys (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 10:54:48 +0100
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k5K9se71015709;
	Tue, 20 Jun 2006 02:54:40 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 20 Jun 2006 02:54:40 -0700
Received: from [192.168.96.27] ([192.168.96.27]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 20 Jun 2006 02:54:39 -0700
Message-ID: <4497C5DC.8060108@windriver.com>
Date:	Tue, 20 Jun 2006 17:54:36 +0800
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	yoichi_yuasa@tripeaks.co.jp
Subject: Re: Merge window ...
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2006 09:54:40.0267 (UTC) FILETIME=[8C3B6DB0:01C6944F]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

> RBHMA4500
> SNI RM200
> Sibyte BCM91250A-SWARM
> Wind River PPMC(New one, It'll be fixed)

I just submitted the patch of the base support to Wind River PPMC Board a few weeks ago.
So please don't remove this board. And I will submit another patch against the current
Linux/MIPS git repository, to fix the build error for this board.

Best Regards,
Mark.Zhan
