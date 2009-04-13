Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Apr 2009 12:37:22 +0100 (BST)
Received: from xylophone.i-cable.com ([203.83.115.99]:33215 "HELO
	xylophone.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20024018AbZDMLhQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Apr 2009 12:37:16 +0100
Received: (qmail 18876 invoked by uid 508); 13 Apr 2009 11:36:59 -0000
Received: from 203.83.114.122 by xylophone (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.191304 secs); 13 Apr 2009 11:36:59 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 13 Apr 2009 11:36:59 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3DBavfN024389;
	Mon, 13 Apr 2009 19:36:58 +0800 (CST)
Date:	Mon, 13 Apr 2009 19:36:40 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	yanhua <yanh@lemote.com>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: Re: [PATCH 1/14] lemote: Loongson2F based machines support
Message-ID: <20090413113640.GB6137@adriano.hkcable.com.hk>
Mail-Followup-To: yanhua <yanh@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	=?utf-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
References: <49DD7E88.7040305@lemote.com> <m3prfm6x1d.fsf@anduin.mandriva.com> <49DDB965.3060200@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DDB965.3060200@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 17:01 Thu 09 Apr     , yanhua wrote:
[snip]
> This is just for historical reasons. Before, we have loongson2e machines  
> named as fulong(from loogson2f, changeed to fuloong) merged into main  
> kernel.

I suggest we might as well change fulong to fuloong2e, while call 2f based
fuloong fuloong2f (or something similar, you get the idea).

Because, fulong and fuloong are almost indistinguishable, neither on spelling
nor on pronunciation.

Of course, we can deal with fulong(2e) later. However, I strongly suggest we get
fuloong2f right in the first place.

Zhang, Le
