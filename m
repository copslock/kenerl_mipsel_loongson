Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:16:23 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20040407AbXAJQQU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:16:20 +0000
Received: from wr-out-0506.google.com ([64.233.184.239]:6637 "EHLO
	wr-out-0506.google.com") by lappi.linux-mips.net with ESMTP
	id S134689AbXAIU4L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jan 2007 21:56:11 +0100
Received: by wr-out-0506.google.com with SMTP id i7so78438wra
        for <linux-mips@linux-mips.org>; Tue, 09 Jan 2007 12:56:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GnrTf7ihSZXAQ09z/tyuJE5RePZetQpvqGLNFPSxh0t1znaSkg2V8VXnYwONkrJeLoLQeu6axFDt5nxHISojPV1HkOwImtkZ57vYg5oH5AnIWUeNQp6hrLwteLt1U2NFdJ11UL6y4CeC1ndmQf4YRUKRbINLaTT36zlFdPwqs1U=
Received: by 10.90.98.10 with SMTP id v10mr3367575agb.1168376170389;
        Tue, 09 Jan 2007 12:56:10 -0800 (PST)
Received: by 10.90.104.20 with HTTP; Tue, 9 Jan 2007 12:56:10 -0800 (PST)
Message-ID: <cda58cb80701091256i2e03c248ve36d45c57bf55fff@mail.gmail.com>
Date:	Tue, 9 Jan 2007 21:56:10 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] Setup min_low_pfn/max_low_pfn correctly
Cc:	linux-mips@linux-mips.org, "Franck Bui-Huu" <fbuihuu@gmail.com>
In-Reply-To: <20070108222422.GA28495@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11682782923799-git-send-email-fbuihuu@gmail.com>
	 <11682782922887-git-send-email-fbuihuu@gmail.com>
	 <20070108222422.GA28495@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

-- On 1/8/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jan 08, 2007 at 06:44:51PM +0100, Franck Bui-Huu wrote:
>
> > This patch makes a better usage of these two globals.
> > 'min_low_pfn' is now correctly setup for all configs, which
> > allow us to rely on it in boot memory code init.
>

[snip]

> Call Trace:
> [<80109484>] dump_stack+0x8/0x34
> [<80159fbc>] bad_page+0x68/0xa8
> [<8015a804>] free_hot_cold_page+0x3a4/0x3b4
> [<80414150>] free_all_bootmem_core+0x150/0x258
> [<8040aefc>] mem_init+0x40/0x1c0
> [<80400940>] start_kernel+0x2b4/0x3c8
>

[snip]

> From a working kernel:
>
> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 000ef000 @ 00001000 (ROM data)
>  memory: 0035a000 @ 000f0000 (reserved)
>  memory: 03bb6000 @ 0044a000 (usable)
>
> So it's basically 64MB starting at physical 0.
>
> Oh and Malta does not use CONFIG_HIGHMEM.
>

Yeah I just noticed that, Malta supports highmem but actually doesn't
use it.

Regarding to your mapping, usable ram starts at 0x44a000. So
min_low_pfn is now set to the corresponding pfn and the bootmem alloc
assumes it's the begining of your memory. This is done by
bootmem_init():

	bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
                                        min_low_pfn, max_low_pfn);

However, old code always assumed that the begining of the memory was
0. That was done by:

	bootmap_size = init_bootmem(mapstart, highest);

After a while paging_init() is called which in turn calls:

	free_area_init(zones_size);

which expands to:

	free_area_init_node(0, NODE_DATA(0), zones_size,
		__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);

In your case "__pa(PAGE_OFFSET) >> PAGE_SHIFT" results in 0 since you
haven't applied patch #2 and setup PHYS_OFFSET. So now, we're assuming
that the start of physical mem is 0 and I think it's wrong since we
previously assumed a different value.

Could you try to apply patch #2 on top of patch #1 and give it a try ?
I expect your kernel to panic in a different way. This time you should
be shooted by the following sanity check added by patch #2:

	if (min_low_pfn != ARCH_PFN_OFFSET)
		panic("PHYS_OFFSET(%lx) and your mem start(%lx) don't match",
		      PHYS_OFFSET, PFN_PHYS(min_low_pfn));

If so, could you give another try with PHYS_OFFSET defined as follow:

	#define PHYS_OFFSET	0x44a000

BTW mem_map[] size should be 32Kb smaller.

thanks,

               Franck
