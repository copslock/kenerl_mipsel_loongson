Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 May 2006 20:40:01 +0200 (CEST)
Received: from wx-out-0102.google.com ([66.249.82.207]:35752 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133816AbWEQSjx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 May 2006 20:39:53 +0200
Received: by wx-out-0102.google.com with SMTP id t13so216307wxc
        for <linux-mips@linux-mips.org>; Wed, 17 May 2006 11:39:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nz4huScarZTwaMDDqQ7yY6F+7O8EMbTG0w4rnjd4T0NfDVoX2bvAjN6u1fYUhes94IJmVBRiPdhmHWJ1aeS1KuP5p5IcJIX1g8bgGcNPHFSw8XIkQmcPqDEL7ZAh0rUTfoYAXp+c7JDCm4ElxoHYPqTUlfgXO62P2P4mhJpPlUE=
Received: by 10.70.47.14 with SMTP id u14mr1544541wxu;
        Wed, 17 May 2006 11:39:47 -0700 (PDT)
Received: by 10.70.22.3 with HTTP; Wed, 17 May 2006 11:39:46 -0700 (PDT)
Message-ID: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com>
Date:	Wed, 17 May 2006 11:39:47 -0700
From:	"Tony Lin" <lin.tony@gmail.com>
To:	"Daniel Jacobowitz" <dan@debian.org>
Subject: Re: Can't debug core files with GDB
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060517133402.GA2480@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <404548f40605161702y199c34a5wa89ec5f84cdeee09@mail.gmail.com>
	 <20060517133402.GA2480@nevyn.them.org>
Return-Path: <lin.tony@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lin.tony@gmail.com
Precedence: bulk
X-list: linux-mips

Objdump didn't yield any useful information, perhaps I didn't set the
flags correctly to show all the private registers.

You may be right about the kernel generated core file though. I
checked the registerd in gdb, everything looks good except the program
counter was zero. I then modified the mips kernel to spit out the
registers when doing the coredump. A valid pc (0x4008c0) was there
when doing fs/exec.c:do_coredump()

printks from do_coredump()
-----------
bash-2.05a# killall -SIGSEGV nebtest
1:<6>

printing contents of pt_regs *regs
1:<6>cp0_status 0xdc13
1:<6>lo 0x0
1:<6>hi 0x0
1:<6>cp0_badvaddr 0x803fbda0
1:<6>cp0_cause 0x10801000
1:<6>cp0_epc 0x4008c0


Calling 'info registers' in gdb coredump
----------------------
Reading symbols from /lib/ld.so.1...done.
Loaded symbols for /lib/ld.so.1
#0  0x00000000 in ?? ()
(gdb) info registers
          zero       at       v0       v1       a0       a1       a2       a3
 R0   00000000 1000dc00 0000000f 00000000 0000000f 2aac1000 0000000f 00000000
            t0       t1       t2       t3       t4       t5       t6       t7
 R8   00000000 00000001 00000003 49276d20 68697320 00000000 00000000 7468656e
            s0       s1       s2       s3       s4       s5       s6       s7
 R16  2ab00230 7fff7e64 2ad09f50 004008d0 00000001 004007dc 00000000 1001f328
            t8       t9       k0       k1       gp       sp       s8       ra
 R24  00000003 00000000 fbad2a84 00000000 10008040 7fff7de0 7fff7de0 00400898
            sr       lo       hi      bad    cause       pc
      10801000 0000dc13 00000000 803fbda0 004008c0 00000000
           fsr      fir
      00000000 00000000
(gdb)

(gdb) x/32 0x4008c0
0x4008c0 <main+228>:    0x1000ffff      0x00000000      0x00000000
 0x00000000
0x4008d0 <__libc_csu_init>:     0x3c1c0fc0      0x279c7770
0x0399e021      0x27bdffd8
0x4008e0 <__libc_csu_init+16>:  0xafbf0020      0xafb1001c
0xafb00018      0xafbc0010
0x4008f0 <__libc_csu_init+32>:  0x8f998054      0x00000000
0x0320f809      0x00000000
0x400900 <__libc_csu_init+48>:  0x8fbc0010      0x8f838034
0x8f828040      0x00431023



The 0x4008c0 address doesn't look half bad, pointing within main(). So
it looks like the mips kernel had all the right registers values but
just didn't format it correctly in the core dump? It wrote the pc into
cause, cause into sr, and cp0_status into lo.


Thanks much,
- Tony

On 5/17/06, Daniel Jacobowitz <dan@debian.org> wrote:
> Check the contents of the core file with objdump?  I recall seeing at
> least one recent MIPS kernel which failed to save registers.  Take a
> look at the .reg section.
>
> --
> Daniel Jacobowitz
> CodeSourcery
>
