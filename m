Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2003 13:00:40 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:48345
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224985AbTKXNA3>; Mon, 24 Nov 2003 13:00:29 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AOGKF-0000ZW-00
	for <linux-mips@linux-mips.org>; Mon, 24 Nov 2003 07:00:23 -0600
Message-ID: <3FC200DF.8000804@realitydiluted.com>
Date: Mon, 24 Nov 2003 08:00:15 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Kernel interface for MIPS timers....
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Hello.

This could be an embarassing question, but I seem to be good at
asking those anyway. A lot more MIPS processors lately seem to
come with multiple timers. In addition to the main HPT timer on
R4K variants and above, usually there are 2 or 3 additional 16
or 32-bit timers with prescalars and other features. Some drivers
may decide to use one of these timers exclusively and I am sure
there are many other uses as well. There does not seem to be any
type of API or reservation system to cleanly utilize the timers
present in the system. Actually, on a lot of my boards the added
timers do not get any usage, but perhaps that could change. Has
anyone given thought to this, or does it just seem pointless?
Thanks.

-Steve
