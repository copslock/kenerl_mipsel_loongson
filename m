Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2005 19:14:21 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:205.217.158.170]:2796
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8224833AbVCFTOG>; Sun, 6 Mar 2005 19:14:06 +0000
Received: (qmail 11475 invoked from network); 6 Mar 2005 00:49:26 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 6 Mar 2005 00:49:26 -0800
Message-ID: <422B5676.7090207@total-knowledge.com>
Date:	Sun, 06 Mar 2005 11:13:58 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Frederic TEMPORELLI <frederic.temporelli@laposte.net>
CC:	linux-mips@linux-mips.org
Subject: Re: SGI IP32 and 2.6.11
References: <422B3C74.9090706@laposte.net>
In-Reply-To: <422B3C74.9090706@laposte.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

There is no such thing as 64M DIMM for O2. Put correct memory into your 
machine and
both of these problems will be solved.

Frederic TEMPORELLI wrote:

> Hello,
>
> I've just been able to start 2.6.11 from my own compilation on IP32.
>
> Can I have some help about following problems/comments ?
>
> 1/ It was really difficult because kernel was falling in breakpoint 
> call (BUG macro) in free_bootmem_core.
> => I've successfully try to comment this BUG macro in 
> free_bootmem_core (bootmem.c)
> Of course, I'm thinking this is really sad... but I've a really poor 
> knowledge in kernel development...
> may someone can explain how to solve such issue in a better way ?
> This breakpoint was boring me since 2.6.10...
>
> 2/ There's also a problem with ip32-memory.c, which isn't able to 
> detect 64MB dimm.
> Yet, not enough knowledge for processing bankctl (prom_meminit) in the 
> nice way for detecting 64MB dimms...
> (All memory slots are used on my O2: slots 1 to 6 with 32MB dimms and 
> slots 7 & 8 with  64MB dimms) .
>
> Best regards
>
> Frederic TEMPORELLI
>
>
>


-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
