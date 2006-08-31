Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 16:12:12 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.225]:9877 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037510AbWHaPMK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 Aug 2006 16:12:10 +0100
Received: by wx-out-0506.google.com with SMTP id h30so732043wxd
        for <linux-mips@linux-mips.org>; Thu, 31 Aug 2006 08:12:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PZ5o7ne9uOcVn7/pfSr9EGVzkTcolfdltuftPbzX/h1hJCiVgGxxqwE4+vXcQvDw3kYyFBeJboVjSkSNBg7W4EJCxXd357/scQSpQ31tC6oYpSareS2hQ7tiLhUNIRGWTdjXoRcvM+yHXJqahNyr39pLRHhvq9uQouqLTfut10c=
Received: by 10.70.84.6 with SMTP id h6mr704077wxb;
        Thu, 31 Aug 2006 08:12:05 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id i10sm1052542wxd.2006.08.31.08.12.03;
        Thu, 31 Aug 2006 08:12:04 -0700 (PDT)
Message-ID: <44F6FC42.6010701@gmail.com>
Date:	Thu, 31 Aug 2006 11:12:02 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 64K page size
References: <44EC7125.7000000@gmail.com> <20060829135055.GB29289@linux-mips.org>
In-Reply-To: <20060829135055.GB29289@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>The code in pgtable-64.h assumes TASK_SIZE is always bigger than a first 
>>level PGDIR_SIZE. This is not the case for 64K pages, where task size is 
>>40 bits (1TB) and a pgd entry can map 42 bits. This leads to 
>>USER_PTRS_PER_PGD being zero for 64K pages.
> 
> Do you actually need large address space?  The kernel could allow 2, 3 and
> 4-level pagetables easily but doesn't give that choice currently.
> 

Yes, in some cases. I'd like to benchmark the performance difference 
between 2 and 3 level pagetables, so the choice is valuable.
