Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4RDC1nC006072
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 06:12:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4RDC1Kp006071
	for linux-mips-outgoing; Mon, 27 May 2002 06:12:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru ([193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4RDBqnC006067
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 06:11:53 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id RAA19392;
	Mon, 27 May 2002 17:12:21 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id RAA01134; Mon, 27 May 2002 17:03:30 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id RAA20083; Mon, 27 May 2002 17:07:17 +0400 (MSK)
Message-ID: <3CF2A17D.6050207@niisi.msk.ru>
Date: Mon, 27 May 2002 17:13:33 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.17 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
References: <3CEEBBA9.5070809@niisi.msk.ru> <3CEEAC5F.6010802@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090100080205070303000804"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------090100080205070303000804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jun Sun wrote:

> I took a look of the arch_get_unmapped_area(),  and it looks fine to me.
>
> Can you try the following changes and let me know what happens?
>
> 1) change COLOUR_ALIGN
> #define COLOUR_ALIGN(addr,pgoff)     addr

OK, It works for me.

>
> We have been using gcc 2.9.5 and binutils 2.10.x for R3000 CPUs for 
> quite a  while with no problems.  It seems newer gcc and binutiles are 
> fine too.
>
I understand, but is there any __official__ recommended versions of these
utils? http://oss.sgi.com/mips/mips-howto.html is out-of-date :(



--------------090100080205070303000804
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -pru linux_2_4_18_orig/arch/mips/mm/tlb-r3k.c linux_2_4_18/arch/mips/mm/tlb-r3k.c
--- linux_2_4_18_orig/arch/mips/mm/tlb-r3k.c	Fri Apr 26 07:50:07 2002
+++ linux_2_4_18/arch/mips/mm/tlb-r3k.c	Mon May 27 16:36:14 2002
@@ -118,7 +118,7 @@ void local_flush_tlb_range(struct mm_str
 
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
-	if (!vma || vma->vm_mm->context != 0) {
+	if (vma && vma->vm_mm->context) {
 		unsigned long flags;
 		int oldpid, newpid, idx;
 
diff -pru linux_2_4_18_orig/arch/mips/mm/tlb-r4k.c linux_2_4_18/arch/mips/mm/tlb-r4k.c
--- linux_2_4_18_orig/arch/mips/mm/tlb-r4k.c	Fri Apr 26 07:50:07 2002
+++ linux_2_4_18/arch/mips/mm/tlb-r4k.c	Mon May 27 16:31:45 2002
@@ -140,7 +140,7 @@ void local_flush_tlb_range(struct mm_str
 
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
-	if (!vma || vma->vm_mm->context != 0) {
+	if (vma && vma->vm_mm->context) {
 		unsigned long flags;
 		int oldpid, newpid, idx;
 

--------------090100080205070303000804--
