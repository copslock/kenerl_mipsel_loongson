Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15Kkp805016
	for linux-mips-outgoing; Tue, 5 Feb 2002 12:46:51 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15KklA04983
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 12:46:47 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16YCUC-0000XP-00; Tue, 05 Feb 2002 14:46:40 -0600
Message-ID: <3C6044A7.13FEB2E2@cotw.com>
Date: Tue, 05 Feb 2002 14:46:31 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hartvig Ekner <hartvige@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
References: <200202051747.SAA21696@copsun18.mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hartvig Ekner wrote:
> 
> You have to distinguish between physical and virtual memory. The MIPS32
> architecture supports implementations with up to 36 bits of physical
> address space, however the virtual address space in kernel and user mode
> is as you describe below.
> 
I wasn't talking about the MIP32[tm] cores specifically, I was using a
generalization of 32bit. However, this is good to know. All of the data
sheets that I just downloaded from the MIPS site for the R4k[X] cores
don't mention the 36-bit PA item. Care to elaborate?

> One note: Many MIPS32 implementations choose not to implement all 36 PA
> bits, but limit themselves to 32 bits. This saves a few bits in the TLB
> and a few address lines.
> 
So, if someone did want 36 PA bits on Linux, the TLB exception handlers
and a little of the page table construction/management code would have to
change. The userspace contraints and such would still remain. Cool.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
