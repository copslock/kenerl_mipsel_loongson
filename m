Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 14:04:26 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:2529 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8226106AbVDKNEL>; Mon, 11 Apr 2005 14:04:11 +0100
Received: from sprocket.localnet ([192.168.1.27])
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1DKyaD-00015w-00; Mon, 11 Apr 2005 14:04:05 +0100
Message-ID: <425A75C2.80802@colonel-panic.org>
Date:	Mon, 11 Apr 2005 14:04:02 +0100
From:	Peter Horton <pdh@colonel-panic.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/3] fix hang on Qube2700 boot
References: <20050410130635.GA20589@skeleton-jack> <20050411122724.GU7038@linux-mips.org>
In-Reply-To: <20050411122724.GU7038@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Sun, Apr 10, 2005 at 02:06:35PM +0100, Peter Horton wrote:
>
>  
>
>>The Qube2700 boot hangs because the old "prom" style console is
>>unconditionally enabled. Drop the "prom" console code from the build. It
>>would only be used if no "console=" line was supplied and in that case
>>the current 8250 code defaults to using ttyS0 at 9600 anyway (assuming a
>>port exists).
>>    
>>
>
>Ok, applied - but that leaves the unused arch/mips/cobalt/promcon.c around.
>Guess it should die as well?
>
> 
>
Yep, probably. It was handy for debugging very early boot, but it's not 
worth cluttering the tree with it.

P.
