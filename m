Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2008 22:31:59 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:61035 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S29057862AbYICVb4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2008 22:31:56 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CF46E3ECB; Wed,  3 Sep 2008 14:31:51 -0700 (PDT)
Message-ID: <48BF0243.30801@ru.mvista.com>
Date:	Thu, 04 Sep 2008 01:31:47 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4/6] TXx9: Add TX4939 SoC support
References: <1220275361-5001-4-git-send-email-anemo@mba.ocn.ne.jp>	<48BE6137.1090008@ru.mvista.com> <20080904.010229.108120775.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080904.010229.108120775.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>    At last. Cool. I know this SoC has IDE controller. Planning on 
>> submitting a driver?
>>     

   I myself have the source (outdated and needing a big hammer) and even 
the documentaion AFAIR but lack both the hardware (at least locally 
accessible) and time.

> Yes, but I'm wondering whether it is worth to submit before converting
> to ata driver.

   Well,  IDE is still more embedded friendly (not coupled with SCSI -- 
unlike libata)...

> It seems the drivers/ide in in deep
> cleanup/refactoring state.  (linux-next contains 100 patches from
> Bartlomiej!)
>
> Do you think a new ide driver will be accepted?
>   

   Of course it will. But due to much of refactoring that's been 
happening it will require some work to move it forward from the older 
version (I guess you have it as well): IDE drivers should now be pretty 
close to the libata ones functionally.

> ---
> Atsushi Nemoto

MBR, Sergei
