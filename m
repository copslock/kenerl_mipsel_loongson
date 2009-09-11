Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2009 17:59:37 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13468 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492789AbZIKP7a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Sep 2009 17:59:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aaa73d00000>; Fri, 11 Sep 2009 08:59:12 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Sep 2009 08:58:29 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Sep 2009 08:58:28 -0700
Message-ID: <4AAA73A4.9010601@caviumnetworks.com>
Date:	Fri, 11 Sep 2009 08:58:28 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>,
	linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
 to compiler.h
References: <4AA991C1.1050800@caviumnetworks.com> <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com> <200909111633.00665.mb@bu3sch.de>
In-Reply-To: <200909111633.00665.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2009 15:58:28.0891 (UTC) FILETIME=[B4225EB0:01CA32F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Michael Buesch wrote:
> On Friday 11 September 2009 01:56:42 David Daney wrote:
>> +/* Unreachable code */
>> +#ifndef unreachable
>> +# define unreachable() do { for (;;) ; } while (0)
>> +#endif
> 
> # define unreachable() do { } while (1)
> 
> ? :)

Clearly I was not thinking clearly when I wrote that part.  RTH noted 
the same thing.  I will fix it.

Thanks,
David Daney
