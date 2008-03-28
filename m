Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 12:39:11 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:14188 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S528498AbYC1LjG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 12:39:06 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 113EE3EC9; Fri, 28 Mar 2008 04:38:34 -0700 (PDT)
Message-ID: <47ECD90E.2020903@ru.mvista.com>
Date:	Fri, 28 Mar 2008 14:39:58 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Nico Coesel <ncoesel@DEALogic.nl>, linux-mips@linux-mips.org
Subject: Re: FW: Alchemy power managment code.
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl> <47EA7A7B.8020602@ru.mvista.com> <20080327223247.GB26997@linux-mips.org>
In-Reply-To: <20080327223247.GB26997@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>>Funny you ask because I tried this yesterday on a AU1100 system with the
>>>2.6.24 kernel (from kernel.org). I'm afraid I must say the kernel
>>>crashes when I enable power management. The reason I want to use power
>>>management is because I need to send the CPU to sleep when the system
>>>shuts down. I hacked power.c and reset.c a bit so au_sleep() is called
>>>when the system is shut down. Perhaps someone can confirm the
>>>powermanagement can be made to work with some fixes (it didn't work with
>>>2.6.21-rc4 either).

>>   BTW, for anybody interested in Alchemy PM code, here's the interesting
>>link: [ftp|http]://ftp.enneenne.com/pub/misc/au1100-patches/linux/.
>>   It contains  a lot of unmerged PM patches by Rodolfo Giometti (and not
>>only that) from around 2.6.17 time.

> Anybody interested in reviewing these patches and polishing them to be
> applied to a recent kernel?

    I am, at least to some extent. But I'm not sure I'll have enough time from 
now on. Should have started earlier...

>   Ralf

WBR, Sergei
