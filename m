Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 05:13:28 +0100 (BST)
Received: from mta07bw.bigpond.com ([IPv6:::ffff:144.135.24.134]:29411 "EHLO
	mta07bw.bigpond.com") by linux-mips.org with ESMTP
	id <S8225201AbTHFENV>; Wed, 6 Aug 2003 05:13:21 +0100
Received: from titan ([144.135.24.87]) by mta07bw.email.bigpond.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0HJ600H48JL3KS@mta07bw.email.bigpond.com> for
 linux-mips@linux-mips.org; Wed, 06 Aug 2003 14:10:15 +1000 (EST)
Received: from cpe-203-45-209-27.qld.bigpond.net.au ([203.45.209.27])
 by bwmam07bpa.bigpond.com(MailRouter V3.2g 62/550314); Wed,
 06 Aug 2003 14:10:15 +0000
Date: Wed, 06 Aug 2003 14:10:19 +1000
From: Michael <trott@bigpond.net.au>
Subject: debuging problems
To: linux-mips@linux-mips.org
Reply-to: Michael <trott@bigpond.net.au>
Message-id: <003501c35bd0$a662bdc0$6400a8c0@titan>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Return-Path: <trott@bigpond.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trott@bigpond.net.au
Precedence: bulk
X-list: linux-mips

i have written a mips program to verify if a given input is a magic square,

a magic square is a n*n matrix whose values are from 1..n^2, and each
row/column diagonal gives the same sum, this sum is know as the magic
number.

All my program does is go through and sum each of the rows then each of the
columns,  at every stage the sum of the row or column in question is
compared to the magic number, if not equal then not valid magic square. the
formula is given in my doco.

im having problems working out what the actual  problem is. I've completely
coded it and spent alot of time steping through it but i cant see any
problems. regardless of the input, the result is always negative.

just wondering has anyone got any suggestions, any help would be greatly
appreicated :)

ive pasted my program at the bottom of this,

thanks everyone

michael

_______________________________________________________________



#      Program Name:      Magic Square Verifier
#
#      Author:                 Michael
#
#                       The purpose of this program is to determine whether
or not
#                       a given input is a valid magic square.
#
#                       The start address for the matrix is to be given in
$8, with
#                       the size of the matrix supplied in $9. Major row
#                       representation must be used to store the matrix
values.
#
#                       At completeion of the program, $11 will store the
#                       result of the program. if $11 == 1, then input was a
#                       valid magic square, if $11 == 0, the input was not a
valid
#                       magic square.
#
#                       for more details, plese consult the attached program
#                       description file




      .text

main: li $11,0             #      is magic square = 0
      li $12,2             #      temporary
      li $13,0             #      Line number
      li $14,0             #      temporary
      li $16,0             #      Line position
      li $17,0             #      start address + offset
      li $18,4             #      constant 4
      li $19,0             #      Line total


                              #       Calculation of magic number for
specified n
      mul $10,$9,$9         #      n^2
      addi $10,$10,1         #      (n^2)+1
      mul $10,$10,$9        #      ((n^2)+1)n
      divu $10,$10,$12       #      (((n^2)+1)n)/2 == magic_number
      addi $15,$9,1          #      n+1

r1:   beq $13,$9,cr         #      branch if line# == n

r2:   beq $16,$9,r3         #       branch when line_pos == n


      mul $12,$13,$9        #      line# . n
      add $12,$12,$16       #      (line # . n)+ line_pos
      mul $12,$12,$18       #      ((line # . n)+ line_pos)4
      add $17,$8,$12        #      start address + offset
      lw $23, 0($17)       #       load word, viz[i], into $17
      add $19,$19,$23       #       line_total = line_total + viz[i]
      addi $16,$16,1         #      line_position ++
      j r2

r3:   bne $19,$10,exit      #       branch if line total != magic number
      addi $13,$13,1         #      line# ++
      li $16,0       #       set line_pos
      j r1

cr:   li $13,0       #      clear line number
      li $16,0       #      clear line position
      li $19,0       #      clear line total

c1:   beq $13,$9,sum       #      branch if line# == n

c2:   beq $16,$9,c3         #      branch if line# == n


      mul $12,$9,$18        #      n . 4
      mul $12,$12,$16       #      (n . 4) . line_position
      mul $14,$13,$18       #       line# . 4
      add $12,$12,$14       #      ((n . 4) . line_position)+( line# . 4)
      add $17,$12,$8        #      start address + offset
      lw $23,0($17)        #       load word, viz[i], into $17
      add $19,$19,$23       #      start address + offset
      addi $16,$16,1         #       line_total = line_total + viz[i]
      j c2

c3:   bne $19,$10,exit      #      branch if line_total != magic_number
      addi $13,$13,1         #      line# ++
      li $16,0       #      clear line _pos
      j c1

sum:  li $12,0
      li $14,0
      add $17,$8,$0

s1:   beq $12,$9,s2         #       branch if counter == n
      lw $23,0($17)        #      load word, viz[i], into $17
      add $14,$14,$23       #      seq_total = seq_total +  viz[i]
      addi $17,$17,4         #      viz[i] = viz[i + 1]
      addi $12,$12,1         #      counter ++
      j s1

s2:   li $16,0       #       total
      li $19,1       #      i of n


s3:   beq $19,$15,s4        #      branch if (i of n ) == (n + 1)
      add $16,$16,$19       #      total = total +  (i of n )
      addi $19,$19,1         #      (i of n ) ++

s4:   bne $16,$14,exit

dc:   li $12,0
      li $13,0
      li $16,0
      li $19,0

      mul $14,$15,$18       #     (n + 1) 4
      add $17,$8,$0         #     copy start addr to $17

d1:   beq $13,$9,d2         #      branch if line# == n

      lw $23,0($17)        #       load word, viz[i], into $17
      add $19,$19,$23       #       diag_total = diag_total + viz[i]
      add $17,$17,$14       #       viz[i] = viz[i+1]
      addi $13,$13,1         #       line# ++
      j d1

d2:   bne $19,$10,exit      #       branch if diagonal_total !=
magic_number
      j complete                #       else complete, therefore input is
magic square


complete:      li $11,1

exit:
