Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g476lMwJ002399
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 23:47:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g476lMvt002398
	for linux-mips-outgoing; Mon, 6 May 2002 23:47:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g476l6wJ002395;
	Mon, 6 May 2002 23:47:07 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [128.167.58.27]) with SMTP; 7 May 2002 06:48:28 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id B1BC3B471; Tue,  7 May 2002 15:48:26 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA21044; Tue, 7 May 2002 15:48:26 +0900 (JST)
Date: Tue, 07 May 2002 15:48:20 +0900 (JST)
Message-Id: <20020507.154820.92590599.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: flo@rfc822.org, ralf@oss.sgi.com, linux-mips@oss.sgi.com, agx@sigxcpu.org
Subject: Re: XSHM/shared-pixmap fix Was: Linux Shared Memory Issue
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.GSO.3.96.1020506130204.17175B-100000@delta.ds2.pg.gda.pl>
	<20010814104941.F5928@bacchus.dhis.org>
References: <20020427214505.GA23046@paradigm.rfc822.org>
	<Pine.GSO.3.96.1020506130204.17175B-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Mon, 6 May 2002 13:04:58 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  Check it doesn't break static executables -- there were a few
macro> arch_get_unmapped_area() updates in mm/mmap.c that you don't
macro> include in the patch it would seem.

I have yet another arch_get_unmapped_area which includes it.

My arch_get_unmapped_area is a hybrid of one in mm/mmap.c and one in
arch/sparc64/sys_sparc64.c.  Also, I am using MY_SHMLBA to avoid
wasting address space.  I got following comments from Ralf when I
posted my previous patch.

>>>>> On Tue, 14 Aug 2001 10:49:41 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> It's wasting huge amounts of address space.  That can be
ralf> prohibitive if you want to run something such as electric fence.
ralf> Technically the worst case of any CPU that's required is 32kb on
ralf> R4000 / R4400 SC and MC versions, so I don't want to go beyond
ralf> that.


Here is my arch_get_unmapped_area.

#ifdef HAVE_ARCH_UNMAPPED_AREA
/* solve cache aliasing problem (see Documentation/cachetlb.txt and
   arch/sparc64/kernel/sys_sparc.c */
#if SHMLBA > 0x10000
/* avoid overkill... */
#define MY_SHMLBA	0x10000
#else
#define MY_SHMLBA	SHMLBA
#endif
#define COLOUR_ALIGN(addr,pgoff)		\
	((((addr)+MY_SHMLBA-1)&~(MY_SHMLBA-1)) +	\
	 (((pgoff)<<PAGE_SHIFT) & (MY_SHMLBA-1)))

unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
{
	struct vm_area_struct * vmm;
	int do_color_align;

	if (flags & MAP_FIXED) {
		/* We do not accept a shared mapping if it would violate
		 * cache aliasing constraints.
		 */
		if ((flags & MAP_SHARED) && (addr & (MY_SHMLBA - 1)))
			return -EINVAL;
		return addr;
	}

	if (len > TASK_SIZE)
		return -ENOMEM;
	do_color_align = 0;
	if (filp || (flags & MAP_SHARED))
		do_color_align = 1;
	if (addr) {
		if (do_color_align)
			addr = COLOUR_ALIGN(addr, pgoff);
		else
			addr = PAGE_ALIGN(addr);
		vmm = find_vma(current->mm, addr);
		if (TASK_SIZE - len >= addr &&
		    (!vmm || addr + len <= vmm->vm_start))
			return addr;
	}
	addr = TASK_UNMAPPED_BASE;
	if (do_color_align)
		addr = COLOUR_ALIGN(addr, pgoff);
	else
		addr = PAGE_ALIGN(addr);

	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
		/* At this point:  (!vmm || addr < vmm->vm_end). */
		if (TASK_SIZE - len < addr)
			return -ENOMEM;
		if (!vmm || addr + len <= vmm->vm_start)
			return addr;
		addr = vmm->vm_end;
		if (do_color_align)
			addr = COLOUR_ALIGN(addr, pgoff);
	}
}
#endif /* HAVE_ARCH_UNMAPPED_AREA */

---
Atsushi Nemoto
