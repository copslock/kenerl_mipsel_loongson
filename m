Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2003 03:01:14 +0100 (BST)
Received: from mta08bw.bigpond.com ([IPv6:::ffff:144.135.24.137]:61689 "EHLO
	mta08bw.bigpond.com") by linux-mips.org with ESMTP
	id <S8225281AbTHGCBJ>; Thu, 7 Aug 2003 03:01:09 +0100
Received: from titan ([144.135.24.72]) by mta08bw.email.bigpond.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0HJ800B2D897RU@mta08bw.email.bigpond.com> for
 linux-mips@linux-mips.org; Thu, 07 Aug 2003 12:00:43 +1000 (EST)
Received: from cpe-203-45-209-27.qld.bigpond.net.au ([203.45.209.27])
 by bwmam02bpa.bigpond.com(MAM REL_3_3_2c 17/758429); Thu,
 07 Aug 2003 12:00:43 +0000
Date: Thu, 07 Aug 2003 12:00:45 +1000
From: Michael <trott@bigpond.net.au>
Subject: Re: debuging problems
To: Ranjan Parthasarathy <ranjanp@efi.com>, linux-mips@linux-mips.org
Reply-to: Michael <trott@bigpond.net.au>
Message-id: <02a901c35c87$b6d3a590$6400a8c0@titan>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <D9F6B9DABA4CAE4B92850252C52383AB079683A5@ex-eng-corp.efi.com>
Return-Path: <trott@bigpond.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trott@bigpond.net.au
Precedence: bulk
X-list: linux-mips

Hi Ranjan

im not sure what you mean when you say load in a branch/jump delay slot.

im guessing thats whats causing the irregular behavior, the way i see it is
that  my 'bne' jump is never being executed, where this should be the
default behavior in the majority of inputs.



thanks for your help, its really appreicated :)

michael



----- Original Message ----- 
From: "Ranjan Parthasarathy" <ranjanp@efi.com>
To: "'Michael'" <trott@bigpond.net.au>; <linux-mips@linux-mips.org>
Sent: Thursday, August 07, 2003 5:08 AM
Subject: RE: debuging problems


