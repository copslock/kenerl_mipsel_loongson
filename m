Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 04:44:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49575 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8126515AbWGYDom (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 04:44:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k6P3iRi4026104;
	Mon, 24 Jul 2006 23:44:28 -0400
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k6P3iOhg026103;
	Mon, 24 Jul 2006 23:44:24 -0400
Date:	Mon, 24 Jul 2006 23:44:24 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	wyb@topsec.com.cn
Cc:	macro@linux-mips.org, sskowron@ET.PUT.Poznan.PL.redhat.com,
	rsandifo@redhat.com, linux-mips@linux-mips.org
Subject: Re: unmatched R_MIPS_HI16/LO16 on gcc 3.4.3
Message-ID: <20060725034424.GB22138@linux-mips.org>
References: <004001c6af95$14585900$0100000a@codingman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001c6af95$14585900$0100000a@codingman>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 25, 2006 at 10:49:56AM +0800, wyb@topsec.com.cn wrote:

> I met similar problem as Stanislaw Skowronek, but for gcc 3.4.3. I created a
> kernel module, when insmod, kernel reported "dangerous relocation". I traced
> the bug, found unmatched R_MIPS_HI16/LO16 in module's elf file, and kernel
> refused to relocate:
> ...
> 00015a5c  00039a05 R_MIPS_HI16       0000000c   tos_net_debug
> 00015a68  00000204 R_MIPS_26         00000000   .text
> 00015a64  00046005 R_MIPS_HI16       0006b598   arp_proxy_list
> 00015a6c  00046006 R_MIPS_LO16       0006b598   arp_proxy_list
> ...
> 
> My problem arised when expression on tos_net_debug could be optimized out,
> it seemed like gcc optimized out the LO16, but left HI16.
> 
> The original discussion on similar problem is at
> http://www.linux-mips.org/archives/linux-mips/2005-05/msg00097.html

Do you have a testcase, a kernel .config file to trigger this?

  Ralf
