Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2008 16:57:17 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:23511 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28583927AbYAQQ5I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2008 16:57:08 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A94F03EC9; Thu, 17 Jan 2008 08:57:04 -0800 (PST)
Message-ID: <478F8915.4060808@ru.mvista.com>
Date:	Thu, 17 Jan 2008 19:57:57 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	frank.rowand@am.sony.com
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] serial_txx9 driver support
References: <1200436139.4092.30.camel@bx740>	 <1200436432.4092.38.camel@bx740>	 <20080117.004716.59650985.anemo@mba.ocn.ne.jp> <1200527181.3939.12.camel@bx740>
In-Reply-To: <1200527181.3939.12.camel@bx740>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello Frank. :-)

>>>Add polled debug driver support to serial_txx9.c for kgdb, and initialize
>>>the driver for the Toshiba RBTX4927.

>>I think Jason Wessel's kgdb patchset is a way to go.

> Somehow I overlooked Jason's patchset.  Yes, I agree that is the way to go,

    BTW, that patchset already has TX[34]9xx KGDB serial driver...

> so my four patches should not be applied.

    Well, it's not in the mainline yet anyway...

> -Frank

WBR, Sergei
