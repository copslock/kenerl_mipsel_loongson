Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 20:40:09 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:56333 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225988AbVEZTjy>; Thu, 26 May 2005 20:39:54 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j4QJVA8U001728;
	Thu, 26 May 2005 15:31:11 -0400
In-Reply-To: <200505261520.34985.haukeh@pc-kiel.de>
References: <200505261520.34985.haukeh@pc-kiel.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <530c77f53c1c8706d6fd75a07ad091ca@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: CCA4 mapping
Date:	Thu, 26 May 2005 15:39:49 -0400
To:	Hauke Goos-Habermann <haukeh@pc-kiel.de>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On May 26, 2005, at 9:20 AM, Hauke Goos-Habermann wrote:

> Does anybody have an idea how to make the CCA4 mapping?

In the mmap() entry for the driver:

	pgprot_val(vma->vm_page_prot) |= (4 << 9);	/* CCA4 */

or, whatever is appropriate.  This will only work from a user
application (like X-Windows) that mmaps() the driver, you
aren't going to get a kernel mapped space this way without
some special VM space hacking.

Thanks.

	-- Dan
