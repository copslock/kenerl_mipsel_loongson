Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 17:27:14 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:37892 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225305AbULHR1K>; Wed, 8 Dec 2004 17:27:10 +0000
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id iB8HDv9f014848;
	Wed, 8 Dec 2004 12:13:58 -0500
In-Reply-To: <20041208194014.1302df6f.toch@dfpost.ru>
References: <20041208194014.1302df6f.toch@dfpost.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5FE01AB3-493E-11D9-81C3-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: mmap problem another :)
Date: Wed, 8 Dec 2004 12:27:02 -0500
To: Dmitriy Tochansky <toch@dfpost.ru>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Dec 8, 2004, at 11:40 AM, Dmitriy Tochansky wrote:

>   ret = remap_page_range_high (start, offset, size, vma->vm_page_prot);

Hmmm....this is in 2.4?  Did you apply all of the 36-bit IO
patch as Pete Popov has mentioned in past e-mail messages?
Did you make sure you enabled CONFIG_64BIT_PHYS_ADDR?

I know this does work.  In fact, you should just use
io_remap_page_range().  If that doesn't work, something
is wrong with the kernel configuration.

	-- Dan