> You seem to be having branches in jump delay slots. Also there are some
> loads in delay slots which I think might not be intentional. You might
want
> to check these.
>
> e.g.
> load in a branch/jump delay slot ( intentional ? )
> j r1
>
> cr:   li $13,0       #      clear line number
>
> e.g.
> branch in an jump delay slot (?)
> j r2
>
> r3:   bne $19,$10,exit      #       branch if line total != magic number
>
> Thanks
>
> Ranjan
>
> -----Original Message-----
> From: Michael [mailto:trott@bigpond.net.au]
> Sent: Tuesday, August 05, 2003 9:10 PM
> To: linux-mips@linux-mips.org
> Subject: debuging problems
>
>
> i have written a mips program to verify if a given input is a magic
square,
>
> a magic square is a n*n matrix whose values are from 1..n^2, and each
> row/column diagonal gives the same sum, this sum is know as the magic
> number.
>
> All my program does is go through and sum each of the rows then each of
the
> columns,  at every stage the sum of the row or column in question is
> compared to the magic number, if not equal then not valid magic square.
the
> formula is given in my doco.
>
> im having problems working out what the actual  problem is. I've
completely
> coded it and spent alot of time steping through it but i cant see any
> problems. regardless of the input, the result is always negative.
>
> just wondering has anyone got any suggestions, any help would be greatly
> appreicated :)
>
> ive pasted my program at the bottom of this,
>
> thanks everyone
>
> michael
>
> _______________________________________________________________
>
>
>
> #      Program Name:      Magic Square Verifier
> #
> #      Author:                 Michael
> #
> #                       The purpose of this program is to determine
whether
> or not
> #                       a given input is a valid magic square.
> #
> #                       The start address for the matrix is to be given in
> $8, with
> #                       the size of the matrix supplied in $9. Major row
> #                       representation must be used to store the matrix
> values.
> #
> #                       At completeion of the program, $11 will store the
> #                       result of the program. if $11 == 1, then input was
a
> #                       valid magic square, if $11 == 0, the input was not
a
> valid
> #                       magic square.
> #
> #                       for more details, plese consult the attached
program
> #                       description file
>
>
>
>
>       .text
>
> main: li $11,0             #      is magic square = 0
>       li $12,2             #      temporary
>       li $13,0             #      Line number
>       li $14,0             #      temporary
>       li $16,0             #      Line position
>       li $17,0             #      start address + offset
>       li $18,4             #      constant 4
>       li $19,0             #      Line total
>
>
>                               #       Calculation of magic number for
> specified n
>       mul $10,$9,$9         #      n^2
>       addi $10,$10,1         #      (n^2)+1
>       mul $10,$10,$9        #      ((n^2)+1)n
>       divu $10,$10,$12       #      (((n^2)+1)n)/2 == magic_number
>       addi $15,$9,1          #      n+1
>
> r1:   beq $13,$9,cr         #      branch if line# == n
>
> r2:   beq $16,$9,r3         #       branch when line_pos == n
>
>
>       mul $12,$13,$9        #      line# . n
>       add $12,$12,$16       #      (line # . n)+ line_pos
>       mul $12,$12,$18       #      ((line # . n)+ line_pos)4
>       add $17,$8,$12        #      start address + offset
>       lw $23, 0($17)       #       load word, viz[i], into $17
>       add $19,$19,$23       #       line_total = line_total + viz[i]
>       addi $16,$16,1         #      line_position ++
>       j r2
>
> r3:   bne $19,$10,exit      #       branch if line total != magic number
>       addi $13,$13,1         #      line# ++
>       li $16,0       #       set line_pos
>       j r1
>
> cr:   li $13,0       #      clear line number
>       li $16,0       #      clear line position
>       li $19,0       #      clear line total
>
> c1:   beq $13,$9,sum       #      branch if line# == n
>
> c2:   beq $16,$9,c3         #      branch if line# == n
>
>
>       mul $12,$9,$18        #      n . 4
>       mul $12,$12,$16       #      (n . 4) . line_position
>       mul $14,$13,$18       #       line# . 4
>       add $12,$12,$14       #      ((n . 4) . line_position)+( line# . 4)
>       add $17,$12,$8        #      start address + offset
>       lw $23,0($17)        #       load word, viz[i], into $17
>       add $19,$19,$23       #      start address + offset
>       addi $16,$16,1         #       line_total = line_total + viz[i]
>       j c2
>
> c3:   bne $19,$10,exit      #      branch if line_total != magic_number
>       addi $13,$13,1         #      line# ++
>       li $16,0       #      clear line _pos
>       j c1
>
> sum:  li $12,0
>       li $14,0
>       add $17,$8,$0
>
> s1:   beq $12,$9,s2         #       branch if counter == n
>       lw $23,0($17)        #      load word, viz[i], into $17
>       add $14,$14,$23       #      seq_total = seq_total +  viz[i]
>       addi $17,$17,4         #      viz[i] = viz[i + 1]
>       addi $12,$12,1         #      counter ++
>       j s1
>
> s2:   li $16,0       #       total
>       li $19,1       #      i of n
>
>
> s3:   beq $19,$15,s4        #      branch if (i of n ) == (n + 1)
>       add $16,$16,$19       #      total = total +  (i of n )
>       addi $19,$19,1         #      (i of n ) ++
>
> s4:   bne $16,$14,exit
>
> dc:   li $12,0
>       li $13,0
>       li $16,0
>       li $19,0
>
>       mul $14,$15,$18       #     (n + 1) 4
>       add $17,$8,$0         #     copy start addr to $17
>
> d1:   beq $13,$9,d2         #      branch if line# == n
>
>       lw $23,0($17)        #       load word, viz[i], into $17
>       add $19,$19,$23       #       diag_total = diag_total + viz[i]
>       add $17,$17,$14       #       viz[i] = viz[i+1]
>       addi $13,$13,1         #       line# ++
>       j d1
>
> d2:   bne $19,$10,exit      #       branch if diagonal_total !=
> magic_number
>       j complete                #       else complete, therefore input is
> magic square
>
>
> complete:      li $11,1
>
> exit:
>
>
>
>
