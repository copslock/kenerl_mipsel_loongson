Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 03:31:03 +0100 (BST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:49947 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133936AbWGZCax (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Jul 2006 03:30:53 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with NetIQ MailMarshal (v6,0,3,8)
	id <B44c6d3ce0000>; Tue, 25 Jul 2006 22:30:38 -0400
Received: from [192.168.16.29] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Jul 2006 19:30:46 -0700
Message-ID: <44C6D3D5.9080409@caviumnetworks.com>
Date:	Tue, 25 Jul 2006 19:30:45 -0700
From:	Chad Reese <creese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20060629 Debian/1.7.8-1sarge7.1
X-Accept-Language: en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: 64bit kernel/N32 userspace - shmctl corrupts userspace memory
References: <44C6B829.8050508@caviumnetworks.com> <20060726020427.GA21024@linux-mips.org>
In-Reply-To: <20060726020427.GA21024@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jul 2006 02:30:46.0189 (UTC) FILETIME=[7FF4A5D0:01C6B05B]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

compat.c is only included if CONFIG_SYSVIPC_COMPAT is defined. This
isn't anywhere in 2.6.16.26. Is this what you're refering to?

Chad

Ralf Baechle wrote:
> On Tue, Jul 25, 2006 at 05:32:41PM -0700, Chad Reese wrote:
> 
> 
>>If you're running a 64bit kernel with N32 userspace, shmctl will corrupt
>>memory in userspace. When copy_shmid_to_user() is called, it copies the
>>entire kernel shmid_ds into userspace. For a 64bit kernel, this is 88
>>bytes. In N32 userspace it is 76 bytes.
>>
>>My hack to get around the problem is attached, but I expect someone here
>>will be able to come up with a better fix. shmid_ds contains a lot of
>>members that are marked unused. Are these really useless?
> 
> 
> Can you try below patch?
> 
>   Ralf
> 
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index 98abbc5..605d393 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -150,7 +150,7 @@ EXPORT(sysn32_call_table)
>  	PTR	sys_madvise
>  	PTR	sys_shmget
>  	PTR	sys32_shmat
> -	PTR	sys_shmctl			/* 6030 */
> +	PTR	compat_sys_shmctl		/* 6030 */
>  	PTR	sys_dup
>  	PTR	sys_dup2
>  	PTR	sys_pause
> 

-- 

Chad Reese <kreese@caviumnetworks.com>
Cavium Networks
Phone: 650 - 623 - 7038
Cell: 321 - 438 - 7753
