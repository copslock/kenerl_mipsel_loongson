Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 14:21:30 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:58951 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1490972Ab0EUMVY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 May 2010 14:21:24 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 07E93274041; Fri, 21 May 2010 14:21:23 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 0C73727403E;
        Fri, 21 May 2010 14:21:22 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 4311983DB2;
        Fri, 21 May 2010 14:40:07 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 64D8FFF855;
        Fri, 21 May 2010 14:21:47 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     adnan iqbal <adnan.iqbal@seecs.edu.pk>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS/Linux assembly issue
References: <AANLkTikrUGzUykZJwoK3Jq9mEJa6l35jo5DXHae3vbIG@mail.gmail.com>
Organization: Mandriva
Date:   Fri, 21 May 2010 14:21:47 +0200
In-Reply-To: <AANLkTikrUGzUykZJwoK3Jq9mEJa6l35jo5DXHae3vbIG@mail.gmail.com> (adnan iqbal's message of "Fri, 21 May 2010 16:46:36 +0500")
Message-ID: <m3d3wph2ck.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

adnan iqbal <adnan.iqbal@seecs.edu.pk> writes:

> Hi all,

Hi,
>
> I am trying to compile/link/execute following very simple program in
> debian/MIPS (Tried on Qemu and Octeon). I am getting errors while executing
> the program. gdb also shows a strange behavior showing program entrypoint
> somehere in data segement. Any help getting this sorted out shall be
> appreciated.
>
> Regards
> Adnan
>
> Commands used to compile/link
> ----------------------------------------------------
> $ as hello.s -o hello.o
> $ld hello.o -o hello
> $ ./hello
>
>
> The code
> ---------------
>       .data
> str:
>         .asciiz "hello world\n"
>         .text
>         .globl __start

Please consider adding ".ent __start" here

>
> __start:
>         jal f2
>         la $4,str
>         li $2,4

It's wrong here. On o32, write syscall is 4004. Also the args are:
$4: file descriptor (here 0)
$5: string
$6: string length

>         syscall
>
>         ## terminate program via _exit () system call
>         li $2, 10

exit is 4001. 4010 is unlink. Look at /usr/include/asm/unistd.h on your
mips system.

>         syscall

Add .end __start here if you've added the .ent


Arnaud
