Received:  by oss.sgi.com id <S553709AbRAGOWj>;
	Sun, 7 Jan 2001 06:22:39 -0800
Received: from router.isratech.ro ([193.226.114.69]:36359 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553682AbRAGOWW>;
	Sun, 7 Jan 2001 06:22:22 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id f07EM6l21409
	for <linux-mips@oss.sgi.com>; Sun, 7 Jan 2001 16:22:07 +0200
Message-ID: <3A58E9B1.459A33C1@isratech.ro>
Date:   Sun, 07 Jan 2001 17:12:02 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Loading srec imagine problem.
Content-Type: multipart/mixed;
 boundary="------------9AAF69DA117558ADC28E8C31"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------9AAF69DA117558ADC28E8C31
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello ,

I have now the following cross toolchain
binutils 2.10.1 - egcs.1.0.3a - glibc-2.0.6.

I manage to cross compile the kernel for mips and when I try to load the
srec imagine on the mips I get the following error.

For this srec imagine I used mips-linux-objcopy -O srec vmlinux
srecimagine.

****************************  Exception occurred
****************************

TLB exception (store)

CAUSE    = 0x8080000c
STATUS   = 0x00000403      EPC      = 0x80024a0c
BADVADDR = 0x000036e0      ERROREPC = 0x800131f0

$ 0(zr):0x00000000  $ 8(t0):0x00000081  $16(s0):0x80060000
$24(t8):0x80030f68
$ 1(at):0x00000000  $ 9(t1):0x80026178  $17(s1):0x80060f80
$25(t9):0x00000009
$ 2(v0):0x000036e0  $10(t2):0x00000000  $18(s2):0x0000003a
$26(k0):0x00000000
$ 3(v1):0x00000000  $11(t3):0x80108390  $19(s3):0x80032bd8
$27(k1):0x00000000
$ 4(a0):0x000036e4  $12(t4):0x80020000  $20(s4):0x0000d004
$28(gp):0x80037b98
$ 5(a1):0x80060ec4  $13(t5):0x00000081  $21(s5):0x00000002
$29(sp):0x80060e50
$ 6(a2):0x00000010  $14(t6):0x00000080  $22(s6):0x00000002
$30(s8):0x80030000
$ 7(a3):0x80060ed0  $15(t7):0x80026178  $23(s7):0x80030f68
$31(ra):0x8001f57c
***************************************************************************

What am I doing wrong here ?

Regards,
Nicu



--------------9AAF69DA117558ADC28E8C31
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------9AAF69DA117558ADC28E8C31--
