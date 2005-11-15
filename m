Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 21:35:39 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:34078
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133603AbVKOVfW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Nov 2005 21:35:22 +0000
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 15 Nov 2005 13:37:21 -0800
Message-ID: <437A5511.8020806@avtrex.com>
Date:	Tue, 15 Nov 2005 13:37:21 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jonathan Day <imipak@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Another problem with compiling Linux kernel
References: <20051115213005.79456.qmail@web31513.mail.mud.yahoo.com>
In-Reply-To: <20051115213005.79456.qmail@web31513.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 21:37:21.0922 (UTC) FILETIME=[C2E5AE20:01C5EA2C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> Hi again,
> 
> Using GCC 4.0.0 on the Broadcom SB1 MIPS64 board, the
> compilation crashes at the final link phase with the
> following errors:
> 
.
.
> `.exit.text' referenced in section `.pdr.20' of
> net/built-in.o: defined in discarded section
> `.exit.text' of net/built-in.o
> 

I know nothing about this one.

> My first thought was "ah, might be because I'm using
> an old GCC, so I'll try something more recent and see
> what happens". When trying GCC 4.1.0 (snapshot from
> 20051017), I get the following error:
> 
> In file included from include/linux/nfs_fs.h:15,
>                  from init/do_mounts.c:12:
> include/linux/pagemap.h: In function
> 'fault_in_pages_readable':
> include/linux/pagemap.h:237: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:237: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:237: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:237: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:243: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:243: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:243: error: read-only variable
> '__gu_val' used as 'asm' output
> include/linux/pagemap.h:243: error: read-only variable
> '__gu_val' used as 'asm' output
> make[1]: *** [init/do_mounts.o] Error 1
> make: *** [init] Error 2
> 
> This one may be a compiler bug (experimental GCCs are,
> well, experimental!) but it makes it somewhat harder
> to know if the later issue is resolved by using a
> different toolchain.
> 

This is not a GCC bug, but a change in GCC behavior.  One patch was 
posted here:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.61.0511022057140.3511%40trantor.stuart.netsweng.com

I don't know if the change made it into the linux-mips git repository or 
not.
