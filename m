Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 07:38:50 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.193]:35734 "HELO
	mproxy.gmail.com") by linux-mips.org with SMTP id <S8225458AbUGHGip>;
	Thu, 8 Jul 2004 07:38:45 +0100
Received: by mproxy.gmail.com with SMTP id d5so180660rng
        for <linux-mips@linux-mips.org>; Wed, 07 Jul 2004 23:38:40 -0700 (PDT)
Received: by 10.38.3.58 with SMTP id 58mr203354rnc;
        Wed, 07 Jul 2004 23:38:40 -0700 (PDT)
Message-ID: <f013fac60407072338b65f8fd@mail.gmail.com>
Date: Thu, 8 Jul 2004 12:08:40 +0530
From: Sridhar Adagada <asridhars@gmail.com>
To: linux-mips@linux-mips.org
Subject: Optimisation
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <asridhars@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asridhars@gmail.com
Precedence: bulk
X-list: linux-mips

Hello everybody,

I am sorry if the mail is too long had to include assembly code, which
i am still learning.

I am trying some optimization on some my code.  Listed below is the
c-code of a function which is obvious,  but the assembly from compiler
with optimization for speed, is confusing to me can any one explain?

As you can see $6 is the length, my confusion is at the lines 12-14,
19, 20 why is the length added with 65535 and the comparison with 0
for max and the right shift.  The same operation is done the base ($7)
 can any one explain why this is needed.  Can i replace all these
three instructions with "ori $9 $0 $6"

One more thing does the instruction at line 25 "madl    $25, $24" do?

Any help with be greatly appresciated

Thanks
Sri

C-code:
short cal_xxx(short *abs, short *coef, short len, short base)
{
 short i;
 short sum = 0;

 for (i = 0; i < length; i++)
 {
   sum += ( (unsigned int)abs[i] * (unsigned int)coef[i] );
 }
 return ( ((sum + 1 << (base -1)) >> base) );
}

Assmebly code:
    1         .set    noat
    2         .set    noreorder
    3         .set    nomacro
    4         .text
    5         .align  4
    6         .globl  cal_xxx
    7 /*  short i;
    8     short sum = 0; */
    9         ori     $9, $0, 0
   10         ori     $3, $0, 0
   11 /*  for( i = 0; i < length; i++ ) */
   12         andi    $6, $6, 65535
   13         imax    $8, $6, 0
   14         srl     $10, $8, 3
   15         beq     $10, $0, .L62
   16         andi    $7, $7, 65535
   17         move    $2, $5
   18         move    $11, $4
   19         sll     $24, $10, 3
   20         andi    $9, $24, 65528
   21 .L78:
   22         lh      $25, 0($11)
   23         lh      $24, 0($2)
   24         mtlo    $3
   25         madl    $25, $24
   26         lh      $25, 2($11)
   27         lh      $24, 2($2)
   28         nop
   29         madl    $25, $24
   30         lh      $25, 4($11)
   31         lh      $24, 4($2)
   32         nop
   33         madl    $25, $24
   34         lh      $25, 6($11)
   35         lh      $24, 6($2)
   36         nop
   37         madl    $25, $24
   38         lh      $25, 8($11)
   39         lh      $24, 8($2)
   40         nop
   41         madl    $25, $24
   42         lh      $25, 10($11)
   43         lh      $24, 10($2)
   44         nop
   45         madl    $25, $24
   46         lh      $25, 12($11)
   47         lh      $24, 12($2)
   48         nop
   49         madl    $25, $24
   50         lh      $25, 14($11)
   51         lh      $24, 14($2)
   52         addiu   $10, $10, -1
   53         madl    $25, $24
   54         addiu   $11, $11, 16
   55         addiu   $2, $2, 16
   56         mflo    $3
   57         bne     $10, $0, .L78
   58         nop
   59         nop
   60 .L62:
   61         andi    $10, $8, 7
   62         beq     $10, $0, .L44
   63         sll     $9, $9, 1
   64         addu    $2, $5, $9
   65         addu    $25, $4, $9
   66         addiu   $10, $10, -1
   67 .L1000082:
   68         lh      $15, 0($2)
   69         lh      $24, 0($25)
   70         mtlo    $3
   71         madl    $24, $15
   72         addiu   $25, $25, 2
   73         addiu   $2, $2, 2
   74         mflo    $3
   75         bne     $10, $0, .L1000082
   76         addiu   $10, $10, -1
   77 .L44:
   78 /*     } for-end */
   79         addiu   $25, $7, -1
   80         ori     $15, $0, 1
   81         sllv    $24, $15, $25
   82         addu    $14, $3, $24
   83         srav    $13, $14, $7
   84         sll     $2, $13, 16
   85  #          .ef
   86         jr      $ra
   87         sra     $2, $2, 16
   88         .type   cal_xxx,@function
   89         .size   cal_xxx,.-cal_xxx
   90         .align  4
   91  #i     $9      local
   92  #sum   $3      local
   93
   94  #abs  $4      param
   95  #coef $5      param
   96  #length        $6      param
   97  #base  $7      param
   98
   99         .data
  100 .L139:
  101         .text
  102 /*  } end-function */
