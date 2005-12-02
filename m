Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 22:02:26 +0000 (GMT)
Received: from [85.8.13.51] ([85.8.13.51]:13736 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S8133598AbVLBWCI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 22:02:08 +0000
Received: from [10.100.1.247] ([::ffff:213.115.244.31])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Fri, 02 Dec 2005 23:05:48 +0100
  id 00062717.4390C53C.00007287
Message-ID: <4390C53A.70606@drzeus.cx>
Date:	Fri, 02 Dec 2005 23:05:46 +0100
From:	Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: ALCHEMY:  Add SD support to AU1200 MMC/SD driver
References: <20051202190108.GF28227@cosmic.amd.com> <4390A38A.1010907@drzeus.cx> <20051202211709.GL28227@cosmic.amd.com>
In-Reply-To: <20051202211709.GL28227@cosmic.amd.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

Jordan Crouse wrote:
> On 02/12/05 20:42 +0100, Pierre Ossman wrote:
>> Jordan Crouse wrote:
>>> @@ -196,7 +207,11 @@ static int au1xmmc_send_command(struct a
>>>  
>>>  	switch(cmd->flags) {
>>>  	case MMC_RSP_R1:
>>> -		mmccmd |= SD_CMD_RT_1;
>>> +		if (cmd->opcode == 0x03 && host->mmc->mode == MMC_MODE_SD)
>>> +			mmccmd |= SD_CMD_RT_6;
>>> +		else
>>> +			mmccmd |= SD_CMD_RT_1;
>>> +
>>>  		break;
>>>  	case MMC_RSP_R1B:
>>>  		mmccmd |= SD_CMD_RT_1B;
>> No, no, no! Even if this wasn't already fixed in the current kernel you
>> never hack around bugs in other parts of the kernel, you fix them!
> 
> As of a git pull about 30 minutes ago, both MMC_RSP_R1 and MMC_RSP_R6 resolve
> to (MMC_RSP_SHORT|MMC_RSP_CRC).  Now, I really wouldn't call that a 
> bug in the subsystem, because it is technically correct, but the Au1200
> needs us to specifically specify if the required response is an R1 or
> an R6, thus the specified logic.  
> 

Point, but then you should figure out the distinction and why the
controller requires it (I assume you have tried giving the controller
"incorrect" settings). At that point the MMC layer can be extended to
handle this in a general manner instead of hacks in every other driver.
Judging from your email address you seem to be at a good position to
find out what the problem is.

Rgds
Pierre
