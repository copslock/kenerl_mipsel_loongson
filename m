Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 15:35:07 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.236]:30985 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133827AbWGZOe4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Jul 2006 15:34:56 +0100
Received: by wr-out-0506.google.com with SMTP id 57so1210441wri
        for <linux-mips@linux-mips.org>; Wed, 26 Jul 2006 07:34:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=hWi7aFC9MYxORGScfzIM8uh5NzBQ2mYilZ9WABbhQoz26R1Yyw1y/xlRDD5STlKHBS26aeUY89v7zPrzU6oPZAblGtSZCx6nhuiqsGJCBfZWJ63gewtAPGF9N1GhXyC5T8tmPxiaAFz+v2qMny8sChwX/85crqJUyW5fYOct4Ak=
Received: by 10.54.105.15 with SMTP id d15mr6646545wrc;
        Wed, 26 Jul 2006 07:34:52 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 29sm3839960wrl.2006.07.26.07.34.50;
        Wed, 26 Jul 2006 07:34:52 -0700 (PDT)
Message-ID: <44C77D49.90205@innova-card.com>
Date:	Wed, 26 Jul 2006 16:33:45 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
References: <cda58cb80607100434h13831eb7rc6eda13a0d9e373f@mail.gmail.com>	<20060710.233454.39153668.anemo@mba.ocn.ne.jp>	<44B3625B.7000700@innova-card.com> <20060711.222458.74752678.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060711.222458.74752678.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

Sorry for the delay...

Atsushi Nemoto wrote:
> On Tue, 11 Jul 2006 10:33:31 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> We can, but we can get more precise value using page_is_ram().  The
>>> pfn_valid() returns true for _all_ pages on present section, and
>>> currently the section size is 256MB.
>> so your total pages of RAM in show_mem() is incorrect...
>>
>>                if (!pfn_valid(pfn))
>>                         continue;
>>                 page = pfn_to_page(pfn);
>>                 total++;
>>
>>
>> I don't know SPARSEMEM a lot but is it allowed to have holes inside
>> a section ? Shouldn't we tune the section size to avoid holes inside
>> section ?
> 
> If holes exist in a section, show_mem() will count these pages as
> "reserved".  You can count real pages by "total - reserved".
> 

I don't think that's correct to mark them as "reserved". Basicaly
"reserved" means that it belongs to the kernel (code or data), these
holes are not and we will end up to have wrong value as you pointed
out.

Having quick look at sparsemem code, I don't think that it expects
to have holes inside a section, do it ? If so you probably have to
fix up your section size...

> Talking about nr_kernel_pages (calculated by zones_size[] and
> zones_holes[]) and num_physpages, these values are used to determine
> sizes of some kernel data structures, it would be better to set more
> precise value for them.
> 
> While large holes in a section wastes some memory, make the section
> size customizable might be a good idea.  Anyone?  ;-)
> 

hey, you are working in this area, aren't you ? ;)

		Franck
