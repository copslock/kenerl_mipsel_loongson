Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 00:34:52 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:27696 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21423379AbYJMXeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Oct 2008 00:34:50 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48f3dafd0000>; Mon, 13 Oct 2008 19:34:21 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Oct 2008 16:34:18 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Oct 2008 16:34:18 -0700
Message-ID: <48F3DAF9.5000603@caviumnetworks.com>
Date:	Mon, 13 Oct 2008 16:34:17 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Johannes Dickgreber <tanzy@gmx.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] show_cpuinfo prints the name of the calling CPU,
 which i think is wrong.
References: <1223919381-24521-1-git-send-email-tanzy@gmx.de> <20081013222146.GD8145@linux-mips.org>
In-Reply-To: <20081013222146.GD8145@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2008 23:34:18.0197 (UTC) FILETIME=[36088850:01C92D8C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 13, 2008 at 07:36:21PM +0200, Johannes Dickgreber wrote:
> 
>> Cc: linux-mips@linux-mips.org
>> Subject: [PATCH 2/2] show_cpuinfo prints the name of the calling CPU, which i
>> 	think is wrong.
> 
> Patch is correct and so I applied it.  Not a big issue though.  There is
> only one system supported currently that supports a mix of different
> processor types (IP27) and those are very similar so it doesn't cause
> pain.
> 
>   Ralf

The patch is required on SMP systems as without it you get:

BUG: using smp_processor_id() in preemptible [00000000] code: cat/687
caller is show_cpuinfo+0xc4/0x500
Call Trace:
[<ffffffff8111f4c8>] dump_stack+0x8/0x38
[<ffffffff812c235c>] debug_smp_processor_id+0xec/0x100
[<ffffffff8112de64>] show_cpuinfo+0xc4/0x500
[<ffffffff811d4128>] seq_read+0x2f8/0x420
[<ffffffff811fb658>] proc_reg_read+0x90/0xd8
[<ffffffff811b05ec>] vfs_read+0xbc/0x160
[<ffffffff811b0a88>] sys_read+0x50/0x98
[<ffffffff81129224>] handle_sysn32+0x44/0x84


David Daney
