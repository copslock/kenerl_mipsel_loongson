Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 22:49:57 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:31898 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20024076AbXLKWtt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 22:49:49 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 4999D3112C8;
	Tue, 11 Dec 2007 22:49:52 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 11 Dec 2007 22:49:50 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 11 Dec 2007 14:49:22 -0800
Message-ID: <475F13F1.2050109@avtrex.com>
Date:	Tue, 11 Dec 2007 14:49:21 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc2 crash in kmap_coherent
References: <20071211221327.GB2150@paradigm.rfc822.org>
In-Reply-To: <20071211221327.GB2150@paradigm.rfc822.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2007 22:49:22.0097 (UTC) FILETIME=[12371210:01C83C48]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> Hi,
> i just discovered that my native gcc build on one of my Indys stopped. I
> found this in the dmesg ;)
> 
> Its a 2.6.24-rc2 on an R5k Indy 64M:
> 
> Kernel bug detected[#1]:
> Cpu 0
> $ 0   : 0000000000000000 ffffffff9000cce0 0000000000000001 ffffffff80000000
> $ 4   : ffffffff8921f910 000000007fda0f05 000000007fda0f05 ffffffff8b8ea000
> $ 8   : ffffffff89b4ef05 000000000000000e ffffffff8921f910 0000000000000f05
> $12   : 0000000000000000 ffffffff80000008 ffffffff88090010 00000000004038b4
> $16   : ffffffff8921f910 000000007fda0f05 ffffffff8b8ea000 000000000000000e
> $20   : ffffffff8bdfb920 0000000000000000 ffffffff8bd88cc0 ffffffff8893fd58
> $24   : 0000000000000006 ffffffff8801df00                                  
> $28   : ffffffff8893c000 ffffffff8893fd20 ffffffff88430000 ffffffff8801c010
> Hi    : 000000000001d1ea
> Lo    : 0000000000009b4e
> epc   : ffffffff8801bcf0 kmap_coherent+0x10/0x130     Not tainted
> ra    : ffffffff8801c010 copy_from_user_page+0x40/0xb0
> Status: 9000cce3    KX SX UX KERNEL EXL IE 
> Cause : 00000034
> PrId  : 00002321 (R5000)
> Modules linked in: dm_snapshot dm_mirror dm_mod ipv6
> Process cat (pid: 14553, threadinfo=ffffffff8893c000, task=ffffffff88a52660)
> Stack : 000000000000000e 000000007fda0f05 ffffffff8b8ea000 0000000000000000
>         ffffffff88079d10 ffffffff88079cc4 ffffffff8bfbd528 ffffffff8921f910
>         ffffffff8bdfb980 ffffffff8b8ea000 ffffffff8bdfb920 0000000000000000
>         ffffffff8b8ea000 000000000000000e ffffffff8bd88cc0 ffffffff8893fe78
>         0000000000447000 000000000052c7d8 0000000000000000 ffffffff880d9014
>         ffffffff8bd88cc0 ffffffff8b8ea000 fffffffffffffff4 ffffffff8b863248
>         0000000000000400 ffffffff8893fe78 0000000000447000 ffffffff880db188
>         ffffffff8be6f6e0 0000000000000400 0000000000447000 ffffffff8893fe78
>         0000000000447000 0000000000000003 0000000000000016 ffffffff8808fbdc
>         ffffffff8be6f6e0 0000000000000400 0000000000447000 fffffffffffffff7
>         ...
> Call Trace:
> [<ffffffff8801bcf0>] kmap_coherent+0x10/0x130
> [<ffffffff8801c010>] copy_from_user_page+0x40/0xb0
> [<ffffffff88079d10>] access_process_vm+0x168/0x1d8
> [<ffffffff880d9014>] proc_pid_cmdline+0xac/0x140
> [<ffffffff880db188>] proc_info_read+0x108/0x150
> [<ffffffff8808fbdc>] vfs_read+0xec/0x178
> [<ffffffff88090060>] sys_read+0x50/0x98
> [<ffffffff88019718>] handle_sys+0x118/0x134
> 
> 
> Code: 0002127a  00021000  30420001 <00028036> 8f820024  3c038843  24420001  af820024  dc62f390 
>

FWIW I get something very similar reading /proc/1/cmdline on 
2.6.23-1/ip32 w/ R5000 and there have been other similar postings here 
recently.

Maybe one day I will look into it, but it probably will not be real soon...

David Daney
