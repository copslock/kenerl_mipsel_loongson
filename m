Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2008 18:20:04 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:50193 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20284677AbYILRSn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2008 18:18:43 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 530603EC9; Fri, 12 Sep 2008 10:18:39 -0700 (PDT)
Message-ID: <48CAA498.9090804@ru.mvista.com>
Date:	Fri, 12 Sep 2008 21:19:20 +0400
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
X-archive-position: 20481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

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
> mask it and wait another one.  But on the error case, only HOST was
> asserted and XFERINT was never asserted.  Then I could not exit from
> "waiting another one" state, until timeout.

    Hmm, I got it: you decide whether it's worth waiting more for XFEREND 
interrupt based on whether ERR is set or not. I suppose IDE_INT doesn't get 
set in case the command gets endede with ERR set?

MBR, Sergei
