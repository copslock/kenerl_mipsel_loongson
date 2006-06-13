Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 08:01:27 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.237]:46358 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133358AbWFMHBS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jun 2006 08:01:18 +0100
Received: by wr-out-0506.google.com with SMTP id 58so98125wri
        for <linux-mips@linux-mips.org>; Tue, 13 Jun 2006 00:01:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNw7ePyI5xkl+26DOs3xOsiejZCJUGamoWbHj4kZfubo2p9tipcz58num23TIk9lvIH7ZBEPS15RYXEb7D2U429Fz+NT/LrOyDUexI0B/B51YJQ3DiiX5ZcXzlWY3KjCBV+m3zlQyiFEYw49HNceV1Vf2xJsmAdhzYFoxmSzAfM=
Received: by 10.54.124.15 with SMTP id w15mr520446wrc;
        Tue, 13 Jun 2006 00:01:17 -0700 (PDT)
Received: by 10.54.156.16 with HTTP; Tue, 13 Jun 2006 00:01:17 -0700 (PDT)
Message-ID: <cda58cb80606130001u66e96ba4vfd0324a48a0bbd44@mail.gmail.com>
Date:	Tue, 13 Jun 2006 09:01:17 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Chad Reese" <kreese@caviumnetworks.com>
Subject: Re: Any examples / docs for getting SPARSEMEM to work?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <446CB5D8.107@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <446CB5D8.107@caviumnetworks.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

2006/5/18, Chad Reese <kreese@caviumnetworks.com>:
> Hello All,
>
> I've spent the last few days trying to get SPARSEMEM to work on a 64bit Mips
> kernel. The processor I'm using has large wholes in its memory map.
>
> Memory layout:
> 0 - 0x10000000                  First 256MB
> 0x410000000 - 0x420000000       Second 256MB

Sorry for the delay, I didn't notice your post before...

Just out of curiosity, what value for PAGE_OFFSET do you use ? In
other word how do you convert a physical address into a virtual one if
you use these two memories ?

Could you show us the virtual address ranges for each memories ?

> 0x20000000 - ?                  The rest of memory
>
> Up until now I've used the flat memory model and not mapped the 2nd 256MB. This
> is rather wasteful for boards with 512MB of memory. SPARSEMEM look like what I
> need, but I've been unable to get it working. My attempts to configure it always
> end with sparse_index_alloc calling alloc_bootmem_node which fails to allocate
> 4KB. In prom_init I've added memory using add_memory_region.
>
> Are there any reasonably easy to follow implementations of sparsemem? I figure
> I'm missing something very basic, but perusal of Mips and the other
> architectures haven't helped much.
>
> My baseline is linux-mips 2.6.14.
>
> Any help would be appreciated,
>
> Chad
>

-- 
               Franck
