Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2005 00:20:35 +0000 (GMT)
Received: from amsfep18-int.chello.nl ([IPv6:::ffff:213.46.243.13]:59229 "EHLO
	amsfep18-int.chello.nl") by linux-mips.org with ESMTP
	id <S8224905AbVBPAUV>; Wed, 16 Feb 2005 00:20:21 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep18-int.chello.nl
          (InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
          id <20050216002014.JMNU4045.amsfep18-int.chello.nl@[127.0.0.1]>;
          Wed, 16 Feb 2005 01:20:14 +0100
Message-ID: <421291E2.8020308@amsat.org>
Date:	Wed, 16 Feb 2005 01:20:50 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	=?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>
CC:	linux-mips@linux-mips.org
Subject: Re: module segfault problem ADM5120
References: <42128A4F.20107@voda.cz>
In-Reply-To: <42128A4F.20107@voda.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

Tom Vrána wrote:

> Hello,
>
> I am currently experiencing trouble trying to load the madwifi drivers 
> on my MIPS (ADM5120), everytime I end up with the Oops pasted below. 
> Does that provide anyone a clue what may be wrong ? I've tried 
> changing the modules around, but this is what I get...
>
>       Thanks, Tom
>
> Unable to handle kernel paging request at virtual address 00000000, 
> epc == 800fb6fc, ra == 

Something seems to be trying to access memory location 00000000.
Maybe there is some NULL check missing in the driver init code?

Jeroen
