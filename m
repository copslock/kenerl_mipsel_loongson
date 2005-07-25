Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2005 09:50:24 +0100 (BST)
Received: from mra03.ch.as12513.net ([IPv6:::ffff:82.153.252.25]:2181 "EHLO
	mra03.ch.as12513.net") by linux-mips.org with ESMTP
	id <S8225462AbVGYIt4>; Mon, 25 Jul 2005 09:49:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra03.ch.as12513.net (Postfix) with ESMTP id 8FA8ED4598;
	Mon, 25 Jul 2005 09:52:11 +0100 (BST)
Received: from mra03.ch.as12513.net ([127.0.0.1])
 by localhost (mra03.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10056-01-96; Mon, 25 Jul 2005 09:52:10 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra03.ch.as12513.net (Postfix) with ESMTP id DD0CED45C7;
	Mon, 25 Jul 2005 09:52:06 +0100 (BST)
Subject: Re: Going over 512M of memory
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	Rojhalat Ibrahim <imr@rtschenk.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <42E4983C.5030804@rtschenk.de>
References: <20050721153359Z8225218-3678+3745@linux-mips.org>
	 <20050722043057.GA3803@linux-mips.org>
	 <1122023087.30605.3.camel@euskadi.packetvision>
	 <20050722131417.GA29581@linux-mips.org>
	 <1122039139.30605.21.camel@euskadi.packetvision>
	 <42E4983C.5030804@rtschenk.de>
Content-Type: text/plain
Message-Id: <1122281653.19480.2.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Mon, 25 Jul 2005 09:54:13 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

The following patch works for me (Note that it's cut and pasted from the
thread so the line numbers do not correspond to current versions of the
file)

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.101
diff -u -r1.101 c-r4k.c
--- arch/mips/mm/c-r4k.c 7 Feb 2005 21:53:39 -0000 1.101
+++ arch/mips/mm/c-r4k.c 8 Feb 2005 00:18:17 -0000
@@ -566,9 +566,21 @@
if (!cpu_has_ic_fills_f_dc) {
unsigned long addr = (unsigned long) page_address(page);
- r4k_blast_dcache_page(addr);
- if (!cpu_icache_snoops_remote_store)
- r4k_blast_scache_page(addr);
+
+ if (addr)
+ r4k_blast_dcache_page(addr);
+ else
+ r4k_blast_dcache();
+
+ if (!cpu_icache_snoops_remote_store) {
+ if (addr)
+ r4k_blast_scache_page(addr);
+ else {
+ addr = page_to_pfn(page) << PAGE_SHIFT;
+ addr = CKSEG0 + (addr & ~((1UL << 24) - 1));
+ r4k_blast_scache_page_indexed(addr);
+ }
+ }
ClearPageDcacheDirty(page);
}

On Mon, 2005-07-25 at 08:43, Rojhalat Ibrahim wrote:
> Hi,
> 
> I am not sure what patch you are actually talking about.
> In the mentioned thread there were several. Did you only apply
> the last one or all of them, i.e. did you also apply
> the patches that keep flushing the caches?
> Because those are really only a workaround and not a
> solution to the root cause of the problem.
> 
> Rojhalat Ibrahim
> 
> 
> Alex Gonzalez wrote:
> > It's a RM9020.
> > 
> > Quoting Ibrahim's,
> > 
> > "With a slightly extended patch it actually works. But afterwards
> > I get a lot of Illegal instructions and Segmentation faults, where
> > there shouldn't be any. Below is the patch I used."
> > 
> > And after you post an improved patch, he says,
> > 
> > "I presume CKSEG is CKSEG0 in the above patch. With that it works
> > about the same as before. So do you have any clue what the problem
> > behind all that really is? Furthermore I still have all those
> > "Illegal instruction" and "Segmentation fault" messages that
> > shouldn't be there."
> > 
> > The illegal instructions and segmentation faults turned to be the cpu_has_64bit_gp_regs setting. So I presume it worked for him.
> > 
> > In our case, it seems to work completely OK. I am running a complete memory test over the whole 1G to be completely sure (with memtester), and I'll report the result back.
> > 
> > Thanks,
> > Alex
> > 
> > 
> > On Fri, 2005-07-22 at 14:14, Ralf Baechle wrote:
> > 
> >>On Fri, Jul 22, 2005 at 10:04:47AM +0100, Alex Gonzalez wrote:
> >>
> >>
> >>>Our target experienced a kernel panic at startup when trying to access
> >>>memory above 512MB.
> >>>
> >>>Reading the list archives I found this thread with a proposed patch:
> >>>
> >>>http://www.linux-mips.org/archives/linux-mips/2005-02/msg00115.html
> >>>
> >>>After applying the patch our target boots OK and appears to be able to
> >>>access the whole memory range without problems.
> >>>
> >>>Any idea why this patch didn't make it to the repository? Is it safe?
> >>
> >>It is - but according to Ibrahim's posting that you're pointing to it
> >>didn't solve his problem.
> >>
> >>What CPU are you using, btw?
> >>
> >>  Ralf
> 
