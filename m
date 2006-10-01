Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 15:56:48 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:25666 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20037872AbWJAO4q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Oct 2006 15:56:46 +0100
Received: by py-out-1112.google.com with SMTP id i49so632812pyi
        for <linux-mips@linux-mips.org>; Sun, 01 Oct 2006 07:56:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=KdZkbVNHeCgPvv5DbAl32/JtnHYuOYATo8MVmZ4No6i1zjmmhJx7QG+PNprb6pwcUPsEBOsDs87+qagxqpn81Gn78tAWga0VVMyhQbaaqumdexuRtivwYCcl3n2AwAr0jlY13zLNSLcauLWFDF85Q8Vu0mIl/VHa+LRBLoKmjNo=
Received: by 10.65.237.1 with SMTP id o1mr5673869qbr;
        Sun, 01 Oct 2006 07:56:45 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id 38sm4599910nzf.2006.10.01.07.56.43;
        Sun, 01 Oct 2006 07:56:44 -0700 (PDT)
In-Reply-To: <20061001.235254.126142488.anemo@mba.ocn.ne.jp>
References: <B3C723F6-A2B3-4A0E-88BB-FF36AB58FFB4@gmail.com> <20060930.025956.108739154.anemo@mba.ocn.ne.jp> <8D501155-BC7A-471A-9374-9EB8D48BE307@gmail.com> <20061001.235254.126142488.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <105ACD1A-F259-46BE-BB1C-CE4075AF9290@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	girish <girishvg@gmail.com>
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-5)
Date:	Sun, 1 Oct 2006 23:57:03 +0900
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Mailer: Apple Mail (2.749)
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


On Oct 1, 2006, at 11:52 PM, Atsushi Nemoto wrote:

> On Sat, 30 Sep 2006 03:33:01 +0900, girish <girishvg@gmail.com> wrote:
>>> Looks good to me, except for page.h part.
>>
>> I agree, but as of now, I do not have any better solution. If & when
>> I will implement kernel page table for memory above 2000_0000, I plan
>> to give it a through mapping. That is to say, 4000_0000 physical
>> mapped to 4000_0000 virtual. In that case the page.h __pa/__va macros
>> stand a chance (^_^;)
>
> No.  4000_0000 physical is never mapped to 4000_0000 virtual.  The low
> 2GB of virtual address space are used for user mapping.

Can't I provide Kernel mapping via swapper_pg_dir to 4000_0000?


>
>> If somebody has already done kernel page table implementation, could
>> you please pass on the relevant patch? Thanks.
>
> If you have a 64-bit CPU, you can use a 64-bit kernel which gives you
> large XKPHYS area.  If not, and your CPU does not have D-cache
> aliasing, you can use CONFIG_HIGHMEM which are using kernel page table
> already.  Otherwise you are out of luck for now unfortunately.

We poor 32bit users!

I have, to some extent, already incorporated highmem (1GB) through  
HIGHMEM + SPARSEMEM combination.


> Anyway, you do not have to change __pa() and __va().
>
> ---
> Atsushi Nemoto
