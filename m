Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Feb 2005 01:02:15 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:29445 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225267AbVBFBCA>; Sun, 6 Feb 2005 01:02:00 +0000
Received: from [192.168.2.27] (h69-21-252-132.69-21.unk.tds.net [69.21.252.132])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j160gU4s014347;
	Sat, 5 Feb 2005 19:42:30 -0500
In-Reply-To: <20050205203333.CD4DBC108D@atlas.denx.de>
References: <20050205203333.CD4DBC108D@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <efcfca49cf2c4494a661ba916f2e1546@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Robert Michel <news@robertmichel.de>
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: patch like kexec for MIPS possible? 
Date:	Sat, 5 Feb 2005 20:01:46 -0500
To:	Wolfgang Denk <wd@denx.de>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Feb 5, 2005, at 3:33 PM, Wolfgang Denk wrote:

> .....   but  I cannot see many situations where
> kexec is actually better or more powerful than  a  decent  bootloader
> line U-Boot. OK, I'm obviously biased.

I agree.  I've played with booting kernels from kernels
in both PowerPC and MIPS in the past, and the problem
I always run into is drivers or kernel functions that assume
a particular power up state.  When rebooting from another
kernel you don't have the same state as from power up, and
some software doesn't like this.   I suspect main reason for
kexec is the horrible x86 bios and nothing that can be done
about it.

Oh, and I agree with your assessment, not that you are biased :-)


	-- Dan
