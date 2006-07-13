Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 20:49:06 +0100 (BST)
Received: from p549F7879.dip.t-dialin.net ([84.159.120.121]:21455 "EHLO
	p549F7879.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133433AbWGMTsb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Jul 2006 20:48:31 +0100
Received: from buzzloop.caiaq.de ([212.112.241.133]:59664 "EHLO
	buzzloop.caiaq.de") by lappi.linux-mips.net with ESMTP
	id S1099483AbWGMTUA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Jul 2006 21:20:00 +0200
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id A1F5B7F4028;
	Thu, 13 Jul 2006 21:19:22 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25499-08; Thu, 13 Jul 2006 21:19:22 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 2F0827F4022;
	Thu, 13 Jul 2006 21:19:22 +0200 (CEST)
In-Reply-To: <20060713163200.GA7186@gundam.enneenne.com>
References: <20060713163200.GA7186@gundam.enneenne.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <7B459115-48AE-4E49-877E-4DFFF46BD207@caiaq.de>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.752.2)
From:	Daniel Mack <daniel@caiaq.de>
Subject: Re: Problems after merge to 2.6.18-rc1
Date:	Thu, 13 Jul 2006 21:19:15 +0200
To:	Rodolfo Giometti <giometti@linux.it>
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi,

On Jul 13, 2006, at 6:32 PM, Rodolfo Giometti wrote:

>    Call Trace:
>     [<8015d91c>] bad_page+0x6c/0xac
>     [<8015e4c0>] free_hot_cold_page+0x190/0x1ec
>     [<8046099c>] free_all_bootmem_core+0x1ec/0x228
>     [<80457110>] mem_init+0x4c/0x218
>     [<80462a50>] inode_init_early+0x68/0xbc
>     [<804657d8>] console_init+0x48/0x68
>     [<80450824>] start_kernel+0x208/0x400
>     [<8045081c>] start_kernel+0x200/0x400
>     [<80450134>] unknown_bootoption+0x0/0x310

Well, what might 'unknown_bootoption' be trying to tell you?
What boot options did you set?

Daniel
