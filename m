Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 20:08:21 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:53899 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20036902AbXJOTIM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2007 20:08:12 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IhVFN-0000y4-0P; Mon, 15 Oct 2007 19:05:01 +0000
Message-ID: <4713B9DC.5050408@garzik.org>
Date:	Mon, 15 Oct 2007 15:05:00 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][1/2][MIPS] update AU1000 get_ethernet_addr()
References: <200710151012.l9FAChGC007295@po-mbox301.hop.2iij.net> <4713B3AA.9000701@garzik.org> <4713B93A.9040509@ru.mvista.com>
In-Reply-To: <4713B93A.9040509@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> Jeff Garzik wrote:
> 
>>> Update AU1000 get_ethernet_addr().
>>> Three functions were brought together in one.
> 
>>> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
>> applied 1-2
> 
>   Hm, the second patch was purely Linux/MIPS one, wasn't it?

Yep.  Ralf ack'd them via IRC, in this case.

	Jeff
