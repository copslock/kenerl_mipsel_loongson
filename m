Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 22:41:17 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:50070 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021967AbXGXVlP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 22:41:15 +0100
Received: from lagash (88-106-245-10.dynamic.dsl.as9105.com [88.106.245.10])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id AB7EABA12B;
	Tue, 24 Jul 2007 23:20:35 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IDRo2-0004By-QC; Tue, 24 Jul 2007 22:20:34 +0100
Date:	Tue, 24 Jul 2007 22:20:34 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] tx49xx: add some mach specific headers
Message-ID: <20070724212034.GA26960@networkno.de>
References: <20070725.015008.78730579.anemo@mba.ocn.ne.jp> <46A6302A.5010105@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46A6302A.5010105@ru.mvista.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
>
> Atsushi Nemoto wrote:
>
>> diff --git a/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h 
>> b/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h
>> new file mode 100644
>> index 0000000..275eaf9
>> --- /dev/null
>> +++ b/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h
>> @@ -0,0 +1,23 @@
> [...]
>> +#define cpu_has_mips32r1	0
>> +#define cpu_has_mips32r2	0
>> +#define cpu_has_mips64r1	0
>> +#define cpu_has_mips64r2	0
>
>    Hm, really?

IIRC it is MIPS IV. (tx99 is MIPS64R1).


Thiemo
