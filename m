Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 12:06:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:50656 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574378AbXLLMGu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 12:06:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBCC6Bo1030264;
	Wed, 12 Dec 2007 12:06:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBCC6AFH030263;
	Wed, 12 Dec 2007 12:06:10 GMT
Date:	Wed, 12 Dec 2007 12:06:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@avtrex.com>
Subject: Re: 2.6.24-rc2 crash in kmap_coherent
Message-ID: <20071212120610.GB28868@linux-mips.org>
References: <20071211221327.GB2150@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071211221327.GB2150@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 11, 2007 at 11:13:27PM +0100, Florian Lohoff wrote:

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

Hmm...  This suggests that 283abbaef425c1bf817ecbb456c413cab08b1434 is
not quite right.  It is making the assumption that a mapped page never has
PG_dcache_dirty set.

  Ralf
