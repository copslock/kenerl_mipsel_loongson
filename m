Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 14:48:25 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:15315
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225202AbTB0OsZ>; Thu, 27 Feb 2003 14:48:25 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18oPJa-0005m2-00; Thu, 27 Feb 2003 08:47:14 -0600
Message-ID: <3E5E22C7.8080900@realitydiluted.com>
Date: Thu, 27 Feb 2003 08:37:59 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: ZhouY.external@infineon.com
CC: linux-mips@linux-mips.org
Subject: Re: How can I the flash memory of MIPS Malta board in my application?
References: <3A5A80BF651115469CA99C8928706CB603D7B2FA@mucse004.eu.infineon.com>
In-Reply-To: <3A5A80BF651115469CA99C8928706CB603D7B2FA@mucse004.eu.infineon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

ZhouY.external@infineon.com wrote:
>
>     I want to save some test data inside the flash memory of MIPS Malta
> board, and later access these test data from my application. How can I do
> that? 
>     If you know the clue about it, please drop me a line. Thanks in advance!
>
Well, I have not worked with the Malta board, yet. I will assume
the flash is standard NOR flash accessible through a sane memory
mapping. You should probably use the MTD layer and then you can
use the character or block devices to access your data. I would
guess you should use the Physically Mapped MTD driver. The MTD
web page is (http://www.linux-mtd.infradead.org/). Cheers.

-Steve
