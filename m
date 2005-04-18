Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 15:45:58 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:65041 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225472AbVDROpm>; Mon, 18 Apr 2005 15:45:42 +0100
Received: from [192.168.87.101] (pool-141-154-240-184.bos.east.verizon.net [141.154.240.184])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j3IEf4fg024008;
	Mon, 18 Apr 2005 10:41:04 -0400
In-Reply-To: <200504181137.49593.eckhardt@satorlaser.com>
References: <200504181137.49593.eckhardt@satorlaser.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca4c0616e67fe48cc66f3116afa1a5bc@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
From:	Dan malek <danm@embeddededge.com>
Subject: Re: [patch] some cleanups for Alchemy processors
Date:	Mon, 18 Apr 2005 10:45:33 -0400
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <danm@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danm@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Apr 18, 2005, at 5:37 AM, Ulrich Eckhardt wrote:

> -void static inline au_writeb(u8 val, int reg)
> +void static inline au_writeb(u8 val, unsigned long port)
>  {
> -	*(volatile u8 *)(reg) = val;
> +	*(volatile u8 *)(port) = val;

Technically, these are registers, not "ports", so please
don't change their name.  They are memory mapped
registers, as their name implies.

Thanks.


	-- Dan
