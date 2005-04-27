Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2005 20:06:31 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:41220 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225367AbVD0TGQ>; Wed, 27 Apr 2005 20:06:16 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j3RJ0Lfg002290;
	Wed, 27 Apr 2005 15:00:21 -0400
In-Reply-To: <1114627785.17008.21.camel@SillyPuddy.localdomain>
References: <1114505009.11315.37.camel@mini.intra> <1114627785.17008.21.camel@SillyPuddy.localdomain>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4bf8c757c3a4d32177ab90b92eace823@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org, Pete Popov <ppopov@embeddedalley.com>,
	Herbert Valerio Riedel <hvr@hvrlab.org>
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: iptables/vmalloc issues on alchemy
Date:	Wed, 27 Apr 2005 15:06:00 -0400
To:	Josh Green <jgreen@users.sourceforge.net>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Apr 27, 2005, at 2:49 PM, Josh Green wrote:

> ...... I was
> planning on doing some additional gdb debugging of the failure
> (especially the initial large MMAP attempt by iptables, which was 1.5GB
> in my case).

Oh wait ....  I found a bug a while ago from someone trying to load
large modules.  There is a problem if the kernel grows to need
additional PTE tables, the top level pointers don't get propagated
correctly and subsequent access by a thread that didn't actually
do the allocation would fail.  I'm looking into this, including your
past message about 64-bit PTEs.

Thanks.


	-- Dan
