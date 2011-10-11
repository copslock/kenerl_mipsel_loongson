Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 19:32:10 +0200 (CEST)
Received: from eastrmfepo102.cox.net ([68.230.241.214]:44763 "EHLO
        eastrmfepo102.cox.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1JKRcH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2011 19:32:07 +0200
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmfepo102.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20111011173156.BCLP12239.eastrmfepo102.cox.net@eastrmimpo03.cox.net>;
          Tue, 11 Oct 2011 13:31:56 -0400
Received: from thunder.sweets ([68.100.141.95])
        by eastrmimpo03.cox.net with bizsmtp
        id jVXw1h00523hm2k02VXwhk; Tue, 11 Oct 2011 13:31:56 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020208.4E947D8C.00B6,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=1.1 cv=ASjpOCvEPoSfhuYnpalwTqAN2s78hBywh12H8bbbxwo=
 c=1 sm=1 a=sqqFQ7cWU8cA:10 a=PLag0n9VLbMA:10 a=G8Uczd0VNMoA:10
 a=8nJEP1OIZ-IA:10 a=NpDSbZnL7oWxO3tJXEQWVQ==:17 a=e22fObK1KDoUUrQu0gcA:9
 a=wPNLvfGTeEIA:10 a=NpDSbZnL7oWxO3tJXEQWVQ==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from [10.10.10.15] (thunder.sweets [10.10.10.15])
        by thunder.sweets (Postfix) with ESMTP id AA4E4FD78;
        Tue, 11 Oct 2011 13:31:55 -0400 (EDT)
Message-ID: <4E947D8A.9090409@cox.net>
Date:   Tue, 11 Oct 2011 13:31:54 -0400
From:   Joe Buehler <aspam@cox.net>
User-Agent: Thunderbird 1.5.0.12 (X11/20090114)
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     linux-mips@linux-mips.org
Subject: Re: using mprotect to write to .text
References: <loom.20111010T215444-70@post.gmane.org> <4E9470A1.8020309@cavium.com>
In-Reply-To: <4E9470A1.8020309@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aspam@cox.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7401

David Daney wrote:

> No, it does nothing of the sort.  You need cacheflush() for that.

OK, I looked at cacheflush and it can be used to flush the icache on all
CPUs, which is what I want.  My current code sequence is more than that
however.  Something like this:

	CVMX_ICACHE_INVALIDATE;
	CVMX_SYNC;
	uint64_t tmp;
	asm volatile ("    la %0,10f\n"
		  "    jr.hb %0\n"
		  "    nop\n"
		  "    10:\n" : "=r" (tmp) : : "memory");

I can certainly modify cacheflush for my application so the extra hazard
clearing is done when icache is flushed.  Is there any way to avoid that
and use existing kernel functionality?

Joe Buehler
