Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 18:21:15 +0000 (GMT)
Received: from pimout3-ext.prodigy.net ([IPv6:::ffff:207.115.63.102]:7333 "EHLO
	pimout3-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225322AbULHSVK>; Wed, 8 Dec 2004 18:21:10 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iB8IL8mt305162
	for <linux-mips@linux-mips.org>; Wed, 8 Dec 2004 13:21:08 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Wed, 8 Dec 2004 10:22:59 -0800
Message-ID: <41B745F6.7010502@embeddedalley.com>
Date: Wed, 08 Dec 2004 10:20:38 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
CC: Dmitriy Tochansky <toch@dfpost.ru>, linux-mips@linux-mips.org
Subject: Re: mmap problem another :)
References: <20041208194014.1302df6f.toch@dfpost.ru> <5FE01AB3-493E-11D9-81C3-003065F9B7DC@embeddededge.com>
In-Reply-To: <5FE01AB3-493E-11D9-81C3-003065F9B7DC@embeddededge.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:
> 
> On Dec 8, 2004, at 11:40 AM, Dmitriy Tochansky wrote:
> 
>>   ret = remap_page_range_high (start, offset, size, vma->vm_page_prot);
> 
> 
> Hmmm....this is in 2.4?  Did you apply all of the 36-bit IO
> patch as Pete Popov has mentioned in past e-mail messages?

The 36 bit patch is integrated in 2.4, and now in 2.6. The above 
code looks like 2.4.

Pete

> Did you make sure you enabled CONFIG_64BIT_PHYS_ADDR?
> 
> I know this does work.  In fact, you should just use
> io_remap_page_range().  If that doesn't work, something
> is wrong with the kernel configuration.
> 
>     -- Dan
> 
> 
> 
