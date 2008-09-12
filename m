Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2008 17:43:58 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:25871 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20272594AbYILQn4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2008 17:43:56 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3EAFA3ECC; Fri, 12 Sep 2008 09:43:53 -0700 (PDT)
Message-ID: <48CA9C74.1080004@ru.mvista.com>
Date:	Fri, 12 Sep 2008 20:44:36 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48C851ED.4090607@ru.mvista.com>	<20080912.005243.48535230.anemo@mba.ocn.ne.jp>	<48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>>>+		/*
>>>>>+		 * If only one of XFERINT and HOST was asserted, mask
>>>>>+		 * this interrupt and wait for an another one.  Note

>>>>  This comment somewhat contradicts the code which returns 1 if only 
>>>>HOST interupt is asserted if ERR is set.

>>    Which is not its business to test. I think you should remove that above 
>>check -- if there's INTRQ asserted, then it's asserted. I wonder if BMIDE 
>>interrupt bit gets set in that case (suspecting it's not)...

> Well, let me explain a bit.  The datasheed say I should wait _both_
> XFERINT and HOST interrupt.  So, if only one of them was asserted, I

    Since this is SFF-8038i compatible, you should first check if the spec'ed
interrupt status bit (called IDE_INT here) is set. If it isn't [always] get
set when it should, you may check for other interrupt bits (XFEREND/HOST/etc.)
and take the necessary measures if you detect interrupt on them.

> mask it and wait another one.  But on the error case, only HOST was
> asserted and XFERINT was never asserted.

    And I suspect that IDE_INT also doesn't get set, right? The check for 
ERR=1 however is not needed. If the drive does assert its interrupt signal 
(INTRQ), it knows better why.

> Then I could not exit from "waiting another one" state, until timeout.

    Well, at least most of the other [PCI] drivers will wait for timeout in 
the case of the DMA status register bit 2 (IDE_INT here) not set -- despite 
some IDE chips do have bits indicating the INTRQ status from IDE bus. But 
usually, INTRQ still comes thru to this bit even if a command ends in error... 
This isn't the case here?

MBR, Sergei
