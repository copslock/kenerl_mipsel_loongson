Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 17:45:14 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:60976 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492963AbZJIPpH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Oct 2009 17:45:07 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1D94F3EC9; Fri,  9 Oct 2009 08:45:04 -0700 (PDT)
Message-ID: <4ACF5B37.2040907@ru.mvista.com>
Date:	Fri, 09 Oct 2009 19:48:07 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com> <20091008144230.GA682@linux-mips.org> <1255016760.14496.57.camel@falcon> <20091008185012.GA10365@linux-mips.org> <4ACF5A10.3020406@ru.mvista.com>
In-Reply-To: <4ACF5A10.3020406@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>> Are the non-memory parts marked as reserved?

>>> No, so, is that a need to mark them?

>> Initially all pages are marked as reserved.

>> Which seems to be good enough for x86:

>> $ cat /proc/iomem
>> 00000000-0009efff : System RAM
>> 0009f000-0009ffff : reserved
>> 000c0000-000cffff : pnp 00:0d
>> 000e0000-000fffff : pnp 00:0d
>> 00100000-7fe5b7ff : System RAM
>> [...]

>> The 0x9f000 - 0x9ffff range is the good old ISA I/O memory range (classic
>> MDA/CGA/VGA etc.), that is non-memory yet:
> 
> 
>    Not really, it's a usual RAM. CGA/VGA video memory occupies 

    Oh, I meant EGA/VGA. CGA memory is at 000b8000-000bffff, of course.

> 000a0000-000bffff and MDA occupies 000b0000-000b7ffff (if not less).
> This range is probably reserved by BIOS for something like EBDA...

    Which stands for Extended BIOS Data Area.

WBR, Sergei
