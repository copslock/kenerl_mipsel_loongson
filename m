Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 21:39:13 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51148
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492696AbZK3UjI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 21:39:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id A5FDD24C6E4;
        Mon, 30 Nov 2009 12:39:01 -0800 (PST)
Date:   Mon, 30 Nov 2009 12:39:01 -0800 (PST)
Message-Id: <20091130.123901.09751811.davem@davemloft.net>
To:     ralf@linux-mips.org
Cc:     acme@infradead.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] MIPS: Wire up recvmmsg syscall
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20091130200319.GA26639@linux-mips.org>
References: <1259610615-23996-1-git-send-email-acme@infradead.org>
        <20091130200319.GA26639@linux-mips.org>
X-Mailer: Mew version 6.2 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>
Date: Mon, 30 Nov 2009 20:03:19 +0000

> On Mon, Nov 30, 2009 at 05:50:15PM -0200, Arnaldo Carvalho de Melo wrote:
> 
>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> 
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> ---
>>  arch/mips/include/asm/unistd.h |   15 +++++++++------
>>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> Looks good.  Dave, wanna merge this through the netdev tree?
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Sure, I'll take it there.
