Received:  by oss.sgi.com id <S305165AbQDTCau>;
	Wed, 19 Apr 2000 19:30:50 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:21765 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQDTCaY>; Wed, 19 Apr 2000 19:30:24 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA08755; Wed, 19 Apr 2000 19:34:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA53926
	for linux-list;
	Wed, 19 Apr 2000 19:13:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA58539
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Apr 2000 19:13:52 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA08326
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Apr 2000 19:13:51 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from mail1.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (04/18/00) with ESMTP id LAA20510;
	Thu, 20 Apr 2000 11:13:52 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (3.7W990708a) with ESMTP id LAA19656;
	Thu, 20 Apr 2000 11:13:52 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id LAA11821; Thu, 20 Apr 2000 11:13:10 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id LAA14833; Thu, 20 Apr 2000 11:13:21 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id LAA18281; Thu, 20 Apr 2000 11:13:20 +0900 (JST)
To:     binutils@sourceware.cygnus.com, linux@cthulhu.engr.sgi.com,
        debian-mips@lists.debian.org
Subject: MIPS gas problem
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000420111320Z.machida@sm.sony.co.jp>
Date:   Thu, 20 Apr 2000 11:13:20 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi

I found the problem  "__attribute__ ((aligned(xx))" doesn't work
properly on MIPS/Linux. Please try to execute the attached test. 
I think this problem can be reproduced on any ELF/MIPS box except
EMBEDED system which has OS name "elf". 

I tracked down and finaly found gas/config/t-mips.c:s_change_sec(sec) 
sets  always ".rodata" section-alignment to 2**4. This should be set 
to the maximum rodata object's alignment value.

% cc -c  rotest.c -o rotest.o
% objdump -h rotest.o

rotest.o:     file format elf32-littlemips

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000330  0000000000000000  0000000000000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000010  0000000000000000  0000000000000000  00000370  2**4
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  0000000000000000  0000000000000000  00000380  2**4
                  ALLOC
  3 .reginfo      00000018  0000000000000000  0000000000000000  00000380  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA,LINK_ONCE_SAME_SIZE
  4 .mdebug       000002f8  0000000000000000  0000000000000000  00000398  2**2
                  CONTENTS, READONLY, DEBUGGING
  5 .rodata       00002060  0000000000000000  0000000000000000  00000690  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA


The sample fix for binutils 2.9.1 is following. (This can be
apply to current CVS version, I suppose.)

Does anyone know the reason why gas/config/t-mips.c set to "rodata'
section alignment to 2**4 and ignore the maximum rodata object
alignment.? We have to know why this restriction is made, anyway.

---
Hiroyuki Machida
Creative Station		SCE Inc./Sony Corp.

Index: tc-mips.c
===================================================================
RCS file: /usr/cvsroot/caesar/src/compiler/binutils/gas/config/tc-mips.c,v
retrieving revision 1.4
retrieving revision 1.5
diff -U10 -p -r1.4 -r1.5
--- tc-mips.c	1999/07/07 01:03:55	1.4
+++ tc-mips.c	2000/04/12 06:50:19	1.5
@@ -9727,21 +9727,28 @@ s_change_sec (sec)
 			    (subsegT) get_absolute_expression ());
 	  if (OUTPUT_FLAVOR == bfd_target_elf_flavour)
 	    {
 	      bfd_set_section_flags (stdoutput, seg,
 				     (SEC_ALLOC
 				      | SEC_LOAD
 				      | SEC_READONLY
 				      | SEC_RELOC
 				      | SEC_DATA));
 	      if (strcmp (TARGET_OS, "elf") != 0)
-		bfd_set_section_alignment (stdoutput, seg, 4);
+	        {
+		  static char first = 1;
+		  if (first)
+		    {
+		      bfd_set_section_alignment (stdoutput, seg, 4);
+		      first=0;
+		    }
+	        }
 	    }
 	  demand_empty_rest_of_line ();
 	}
       else
 	{
 	  as_bad ("No read only data section in this object file format");
 	  demand_empty_rest_of_line ();
 	  return;
 	}
       break;
@@ -9749,21 +9756,28 @@ s_change_sec (sec)
     case 's':
       if (USE_GLOBAL_POINTER_OPT)
 	{
 	  seg = subseg_new (".sdata", (subsegT) get_absolute_expression ());
 	  if (OUTPUT_FLAVOR == bfd_target_elf_flavour)
 	    {
 	      bfd_set_section_flags (stdoutput, seg,
 				     SEC_ALLOC | SEC_LOAD | SEC_RELOC
 				     | SEC_DATA);
 	      if (strcmp (TARGET_OS, "elf") != 0)
-		bfd_set_section_alignment (stdoutput, seg, 4);
+	        {
+		  static char first = 1;
+		  if (first)
+		    {
+		      bfd_set_section_alignment (stdoutput, seg, 4);
+		      first=0;
+		    }
+	        }
 	    }
 	  demand_empty_rest_of_line ();
 	  break;
 	}
       else
 	{
 	  as_bad ("Global pointers not supported; recompile -G 0");
 	  demand_empty_rest_of_line ();
 	  return;
 	}

--- end of patch




/*
 * rotest.c - rodata alignment test.
 */

#define AL1 1024
#define AL2 4096
const char globalc='a';
const int global1 __attribute__ ((aligned(AL1))) =0 ;
const int global2 __attribute__ ((aligned(AL2))) =1;

const int local1 __attribute__ ((aligned(AL1))) =0 ;
const int local2 __attribute__ ((aligned(AL2))) =1;

int total_ng=0;

void check(char *addr, unsigned long al)
{
        unsigned long mask = (al -1);
        if ((unsigned long) addr & mask){
                total_ng ++;
                printf("err:%x expected:%x\n", addr, 
				(unsigned long) addr & ~mask);
        }
}


int
main(void)
{
        printf("* readonly local/gloabl\n");
        printf("chcking align:%x\n",AL1);
        check((char *)&local1,AL1); check((char *)&global1,AL1);
        printf("%x:%x\n", &local1,&global1);
        printf("chcking align:%x\n",4096);
        check((char *)&global1,AL2); check((char *)&global2,AL2);
        printf("%x:%x\n", &global1,&global2);

        printf("\n");
        if (total_ng) {
                printf("NG:%d\n",total_ng);
        } else {
                printf("OK\n");
        }
        printf("\n");
        return total_ng;
}


--- end of test
