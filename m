Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2002 22:28:57 +0100 (CET)
Received: from palrel11.hp.com ([156.153.255.246]:18883 "HELO palrel11.hp.com")
	by linux-mips.org with SMTP id <S1121744AbSKAV24>;
	Fri, 1 Nov 2002 22:28:56 +0100
Received: from xparelay1.ptp.hp.com (xparelay1.ptp.hp.com [15.1.28.62])
	by palrel11.hp.com (Postfix) with ESMTP
	id 0E99E600BE3; Fri,  1 Nov 2002 13:28:42 -0800 (PST)
Received: from xpabh3.ptp.hp.com (xpabh3.ptp.hp.com [15.1.28.63])
	by xparelay1.ptp.hp.com (Postfix) with ESMTP
	id CA332E0009C; Fri,  1 Nov 2002 13:28:41 -0800 (PST)
Received: by xpabh3.ptp.hp.com with Internet Mail Service (5.5.2655.55)
	id <V5H0G19N>; Fri, 1 Nov 2002 13:28:41 -0800
Message-ID: <CBD6266EA291D5118144009027AA63350A68F189@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: 'Ralf Baechle' <ralf@linux-mips.org>,
	"TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: NFS Root failure in 2.4.18 - Traced to 256k COLOUR_ALIGN
Date: Fri, 1 Nov 2002 13:28:32 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <roger_twede@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roger_twede@hp.com
Precedence: bulk
X-list: linux-mips

I traced the NFS root boot failure to a change made in the the function
arch_get_unmapped_area(...).  The system goes from functional to
non-functional with a single function change made in 2.4.18.
linux/arch/mips/kernel/syscall.c :: arch_get_unmapped_area(...),
COLOUR_ALIGN 

The virtual mappings are now aligned on a 256k boundary instead of a page
boundary whenever the mapping is to be shared (as in an executable file
mapping).  The COLOUR_ALIGN macro was added and is used in place of
PAGE_ALIGN as found in the file arch/mips/kernel/syscall.c.

As our system boots from a disk such as ide, all calls to this function pass
in a requested address of 0x0.  The function then chooses a free virtual
address space accordingly.  Upon nfsroot booting, calls to this function
pass in a requested address that is non-zero (such as 0x0fb60000).  This
address is page aligned, so in the old version of
arch_get_unmapped_area(...) the exact requested address was fine and
returned from the get_unmapped_area().  In the new version of the function,
the alignment requirement is 256k, however the nfs requested address is not
aligned on a 256k boundary, and is therefore pushed up to the next 256k
boundary.  The system does not like this and fails. (the function is never
called again, further booting does not take place)

Several questions that arise:
- In the nfs case, should the file structure have its
file->f_op->get_unmapped_area() member assigned, causing a file specific
get_unmapped_area to be called instead of this arch_get_unmapped_area?
- Or should the mapping request pass in a requested address which already
has valid 256k alignment?
- Or should requested addresses that are misaligned be handled well by the
calling code once the translated/aligned address is returned to the calller?

And generally:
- Why does nfsroot booting cause apecific non-zero virtual addresses to be
requested, whereas in the ide disk booting case, addressed are left
unspecified (0x0) (no requested mapping)?

Thanks for any information anyone might lend.

Roger
