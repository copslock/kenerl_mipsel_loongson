Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 18:02:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:49591 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039500AbWJWRCN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 18:02:13 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 75E8F3EBE; Mon, 23 Oct 2006 10:02:10 -0700 (PDT)
Message-ID: <453CF591.4050406@ru.mvista.com>
Date:	Mon, 23 Oct 2006 21:02:09 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp> <453CD3ED.8020005@ru.mvista.com>
In-Reply-To: <453CD3ED.8020005@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> Since we already moved to GENERIC_TIME, we should implement
>> alternatives of old do_gettimeoffset routines to get sub-jiffies
>> resolution from gettimeofday().  This patch includes:

>> * mips_hpt_mask variable to specify bitmask of hpt value.

>    There's actually no need to introduce more variables. Just make 
> clocksource declaration public and override default mask if necessary.
>    Also, I don't see much sense in further existence of mips_hpt_read() 
> -- it only causes each clocksource read go thru a double indirection 
> which is really ugly. The same approach shouyld be used here.

    This way, the other structure fields (like .name) could also be overriden 
if needed...

WBR, Sergei
