Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 17:41:50 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:4907 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492879AbZFQPlo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 17:41:44 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a390e610000>; Wed, 17 Jun 2009 11:40:18 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Jun 2009 08:39:57 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Jun 2009 08:39:57 -0700
Message-ID: <4A390E47.1010801@caviumnetworks.com>
Date:	Wed, 17 Jun 2009 08:39:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] -git compile fixes for MIPS
References: <4A38A173.9010508@gmail.com>
In-Reply-To: <4A38A173.9010508@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2009 15:39:57.0723 (UTC) FILETIME=[DE4D16B0:01C9EF61]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> 
> Quick fixes for some compile failures which have cropped up
> in linus-git in the last 24 hours:
> 
>   CC      arch/mips/kernel/time.o
> In file included from linux-2.6.git/include/linux/bug.h:4,
>                  from linux-2.6.git/arch/mips/kernel/time.c:13:
> linux-2.6.git/arch/mips/include/asm/bug.h:10: error: expected '=', ',', 
> ';', 'asm' or '__attribute__' before 'BUG'
> linux-2.6.git/arch/mips/include/asm/bug.h: In function '__BUG_ON':
> linux-2.6.git/arch/mips/include/asm/bug.h:26: error: implicit 
> declaration of function 'BUG'
> 
>   CC      arch/mips/mm/uasm.o
> In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
> linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
> linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit 
> declaration of function 'smp_processor_id'
> linux-2.6.git/arch/mips/mm/uasm.c: In function 'uasm_copy_handler':
> linux-2.6.git/arch/mips/mm/uasm.c:514: error: implicit declaration of 
> function 'memcpy'
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>  arch/mips/include/asm/bug.h  |    2 +-
>  arch/mips/include/asm/bugs.h |    1 +
>  arch/mips/mm/uasm.c          |    1 +
>  3 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 08ea468..92b372a 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -7,7 +7,7 @@
> 
>  #include <asm/break.h>
> 
> -static inline void __noreturn BUG(void)
> +static inline void __attribute__((noreturn)) BUG(void)

That isn't correct.

__noreturn is defined in linux/compiler.h  You should figure out why 
that definition is not being used.

David Daney
