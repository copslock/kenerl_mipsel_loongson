Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 21:59:15 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:52414 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225458AbUC2U7O>; Mon, 29 Mar 2004 21:59:14 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B83qX-00060c-00; Mon, 29 Mar 2004 14:59:01 -0600
Message-ID: <40688E13.2070905@realitydiluted.com>
Date: Mon, 29 Mar 2004 15:58:59 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Brian Murphy <brian@murphy.dk>, linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com> <008901c415d0$3a94d5f0$10eca8c0@grendel>
In-Reply-To: <008901c415d0$3a94d5f0$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> 
> The whole network driver cache management paradigm was redone for 2.4,
> and I've often wondered whether the same potential problem exists, but never
> had the time to go in and check.
> 
> There, I've mentioned it.  My conscience is clear.  ;o)
>
*blush* Okaay, I....I need to clear my conscience too. I knew about this
when posting, but forgot to mention it. Brian, you may find that the + 2
for IP alignment does not work precisely for the reason Kevin mentioned.
You may need to cache align your RX buffer. Again, let us know what you
discover. Okay, now MY conscience is clear.

-Steve
