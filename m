Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 19:40:01 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:24534
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224847AbTCXTkB>; Mon, 24 Mar 2003 19:40:01 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18xXnY-0000ps-00; Mon, 24 Mar 2003 13:39:56 -0600
Message-ID: <3E7F5F04.7020108@realitydiluted.com>
Date: Mon, 24 Mar 2003 14:39:48 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: Proposed patch for MIPS PCI autoscanning code...
References: <3E7F2BB4.8060108@realitydiluted.com> <20030324100855.M1926@mvista.com>
In-Reply-To: <20030324100855.M1926@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> 
> Can you illustrate more why the generic PCI functions won't work in your
> case?
> 
It turned out to be additional locking that was added in that I did not
know about and hence the patch should be discarded :). Oh well, it's a
Monday.

-Steve
