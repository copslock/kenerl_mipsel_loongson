Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 01:28:59 +0000 (GMT)
Received: from fw.osdl.org ([IPv6:::ffff:65.172.181.6]:49288 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8225453AbUAOB26>;
	Thu, 15 Jan 2004 01:28:58 +0000
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i0F1SRo26782;
	Wed, 14 Jan 2004 17:28:27 -0800
Date: Wed, 14 Jan 2004 17:29:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: jsun@mvista.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program
 returns pages to kernel
Message-Id: <20040114172946.03e54706.akpm@osdl.org>
In-Reply-To: <20040114171252.4d873c51.akpm@osdl.org>
References: <20040114163920.E13471@mvista.com>
	<20040114171252.4d873c51.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Andrew Morton <akpm@osdl.org> wrote:
>
> I think that's wrong, really.  We've discussed this before and decided that
> these flushing operations should be open-coded in the main .c file rather
> than embedded in arch functions which happen to undocumentedly do other
> stuff.

err, OK, I give up.  Lots of architectures do the cache flush in
tlb_start_vma().  I guess mips may as well do the same.
