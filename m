Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 19:05:21 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:55309 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225226AbTGASFS>; Tue, 1 Jul 2003 19:05:18 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Tue, 01 Jul 2003 11:05:02 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA15174; Tue, 1 Jul 2003 11:04:43 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h61I54ov024225; Tue, 1 Jul 2003 11:05:04 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA10302; Tue, 1
 Jul 2003 11:05:04 -0700
Message-ID: <3F01CD50.49F34BAC@broadcom.com>
Date: Tue, 01 Jul 2003 11:05:04 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Brian Murphy" <brian@murphy.dk>
cc: linux-mips@linux-mips.org
Subject: Re: 2.5 crash on boot
References: <3F01CB57.7090408@murphy.dk>
X-WSS-ID: 131F12C4156742-01-01
Content-Type: multipart/mixed;
 boundary=------------DDEB6D38E0F6408056BC7A3D
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------DDEB6D38E0F6408056BC7A3D
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit


This may be related to something I just found -- in pmd_populate_kernel,
a physical address is installed in the pmd instead of a virtual
address.  The patch I sent Ralf 30 minutes ago is attached :-)

Kip

Brian Murphy wrote:
> 
> Hi,
> 
> I get this now when my system (working well with 2.4) attempts to
> read from the disk on my system:
> 
> Freeing unused kernel memory: 88k freed
> Unable to handle kernel paging request at virtual address 07cac000, epc
> == 8005c
> Oops in arch/mips/mm/fault.c::do_page_fault, line
> 205[#1]:
> Cpu 0
> $ 0 : 00000000 b0008400 00000000 fffffff4
> $ 4 : 07cac000 00000000 00011000 000007df
> $ 8 : 07cac000 801e4ab8 811375e0 00000001
> $12 : 00000001 00100100 ffffffff 87fff284
> $16 : 00000000 07cac000 00000000 87ce5e98
> $20 : 00011000 ffffffbf 000007df 00008075
> $24 : 87fff28c 00000001
> $28 : 87ce4000 87ce5de8 87f1c720 80059e2c
> Hi      : 00000000
> Lo      : 00000000
> epc   : 80059cb0    Not tainted
> Status: b0008403
> Cause : 00001008
> KERNEL EXL IE Process swapon (pid: 19, stackpage=87d22ac0)
> Stack:  8004ee28 80106b68 811377e8 00000000 00000000 801d7c00 00011000
> ffc000000
>         8006a2d8 87ce5e98 00000201 c0000000 801d7c00 c0011000 ffc00000
> 87ce5e988
>         87f0a120 00000044 87f0a120 87f0b4e0 00000011 000000d2 00000020
> 000007df.
> Call
> Trace:
>  [<8004ee28>] pte_alloc_kernel+0x74/0x158
>  [<80106b68>] blk_remove_plug+0x78/0x98
>  [<80059e2c>] map_area_pmd+0x84/0xd0
>  [<8006a2d8>] blkdev_readpage+0x0/0x28
>  [<80059f98>] map_vm_area+0x74/0xe0
>  [<8005a4f8>] __vmalloc+0x140/0x178
>  [<800228c0>] autoremove_wake_function+0x0/0x44
>  [<8006a150>] blkdev_get_block+0x0/0x74
>  [<8005a544>] vmalloc+0x14/0x20
>  [<8005e1bc>] sys_swapon+0x6ec/0x84c
>  [<8005dee4>] sys_swapon+0x414/0x84c
>  [<8021b000>] pci_scan_device+0xf0/0x1a8
>  [<8000cc20>] stack_done+0x18/0x34
>  [<80008413>] handle_ades_int+0x27/0x34
> 
> 
> Code: 8fb30040  3c140040  2415ffbf <8e220000> 8e630000  3c04801b
> 2484cb6c  005
> 
> 
> Any pointers? I'm running in 32 bit mode.
> 
> /Brian
--------------DDEB6D38E0F6408056BC7A3D
Content-Type: text/plain;
 charset=us-ascii;
 name=pgalloc.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=pgalloc.diff

Index: include/asm-mips/pgalloc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pgalloc.h,v
retrieving revision 1.27
diff -u -r1.27 pgalloc.h
--- include/asm-mips/pgalloc.h	26 Jun 2003 20:19:44 -0000	1.27
+++ include/asm-mips/pgalloc.h	1 Jul 2003 17:26:05 -0000
@@ -17,7 +17,7 @@
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte)
 {
-	set_pmd(pmd, __pmd(__pa(pte)));
+	set_pmd(pmd, __pmd((unsigned long)pte));
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
Index: include/asm-mips64/pgalloc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/pgalloc.h,v
retrieving revision 1.29
diff -u -r1.29 pgalloc.h
--- include/asm-mips64/pgalloc.h	26 Jun 2003 20:19:44 -0000	1.29
+++ include/asm-mips64/pgalloc.h	1 Jul 2003 17:26:05 -0000
@@ -19,7 +19,7 @@
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pte_t *pte)
 {
-	set_pmd(pmd, __pmd(__pa(pte)));
+	set_pmd(pmd, __pmd((unsigned long)pte));
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,

--------------DDEB6D38E0F6408056BC7A3D--
