Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 10:29:11 +0000 (GMT)
Received: from royk.itea.ntnu.no ([IPv6:::ffff:129.241.190.230]:8679 "EHLO
	royk.itea.ntnu.no") by linux-mips.org with ESMTP
	id <S8225224AbULGK3H>; Tue, 7 Dec 2004 10:29:07 +0000
Received: from localhost (localhost [127.0.0.1])
	by royk.itea.ntnu.no (Postfix) with ESMTP id 47B8B67556;
	Tue,  7 Dec 2004 11:29:05 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.179.15])
	by royk.itea.ntnu.no (Postfix) with ESMTP;
	Tue,  7 Dec 2004 11:29:05 +0100 (CET)
Received: from invalid.ed.ntnu.no (localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9) with ESMTP id iB7AT418044520
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Tue, 7 Dec 2004 11:29:05 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9/Submit) with ESMTP id iB7AT46v044517;
	Tue, 7 Dec 2004 11:29:04 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date: Tue, 7 Dec 2004 11:29:04 +0100 (CET)
From: Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: HIGHMEM
In-Reply-To: <003801c4dc45$f9212690$2203a8c0@qfree.com>
Message-ID: <20041207112038.X44387@invalid.ed.ntnu.no>
References: <003801c4dc45$f9212690$2203a8c0@qfree.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

> In 2.4 the support for CONFIG_DISCONTIG and CONFIG_NUMA are a bit tangled
> with each other because IP27 is the only platform to uses these features and
> it needs both.  Other than that you can also just setup your system as 0x0 -
> 0x10000000 being RAM, 0x10000000 - 0x20000000 being reserved memory and
> 0x20000000 - 0x30000000 being highmem.  Which works but is a bit wasteful.
>
> Issue #2 is that we don't support the combination of CONFIG_DISCONTIG and
> CONFIG_HIGHMEM.  And highmem is a lobotomized solution for lobotomized
> silicon anyway.  You have a 64-bit processor - use it's capabilities :-)
>
> Issue #3 - As I recall the TX4937's H3 core is suffering from cache aliases.
> Handling those efficiently for highmem is not easily possible and so we
> don't even try.  More recent kernels will refuse to enable highmem on such
> cache configurations but something like 2.4.18 which by now is an almost 3
> year old antique doesn't know about that and will happily crash.
>
> I recommend you should go for a 64-bit kernel instead.  And 64-bit support
> is certainly better in 2.6 than in 2.4.  Especially the area of 32-bit
> binary compatibility has been improved significantly.

What about on a processor like the AMD au1550?

I've tried the latest from 2.4 branch in cvs, and I haven't been 
successful in geting past INIT either...

Can I place all the memory from address 0x20000000 to get more than 
256Meg?


-- 
Jon Anders Haugum
