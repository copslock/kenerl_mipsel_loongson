Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 13:46:50 +0200 (CEST)
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43391 "HELO
        na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490949Ab0EULqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 May 2010 13:46:45 +0200
Received: from source ([209.85.214.178]) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
        ID DSNKS/ZynLBkGfHsS97L7qjwOGDGSBieA8Pj@postini.com; Fri, 21 May 2010 04:46:44 PDT
Received: by mail-iw0-f178.google.com with SMTP id 4so1008290iwn.23
        for <linux-mips@linux-mips.org>; Fri, 21 May 2010 04:46:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.176.213 with SMTP id bf21mr1005395ibb.67.1274442396233; 
        Fri, 21 May 2010 04:46:36 -0700 (PDT)
Received: by 10.231.119.39 with HTTP; Fri, 21 May 2010 04:46:36 -0700 (PDT)
Date:   Fri, 21 May 2010 16:46:36 +0500
Message-ID: <AANLkTikrUGzUykZJwoK3Jq9mEJa6l35jo5DXHae3vbIG@mail.gmail.com>
Subject: MIPS/Linux assembly issue
From:   adnan iqbal <adnan.iqbal@seecs.edu.pk>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e68dd8e85070050487193ef4
Return-Path: <adnan.iqbal@seecs.edu.pk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adnan.iqbal@seecs.edu.pk
Precedence: bulk
X-list: linux-mips

--0016e68dd8e85070050487193ef4
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I am trying to compile/link/execute following very simple program in
debian/MIPS (Tried on Qemu and Octeon). I am getting errors while executing
the program. gdb also shows a strange behavior showing program entrypoint
somehere in data segement. Any help getting this sorted out shall be
appreciated.

Regards
Adnan

Commands used to compile/link
----------------------------------------------------
$ as hello.s -o hello.o
$ld hello.o -o hello
$ ./hello


The code
---------------
      .data
str:
        .asciiz "hello world\n"
        .text
        .globl __start

__start:
        jal f2
        la $4,str
        li $2,4
        syscall

        ## terminate program via _exit () system call
        li $2, 10
        syscall
f2:
        add $8,$8,$0
        jr $31

--0016e68dd8e85070050487193ef4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I am trying to compile/link/execute following very simple pr=
ogram in debian/MIPS (Tried on Qemu and Octeon). I am getting errors while =
executing the program. gdb also shows a strange behavior showing program en=
trypoint somehere in data segement. Any help getting this sorted out shall =
be appreciated.<br>
<br>Regards<br>Adnan<br><br>Commands used to compile/link<br>--------------=
--------------------------------------<br>$ as hello.s -o hello.o<br>$ld he=
llo.o -o hello<br>$ ./hello<br><br><br>The code<br>---------------<br>=A0=
=A0=A0=A0=A0 .data<br>
str:<br>=A0=A0=A0=A0=A0=A0=A0 .asciiz &quot;hello world\n&quot;<br>=A0=A0=
=A0=A0=A0=A0=A0 .text<br>=A0=A0=A0=A0=A0=A0=A0 .globl __start<br><br>__star=
t:<br>=A0=A0=A0=A0=A0=A0=A0 jal f2<br>=A0=A0=A0=A0=A0=A0=A0 la $4,str<br>=
=A0=A0=A0=A0=A0=A0=A0 li $2,4<br>=A0=A0=A0=A0=A0=A0=A0 syscall<br><br>=A0=
=A0=A0=A0=A0=A0=A0 ## terminate program via _exit () system call<br>
=A0=A0=A0=A0=A0=A0=A0 li $2, 10<br>=A0=A0=A0=A0=A0=A0=A0 syscall<br>f2:<br>=
=A0=A0=A0=A0=A0=A0=A0 add $8,$8,$0<br>=A0=A0=A0=A0=A0=A0=A0 jr $31<br>=A0=
=A0=A0=A0 <br>

--0016e68dd8e85070050487193ef4--
