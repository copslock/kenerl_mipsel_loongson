Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 16:39:34 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:45494 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039489AbWJWPj0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 16:39:26 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 39ACD3ECA; Mon, 23 Oct 2006 08:39:23 -0700 (PDT)
Message-ID: <453CE22A.5090700@ru.mvista.com>
Date:	Mon, 23 Oct 2006 19:39:22 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>	<453CD3ED.8020005@ru.mvista.com> <20061024.003845.71086839.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061024.003845.71086839.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>* mips_hpt_mask variable to specify bitmask of hpt value.

>>    There's actually no need to introduce more variables. Just make
>>clocksource declaration public and override default mask if
>>necessary.
>>    Also, I don't see much sense in further existence of
>>mips_hpt_read() -- it only causes each clocksource read go thru a
>>double indirection which is really ugly. The same approach shouyld
>>be used here.

> I agree with you that it would be a way to go.  For now exporting
> clocksource_mips just to override the mask and keep using
> mips_hpt_read looks somewhat inconsistent, so I just added
> mips_hpt_mask variable.

> Replacing mips_hpt_read involves changes for _all_ platform code so I

    Only 3 files in the current arch/mips/ actually, excluding time.c and the 
header file (to make it visible).

> think it would be better to do it on next -rc1 stage.

    AKA never. ;-)

WBR, Sergei
