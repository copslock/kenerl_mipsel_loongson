Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DEFQk07306
	for linux-mips-outgoing; Thu, 13 Sep 2001 07:15:26 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DEFJe07303
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 07:15:19 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA10731
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 07:15:11 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA20070
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 07:15:11 -0700 (PDT)
Received: from mips.com (IDENT:kjelde@coplin19 [192.168.205.89])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8DEFAa12842
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 16:15:11 +0200 (MEST)
Message-ID: <3BA0BF6E.2010300@mips.com>
Date: Thu, 13 Sep 2001 16:15:10 +0200
From: Kjeld Borch Egevang <kjelde@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Error in gcc version 2.96 20000731
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all.

I discovered an optimization error in the current gcc for MIPS.

When I compile the code below with -O2 it clears the code-field just 
after setting it. The instructions are mixed up. It works fine with -O1 
and -O0.

If the "//" is removed in front of the first printf, it works too.


/Kjeld

--------------- cut here -----------------
#include <stdio.h>


typedef struct rtx_def
{
 short code;
 int dummy;
} rtx;


void put_code (rtx *rt, short code)
{
 register int length;

 length = 1;
 for (; length >= 0; length--)
   ((int *) rt)[length] = 0;

 // printf("put_code before\n");
 rt->code = code;
 printf("put_code after, code=%d %d\n", code, rt->code);
}


int main()
{
 rtx rt;

 put_code(&rt, 5);
 printf("gen_rtx, code=%d\n", rt.code);
}
--------------- cut here -----------------


The assembler looks like:

       .rdata
       .align  2
$LC0:
       .ascii  "put_code after, code=%d %d\n\000"
       .text
       .align  2
       .globl  put_code
       .ent    put_code
       .type    put_code,@function
put_code:
       .frame  $sp,32,$31              # vars= 0, regs= 2/0, args= 16, 
extra= 8
       .mask   0x90000000,-4
       .fmask  0x00000000,0
       .set    noreorder
       .cpload $25
       .set    reorder
       subu    $sp,$sp,32
       .cprestore 16
       move    $2,$5
       sll     $2,$2,16
       sra     $2,$2,16
       move    $5,$2
       la      $3,$LC0
       sw      $31,28($sp)
       sw      $28,24($sp)
       move    $6,$5
       sh      $2,0($4)     <----- sets code field
       sw      $0,4($4)     <----- clears structure
       sw      $0,0($4)     <----- clears structure
       move    $4,$3
       la      $25,printf
       jal     $31,$25
       lw      $31,28($sp)
       #nop
       .set    noreorder
       .set    nomacro
       j       $31
       addu    $sp,$sp,32
       .set    macro
       .set    reorder

       .end    put_code
