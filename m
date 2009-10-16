Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Oct 2009 01:51:06 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:11372 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493000AbZJPXu7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Oct 2009 01:50:59 +0200
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad906440000>; Fri, 16 Oct 2009 19:48:25 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Oct 2009 19:50:50 -0400
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Oct 2009 16:50:49 -0700
Message-ID: <4AD906D8.3020404@caviumnetworks.com>
Date:	Fri, 16 Oct 2009 16:50:48 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	myuboot@fastmail.fm
CC:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: 2.6.31 kernel for mips compile failure - war.h:12:17: error:
 war.h: No such file or directory
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
In-Reply-To: <1255735395.30097.1340523469@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2009 23:50:49.0062 (UTC) FILETIME=[7CA68860:01CA4EBB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

mips-linux questions will get more attention if you send them to 
linux-mips@linux-mips.org.


myuboot@fastmail.fm wrote:
> I am trying to use buildroot 2009.08 to compile kernel 2.6.31 for mips,
> but it fails to error -" war.h can't be found". I used the same
> buildroot to build kernel version 2.6.29 with no problem. 
> 
> Please give me some suggestion on how to fix this issue. The file 
> ./arch/mips/include/asm/war.h is there with no problem. Thanks a lot.
> 
[...]
>   CC      arch/mips/kernel/asm-offsets.s
> In file included from
> /home/root123/sources/buildroot-2009.08-k/project_build_mips/f1/linux-2.6.31/arch/mips/include/asm/bitops.h:24,
>                  from include/linux/bitops.h:17,
>                  from include/linux/kernel.h:15,
>                  from include/linux/sched.h:52,
>                  from arch/mips/kernel/asm-offsets.c:13:

What does your .config look like?

Also try make V=1 so we can see the exact compiler command line that the 
build process is generating.

David Daney
