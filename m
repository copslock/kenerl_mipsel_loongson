Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2005 13:58:15 +0000 (GMT)
Received: from kilimandjaro.dyndns.org ([IPv6:::ffff:212.85.147.17]:776 "EHLO
	kilimandjaro.dyndns.org") by linux-mips.org with ESMTP
	id <S8225009AbVACN6K>; Mon, 3 Jan 2005 13:58:10 +0000
Received: by kilimandjaro.dyndns.org (Postfix, from userid 500)
	id 11F5CBE85A; Mon,  3 Jan 2005 14:41:00 +0100 (CET)
Received: from saperlipopette ([127.0.0.1] helo=kilimandjaro.dyndns.org)
	by saperlipopette with esmtp (Exim 4.22)
	id 1ClSGJ-0001Gy-7D; Mon, 03 Jan 2005 14:28:43 +0100
Message-ID: <41D94888.8070607@kilimandjaro.dyndns.org>
Date: Mon, 03 Jan 2005 14:28:40 +0100
From: Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
User-Agent: Mozilla Thunderbird 0.4 (X11/20040306)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "Habeeb J. Dihu" <macgyver@tos.net>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4.18 Cobalt Tulip lockups too
References: <200412280039.iBS0dFXA014161@starbase.tos.net>
In-Reply-To: <200412280039.iBS0dFXA014161@starbase.tos.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dom@kilimandjaro.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@kilimandjaro.dyndns.org
Precedence: bulk
X-list: linux-mips

Habeeb J. Dihu wrote:

>>Badness in local_bh_enable at kernel/softirq.c:141
>>    
>>
Hello list,

I own a Cobalt Raq2. I switched ISPs before xmas, and used the 
opportunity to install kernel 2.4.18 + Debian mipsel using the 
directives at http://people.debian.org/~pm/deb-cobalt-howto.txt (many 
thanks to Paul Martin)! Everything went fine, but I experienced a freeze 
while both network cards were used simultaneously. The kernel messages 
didn't make it to the syslog, and I didn't have a serial console ready 
at that instant, so I'm afraid I'm not going to be much more helpful 
than that :-).

Happy new year to all,

-- 
<< Tout n'y est pas parfait, mais on y honore certainement les jardiniers >>

			Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
