Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2005 21:17:30 +0000 (GMT)
Received: from amsfep18-int.chello.nl ([IPv6:::ffff:213.46.243.20]:13596 "EHLO
	amsfep19-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225244AbVA0VRQ>; Thu, 27 Jan 2005 21:17:16 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep19-int.chello.nl
          (InterMail vM.6.01.03.05 201-2131-111-107-20040910) with ESMTP
          id <20050127211708.GRRO16287.amsfep19-int.chello.nl@[127.0.0.1]>;
          Thu, 27 Jan 2005 22:17:08 +0100
Message-ID: <41F95A61.50608@amsat.org>
Date:	Thu, 27 Jan 2005 22:17:21 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	sjhill@realitydiluted.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] ADM5120 for 2.6.10
References: <E1CuGlf-0000cy-Pl@real.realitydiluted.com>
In-Reply-To: <E1CuGlf-0000cy-Pl@real.realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

sjhill@realitydiluted.com wrote:

>Greetings.
>
>First, thank you for your patch. However, there are a number of things
>that you have to do before it will be accepted.
>
>   1) You should be creating your patch against the Linux/MIPS kernel
>      tree present in CVS. You can go to http://www.linux-mips.org/
>      to see how to get the latest code.
>
>   2) Change your machine config definition of 'MIPS_AM5120' to be
>      'MIPS_ADM5120' as it makes more sense.
>
>   3) A number of your files, 'arch/mips/am5120/5120_rtc.c' for an
>      example, has an unacceptable copyright banner in it. Your code
>      will not be accepted unless it is licensed under GPL or a shared
>      BSD style license. Please speak with your management and get
>      approval. You will also need to sign off your code contribution.
>
>   4) It might be good to have your serial driver up in 'drivers/serial'
>      instead of down in 'arch/mips' somewhere. Perhaps someone else
>      will have comments on that.
>
>   5) Your PCI code should be located in 'arch/mips/pci'.
>
>   6) Your change to 'include/linux/init.h' for early init calls
>      is unnecessary. The latest tree already supports this and
>      the linker script takes care of placing them in the proper
>      section.
>
>After you have addressed the issues above, please re-submit your patch.
>Thanks!
>
I agree with your points...
Just to clarify: I don't intend this patch to be merged with anything, 
its just an intermediate step I thought people here might be interested in.
I'll try to make that clearer if I post further patches.

With respect to point 3, I am not an admtek employee, its just a hobby 
project. I also send an mail about this copyright notice earlier, since 
nobody started shouting it was wrong to remove these messages I asume I 
can modify them into something sensible.

Jeroen
