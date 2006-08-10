Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 17:11:39 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:55550 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20043735AbWHJQLf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2006 17:11:35 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 448253ED9; Thu, 10 Aug 2006 09:11:30 -0700 (PDT)
Message-ID: <44DB5AFA.7020304@ru.mvista.com>
Date:	Thu, 10 Aug 2006 20:12:42 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 2/7 AU1100 MMC support
References: <20060809210843.GC13145@enneenne.com> <44DB34C2.3090302@ru.mvista.com> <20060810133658.GZ342@enneenne.com>
In-Reply-To: <20060810133658.GZ342@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

>>>static void au1xmmc_set_power(struct au1xmmc_host *host, int state)
>>>{

>>>-	u32 val = au1xmmc_card_table[host->id].bcsrpwr;
>>>+	u32 val;

>>>+	val = au1xmmc_card_table[host->id].power;
>>>+
>>>+#if defined(CONFIG_MIPS_DB1200)
>>>	bcsr->board &= ~val;
>>>	if (state) bcsr->board |= val;
>>>+#endif

>>>	au_sync_delay(1);
>>>}

>>   If DBAu1100 doesn't allow to control slot power, then I don't think 
>>pretending it does is a good thing. Shouldn't these #ifdef's be in 
>>au1xmmc_set_ios() instead (the function is void anyway but that would allow 
>>us to save on the code size a bit more)?

> Mmm. I proposed that solution but I don't know exaclty how several
> DB1x00 boards work. I just protect the variable "bcsr" which is not
> defined for my board.

    That wasn't obvious from the patch that this is intended for some specific 
board and BCSRs (board control/status registers) seem to exist on all Alchemy 
development boards.

>>>static inline int au1xmmc_card_inserted(struct au1xmmc_host *host)
>>>{
>>>-	return (bcsr->sig_status & au1xmmc_card_table[host->id].bcsrstatus)
>>>-		? 1 : 0;
>>>+	u32 val, data = 1;
>>>+
>>>+	val = au1xmmc_card_table[host->id].status;
>>>+
>>>+#if defined(CONFIG_MIPS_DB1200)
>>>+	data = bcsr->sig_status & val;
>>>+#endif
>>>+
>>>+	return !!data;
>>>}

>>   Hrm, are you sure there's no way to sense that the card is *really* 
>>inserted or not?
> 
> 
> Again as above. For my specific board I use:

>    #if defined(CONFIG_MIPS_DB1200)
>        data = bcsr->sig_status & val;
>    #elif defined(CONFIG_MIPS_MYBOARD)
>        specific code...
>    #endif

> Maybe we should modify my solution including other DB1x00 boards
> ifdef. However, the important thing is to protect againt variable
> "bcsr" if a specific board doesn't support it.

    If you're not introducing the support for the new board, introducing those 
#ifdef's doesn't make much sense.
    Overall, the support for the boards other than Pb/DbAu1200 seems broken in 
that driver -- see below why...

>>>static inline int au1xmmc_card_readonly(struct au1xmmc_host *host)
>>>{
>>>-	return (bcsr->status & au1xmmc_card_table[host->id].wpstatus)
>>>-		? 1 : 0;
>>>+	u32 val, data = 0;
>>>+
>>>+	val = au1xmmc_card_table[host->id].wpstatus;
>>>+
>>>+#if defined(CONFIG_MIPS_DB1200)
>>>+	data = bcsr->status & val;
>>>+#endif
>>>+
>>>+	return !!data;
>>>}

>>   Ditto.

> The same as above. :)

    Indeed, some modifications are needed for the other Alchemy boards -- 
there's some discrepancy with the "board" register in particular, for the 
boards older than Pb/DBAu1200 it was called "specific" having much the same 
format and purpose. This is not so however with "sig_status" and "status" 
registers used to sense card's presence and for write protecting. Judging on 
<asm/mach-db1x00/db1x00.h>, "specific" reg. should be used instead. There are 
MMC macros in that file BTW for detecting the cards and applying power to them.

> Ciao,

WBR, Sergei
