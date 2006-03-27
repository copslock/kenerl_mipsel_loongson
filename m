Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 13:29:11 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([80.176.203.50]:15339 "EHLO
	pangolin.localnet") by ftp.linux-mips.org with ESMTP
	id S8133487AbWC0M3D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 13:29:03 +0100
Received: from hylobates.localnet ([192.168.1.21])
	by pangolin.localnet with esmtp (Exim 3.36 #1 (Debian))
	id 1FNqzp-0006pZ-00; Mon, 27 Mar 2006 13:38:57 +0100
Message-ID: <4427DCE4.4000807@bitbox.co.uk>
Date:	Mon, 27 Mar 2006 13:39:00 +0100
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	"P. Horton" <pdh@colonel-panic.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	netdev@vger.kernel.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org> <20060306225131.GA23327@unjust.cyrius.com> <20060306231530.GB16082@electric-eye.fr.zoreil.com> <20060307035824.GA24018@linux-mips.org> <Pine.LNX.4.62.0603071031520.5292@pademelon.sonytel.be> <20060308224139.GA7536@electric-eye.fr.zoreil.com> <Pine.LNX.4.62.0603091032490.9741@pademelon.sonytel.be> <20060309224456.GB9103@electric-eye.fr.zoreil.com> <20060327070112.GA10906@deprecation.cyrius.com>
In-Reply-To: <20060327070112.GA10906@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Francois Romieu <romieu@fr.zoreil.com> [2006-03-09 23:44]:
>   
>>> So when compiling for Cobalt, we work around the hardware bug, while for other
>>> platforms, we just disable MWI?
>>>
>>> Wouldn't it be possible to always (I mean, when a rev 65 chip is detected)
>>> work around the bug?
>>>       
>> Of course it is possible but it is not the same semantic as the initial
>> patch (not that I know if it is right or not).
>>
>> So:
>> - does the issue exist beyond Cobalt hosts ?
>> - is the fix Cobalt-only ?
>>     
>
> I don't think anyone has replied to this message yet.  My
> understanding is that it's not Cobalt only but a problem in a specific
> revision of the chip, which the Cobalt happens to use.  However, I'd
> be glad if somone else could comment.  Peter, you read the errata
> right?
>   

According to the errata it applies to all DEC 21143-PD and 21143-TD 
which are the chips with the revision code 0x41 (65). The errata states 
the receive buffers should not end on a cache aligned boundary when 
using MWI otherwise the receiver will not close the last descriptor.

P.
