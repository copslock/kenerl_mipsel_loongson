Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 15:36:38 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:29652 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225532AbUDBOgh>; Fri, 2 Apr 2004 15:36:37 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B9Pm1-0001Ql-00; Fri, 02 Apr 2004 08:35:57 -0600
Message-ID: <406D7A1E.6080201@realitydiluted.com>
Date: Fri, 02 Apr 2004 09:35:10 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Fragile constructs in c-sb1.c
References: <Pine.LNX.4.55.0404021534430.4735@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0404021534430.4735@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>  There's a bunch of ugly and fragile constructs defining assembler symbols
> in c-sb1.c that depending on the configuration lead at least to an
> unresolved reference to local_sb1___flush_cache_all upon a final link.  
> Here's a fix that changes them to an equivalent implementation using a
> documented gcc syntax.
> 
>  OK to apply?
>
Heh, you beat me to it :). I had very similar problems with the same
function. Please apply.

-Steve
