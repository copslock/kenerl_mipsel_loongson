Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2005 10:20:18 +0100 (BST)
Received: from kilimandjaro.dyndns.org ([IPv6:::ffff:212.85.147.17]:25608 "EHLO
	kilimandjaro.dyndns.org") by linux-mips.org with ESMTP
	id <S8226222AbVDOJUC>; Fri, 15 Apr 2005 10:20:02 +0100
Received: by kilimandjaro.dyndns.org (Postfix, from userid 500)
	id 38919BE85D; Fri, 15 Apr 2005 11:19:53 +0200 (CEST)
Received: from saperlipopette ([127.0.0.1] helo=kilimandjaro.dyndns.org)
	by saperlipopette with esmtp (Exim 4.22)
	id 1DMN0R-0002Jy-7k; Fri, 15 Apr 2005 11:20:55 +0200
Message-ID: <425F8776.6080703@kilimandjaro.dyndns.org>
Date:	Fri, 15 Apr 2005 11:20:54 +0200
From:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
User-Agent: Mozilla Thunderbird 0.4 (X11/20040306)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [OFF-TOPIC] Cobalt 64-bit, what for? (was: 64-bit fix)
References: <20050414185949.GA5578@skeleton-jack>
In-Reply-To: <20050414185949.GA5578@skeleton-jack>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dom@kilimandjaro.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@kilimandjaro.dyndns.org
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:

>This patch adds detection of broken 64-bit mode LL/SC on Cobalt units.
>With this patch my Qube2700 boots a 64-bit build fine. The later units
>have some problems with the Tulip driver.
>  
>
Just out of curiosity, is there any practical interest in going 64bit on 
Cobalt besides the fun of it? One cannot possibly squeeze more than 4 Gb 
of RAM into a Cobalt box right? And doesn't 64 bit mode have costs of 
its own (doubled i-fetch bandwidth for starters)?

-- 
<< Tout n'y est pas parfait, mais on y honore certainement les jardiniers >>

			Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
