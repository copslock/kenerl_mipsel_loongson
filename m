Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 00:25:55 +0000 (GMT)
Received: from 63-207-7-10.ded.pacbell.net ([IPv6:::ffff:63.207.7.10]:8950
	"EHLO cassini.enmediainc.com") by linux-mips.org with ESMTP
	id <S8225313AbVCQAZk>; Thu, 17 Mar 2005 00:25:40 +0000
Received: from [127.0.0.1] (unknown [192.168.10.203])
	by cassini.enmediainc.com (Postfix) with ESMTP
	id 9CDDD25C95F; Wed, 16 Mar 2005 16:25:34 -0800 (PST)
Message-ID: <4238CE11.8000506@c2micro.com>
Date:	Wed, 16 Mar 2005 16:23:45 -0800
From:	Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, lkml@vger.kernel.org
Subject: initrd/initramfs problem
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com> <20050316120647.GB8563@linux-mips.org>
In-Reply-To: <20050316120647.GB8563@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <martini@c2micro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martini@c2micro.com
Precedence: bulk
X-list: linux-mips

What fails is when CONFIG_BLK_DEV_INITRD and CONFIG_INITRAMFS_SOURCE are 
both set.  I realize (now) that I don't need initrd at all, and 
initramfs works fine by itself, as you have tested.  It seems that the 
kernel may need some exclusion between these two mechanisms while the 
difference is sorted out.

I'm not totally up on Kconfig files, but maybe something like this in 
drivers/block/Kconfig:

config INITRAMFS_SOURCE
        string "Initramfs source file(s)"
        default ""
        depends on BLK_DEV_INITRD=n

Regarding the documenation it would have been helpful to me if 
Documentation/initrd.txt had a reference to 
Documentation/early-userspace/README.  I'm not sure who maintains that 
directory, or I'd send a suggestion.  tldp.org?

THX
Ed Martini


Original context: 
http://www.linux-mips.org/archives/linux-mips/2005-03/index.html


Ralf Baechle wrote:

>On Tue, Mar 15, 2005 at 02:37:45PM -0800, Ed Martini wrote:
>
>  
>
>>Also, unless you move the location of .init.ramfs, it gets freed twice, 
>>leading to a panic.
>>    
>>
>
>Interesting one.  When I tested the code recently it did work for me and
>it shouldn't have changed since.  The way this is supposed to work is
>by setting the page_count to 1 by using set_page_count and unmarking the
>page as reserved, so after that point a free_page should actually succeed -
>even if done twice as you've observed, first in populate_rootfs then
>once more in free_initmem.
>
>It seems a frighteningly bad idea though since it relies on no memory
>from the initrd range being allocated between the two calls - or it would
>end being freed by force, in use or not.  On startup Linux tends to
>allocate memory starting from high address towards low addresses which
>must be why we usually get away with this one.
>
>  
>
>>From the documentation alone it's impossible to figure out how to build 
>>your initramfs.  In various places the docs refer to the initial 
>>executable as /linuxrc, /kinit, /init, and possibly others.  If you read 
>>init/main.c you see that for an initramfs, your initial process will be 
>>started from /init.
>>    
>>
>
>I guess I read the code so I didn't notice the lacking qualities of the
>documentation ...
>
>  Ralf
>  
>
