Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 13:56:01 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:47814
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224939AbTBXN4A>; Mon, 24 Feb 2003 13:56:00 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18nJ4z-00039x-00; Mon, 24 Feb 2003 07:55:37 -0600
Message-ID: <3E5A223B.5020505@realitydiluted.com>
Date: Mon, 24 Feb 2003 07:46:35 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: SANTHOSH K <santhoshk@nestec.net>
CC: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: QUERY: Porting Linux kernel to Toshiba TX4927
References: <F6E1228667B6D411BAAA00306E00F2A5153A6F@pdc2.nestec.net>
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A5153A6F@pdc2.nestec.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

SANTHOSH K wrote:
> 
> 1. Has somone already ported Linux to TX4927 chip?
 >
Yes, we (TimeSys) have already done this.

> 2. If not, what is the complexity of this wor?
 >
Oh, it was a pretty interesting port. The PCI code is
pretty awful.

> 3. If yes, then who is maintaining it. We could not get any information from
 > the source tree.
 >
We will actively maintain it.

> 4. If yes, is it an open source? where can I get the source code.
>
The code should be released in the next couple of months.

-Steve
