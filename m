Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15KsCH10683
	for linux-mips-outgoing; Tue, 5 Feb 2002 12:54:12 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15Ks8A10637
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 12:54:08 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA12073;
	Tue, 5 Feb 2002 12:54:02 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA25903;
	Tue, 5 Feb 2002 12:54:00 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g15KrYA01845;
	Tue, 5 Feb 2002 21:53:34 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id VAA21843;
	Tue, 5 Feb 2002 21:53:58 +0100 (MET)
Message-Id: <200202052053.VAA21843@copsun18.mips.com>
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
To: sjhill@cotw.com
Date: Tue, 5 Feb 2002 21:53:58 +0100 (MET)
Cc: hartvige@mips.com (Hartvig Ekner), linux-mips@oss.sgi.com
In-Reply-To: <3C6044A7.13FEB2E2@cotw.com> from "Steven J. Hill" at Feb 05, 2002 02:46:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Steven J. Hill writes:
> 
> Hartvig Ekner wrote:
> > 
> > You have to distinguish between physical and virtual memory. The MIPS32
> > architecture supports implementations with up to 36 bits of physical
> > address space, however the virtual address space in kernel and user mode
> > is as you describe below.
> > 
> I wasn't talking about the MIP32[tm] cores specifically, I was using a
> generalization of 32bit. However, this is good to know. All of the data
> sheets that I just downloaded from the MIPS site for the R4k[X] cores
> don't mention the 36-bit PA item. Care to elaborate?

Sure. All the 4K, 4KE and 4KS families (all MIPS32 cores) from MTI only
provide 32 bits of PA. The 5K and 20K families (MIPS64 implementations)
both provide 36 bit of PA.

Also note that all of the above is only relevant for cores which have a TLB.
The low-end 4K/4KE/4KS cores all come in variants without TLB (to save
die area) and these can of course only generate 32-bits of PA regardless.

/Hartvig
