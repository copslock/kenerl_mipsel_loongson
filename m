Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 14:30:17 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:63173 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491092Ab0EUMaO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 May 2010 14:30:14 +0200
Received: by pzk35 with SMTP id 35so432318pzk.0
        for <linux-mips@linux-mips.org>; Fri, 21 May 2010 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=kEuRXNBGhWH2xRanqeA1VpOy6dZxeM4uP/jzs9lLt8M=;
        b=BmFSNpjz7IzPwpt1I0g4F9PeEvWxg2TAc1oDocNGiCdf1whdtGflD+/K2YCiUeUfjR
         JlBR8ws48RiGEWPPjWFczU7Rd6bn5tnrUaHQtJW9kHhQmFIwMbwTLgo8TxeLp6+k9w/v
         /xcchhRVLzeFCkuCi3i9Tu61qChyR9Q7s1qno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=STv4Y49mTMw1w+7+LpDBdRKTm+0ZPi20HPCTG+8HkBezofmDbMcb0Pau5b63WJKwg9
         xWjtRk6iq+IEgUn/Rk5Sp2Hzg1PGLXxjpFekBmwQ3eBwYJDVgOKRCiVAE3yo4kDycA5e
         YgoSWVH+cE7ePk/13MQ2wkvJ6qIxIQ3Zy7CrY=
Received: by 10.115.38.22 with SMTP id q22mr1301226waj.41.1274445006218;
        Fri, 21 May 2010 05:30:06 -0700 (PDT)
Received: from [192.168.2.228] ([202.201.14.140])
        by mx.google.com with ESMTPS id f11sm8409615wai.23.2010.05.21.05.30.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 05:30:05 -0700 (PDT)
Subject: Re: MIPS/Linux assembly issue
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     adnan iqbal <adnan.iqbal@seecs.edu.pk>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <AANLkTikrUGzUykZJwoK3Jq9mEJa6l35jo5DXHae3vbIG@mail.gmail.com>
References: <AANLkTikrUGzUykZJwoK3Jq9mEJa6l35jo5DXHae3vbIG@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 21 May 2010 20:30:01 +0800
Message-ID: <1274445001.9403.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Just found Arnaud have explained the problems, so here give you an
example I have written one year ago:

# File: hello.s -- Say Hello to MIPS Assembly Language Programmer
# Author: falcon <wuzhangjin@gmail.com>, 2009/01/17
# Ref: 
#    [*] http://www.tldp.org/HOWTO/Assembly-HOWTO/mips.html
#    [*] MIPS Assembly Language Programmer's Guide
#    [*] See MIPS Run Linux(second version)
# Compile:
#       $ gcc -o hello hello.s
#       or
#       $ as -o hello.o hello.s
#       $ ld -e main -o hello hello.o

    .text
    .globl main
main:

    .set noreorder
    .cpload $gp       # setup the pointer to global data
    .set reorder
                      # print sth. via sys_write
    li $a0, 1         # print to standard ouput 
    la $a1, stradr    # set the string address
    lw $a2, strlen    # set the string length
    li $v0, 4004      # index of sys_write: 
                      # __NR_write in /usr/include/asm/unistd.h
    syscall           # causes a system call trap.

                      # exit via sys_exit
    move $a0, $0      # exit status as 0
    li $v0, 4001      # index of sys_exit
                      # __NR_exit in /usr/include/asm/unistd.h
    syscall

    .rdata
stradr: .asciiz "hello, world!\n"
strlen: .word . - stradr  # current address - the string address
# end

Regards,
	Wu Zhangjin

On Fri, 2010-05-21 at 16:46 +0500, adnan iqbal wrote:
> Hi all,
> 
> I am trying to compile/link/execute following very simple program in
> debian/MIPS (Tried on Qemu and Octeon). I am getting errors while
> executing the program. gdb also shows a strange behavior showing
> program entrypoint somehere in data segement. Any help getting this
> sorted out shall be appreciated.
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
> 
> __start:
>         jal f2
>         la $4,str
>         li $2,4
>         syscall
> 
>         ## terminate program via _exit () system call
>         li $2, 10
>         syscall
> f2:
>         add $8,$8,$0
>         jr $31
>      
