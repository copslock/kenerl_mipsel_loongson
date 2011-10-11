Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 20:35:30 +0200 (CEST)
Received: from eastrmfepo203.cox.net ([68.230.241.218]:38395 "EHLO
        eastrmfepo203.cox.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1JKSf0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2011 20:35:26 +0200
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmfepo203.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20111011183516.ZGZQ3766.eastrmfepo203.cox.net@eastrmimpo02.cox.net>;
          Tue, 11 Oct 2011 14:35:16 -0400
Received: from thunder.sweets ([68.100.141.95])
        by eastrmimpo02.cox.net with bizsmtp
        id jWbG1h00723hm2k02WbGnP; Tue, 11 Oct 2011 14:35:16 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020207.4E948C64.0072,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=1.1 cv=oaIW6hvuqrvZuBstGxzMQDCn9/QU+BfQ2mb81G/9NAc=
 c=1 sm=1 a=sqqFQ7cWU8cA:10 a=PLag0n9VLbMA:10 a=G8Uczd0VNMoA:10
 a=8nJEP1OIZ-IA:10 a=NpDSbZnL7oWxO3tJXEQWVQ==:17 a=UdjR6XGtzev_aqXJbLwA:9
 a=wPNLvfGTeEIA:10 a=NpDSbZnL7oWxO3tJXEQWVQ==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from [10.10.10.15] (thunder.sweets [10.10.10.15])
        by thunder.sweets (Postfix) with ESMTP id 980BCFD78;
        Tue, 11 Oct 2011 14:35:15 -0400 (EDT)
Message-ID: <4E948C62.3000802@cox.net>
Date:   Tue, 11 Oct 2011 14:35:14 -0400
From:   Joe Buehler <aspam@cox.net>
User-Agent: Thunderbird 1.5.0.12 (X11/20090114)
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     linux-mips@linux-mips.org
Subject: Re: using mprotect to write to .text
References: <loom.20111010T215444-70@post.gmane.org> <4E9470A1.8020309@cavium.com> <4E947D8A.9090409@cox.net> <4E948593.6030604@cavium.com>
In-Reply-To: <4E948593.6030604@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aspam@cox.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7463

David Daney wrote:

> I cannot parse the meaning out of these last two sentences.  The
> cacheflush() system call both exists and works.  You want to change it?

Let me rewind a bit.  I have a multithreaded binary running on multiple
physical CPUs.  As part of a debugging mechanism, I want to make changes
to .text from a thread dedicated to the purpose.  This requires at the
least icache flushes on all CPUs but also hazard avoidance measures on
all CPUs.  So I understand anyway.

The cacheflush call will do the flush but not the hazard avoidance.  In
order to solve my particular issue I am thinking about adding the hazard
avoidance into cacheflush for my particular application.  It is not a
question of cacheflush being wrong, but of extending it to meet my
needs.  In fact, it seems like a useful change -- it will allow an
application to do exactly what I want to do, and easily so, and would
seem a logical place for the functionality to reside.

Sorry if I seem a bit muddled -- this is extremely low level and not
what I deal with day to day.

Joe Buehler
