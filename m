Received:  by oss.sgi.com id <S553739AbQJROhU>;
	Wed, 18 Oct 2000 07:37:20 -0700
Received: from igw8.watson.ibm.com ([198.81.209.20]:41188 "EHLO
        igw8.watson.ibm.com") by oss.sgi.com with ESMTP id <S553725AbQJROhH>;
	Wed, 18 Oct 2000 07:37:07 -0700
Received: from sp1n189at0.watson.ibm.com (sp1n189at0.watson.ibm.com [9.2.104.62])
	by igw8.watson.ibm.com (8.9.3/8.9.3/05-14-1999) with ESMTP id KAA15392;
	Wed, 18 Oct 2000 10:37:05 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.251.57]) by sp1n189at0.watson.ibm.com (8.9.3/Feb-20-98) with ESMTP id KAA26326; Wed, 18 Oct 2000 10:37:05 -0400
Received: (from jimix@localhost)
	by kitch0.watson.ibm.com (AIX4.3/8.9.3/8.9.3/01-10-2000) id KAA53800;
	Wed, 18 Oct 2000 10:37:04 -0400
From:   jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14829.46470.128116.219939@kitch0.watson.ibm.com>
Date:   Wed, 18 Oct 2000 10:36:54 -0400 (EDT)
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: IRIX as(1) question (relavent to linux as well)
X-Mailer: VM 6.75 under 20.4 "Emerald" XEmacs  Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have no idea who to ask so I'd like to ask you, if you don't mind.

The following bug has gnu as(1) implications because it does not handle
the errata below at all.

I REALLY need information on the '-t5_nops_follow_br' for the
/usr/lib32/cmplrs/asm command.

It helps me with a bug in gcc-2.92.2 but I need to know if it does
anything else (details below).

Please feel free to forward this to anyone who might help.

-Jimi X

The key background information is that some mips processors have a bug
whereby a 64-bit shift after a 64-bit divide can cause the shift to
produce an incorrect result.

This is a known problem and the errata can be found on:
  http://www.mips.com/Documentation/R4000_3.0_2.2_PC_SC_errata.pdf
#28 on page 7

The mips/sgi assembler will cover for this by adding a nop
between a divide and a subsequent shift.

However, depending on how gcc is invoked (debug optimization) when it 
generates this sequence it may insert a lable between the divide and
the shift. The IRIX assembler no longer recognizes the sequence and
does not insert the the nop.

If we pass the IRIX assembler the '-t5_nops_follow_br' it solves the
problem forcing the nop and actually it results in two, which if
unrestricted could result in some serious performance issues.

We would like to know what else it will do to our other code, it seems
harmless, but we would like to know specifics if they are available.


here is a code sample with the label, remove the label and IRIX as(1)
insterts the nop, gnu as(1) does not.

	ddiv	$0,$2,$5
.alabel:
	dsll	$7,$7,32
