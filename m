Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 17:44:44 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:8084 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133733AbVJaRo1
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 17:44:27 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j9VHiZCR011099;
	Mon, 31 Oct 2005 09:44:35 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j9VHiW17002164;
	Mon, 31 Oct 2005 09:44:33 -0800 (PST)
Message-ID: <4366584C.8080503@mips.com>
Date:	Mon, 31 Oct 2005 18:45:48 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC] Add 4KSx support (try 2)
References: <cda58cb80510310034k60b273dfm@mail.gmail.com>	 <4365DF22.8060004@mips.com> <cda58cb80510310801v2d60f60bh@mail.gmail.com>
In-Reply-To: <cda58cb80510310801v2d60f60bh@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Franck wrote:

>>There are places, for example arch/mips/mm/cache.c, but
>>also some of the other makefiles, where you're using your
>>new config flags to drive things where the standard
>>CONFIG_CPU_MIPS32 (which I guess has now fragmented into
>>CONFIG_CPU_MIPS32_R1 and CONFIG_CPU_MIPS32_R2, which would
>>apply to the Sc and Sd respectively) would do the right thing
>>while creating fewer source file mods.
>>
> 
> 
> That's correct but CONFIG_CPU_MIPS32_Rx seems to be a fallback case.
> Don't other cpu use their own flags whereas they could just use
> CONFIG_CPU_MIPS32_Rx flag instead ?

I think that those other CPUs aren't, strictly speaking,
MIPS32-compliant CPUs in one respect or another, so they
end up picking up MIPS32 kernel behavior "a la carte".
The 4KS family is a strict superset.

	Regards,

	Kevin K.
