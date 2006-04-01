Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2006 20:58:03 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.239]:34991 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133554AbWDAT5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Apr 2006 20:57:52 +0100
Received: by wproxy.gmail.com with SMTP id 36so1049793wra
        for <linux-mips@linux-mips.org>; Sat, 01 Apr 2006 12:08:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q5Vq70zZGkc5cNMKh027fPOI3Vqe2KZ4Uk48VM75Y0ia1XLYZypDAiU8gdzEK+Vda2vRCefEGlcrs/j1t1gHwN7BtBvtDnH4gacliNG/Fo6dQrKgfbX90A7QiXLdveoEoN1upLFQRgG+NsN0IvAVZKAN4p8lp054mqlWfV+e7MQ=
Received: by 10.65.205.15 with SMTP id h15mr96510qbq;
        Sat, 01 Apr 2006 12:08:44 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sat, 1 Apr 2006 12:08:44 -0800 (PST)
Message-ID: <85e0e3140604011208o20155cfblcadae4b19e8360dc@mail.gmail.com>
Date:	Sun, 2 Apr 2006 01:38:44 +0530
From:	Niklaus <niklaus@gmail.com>
To:	linux-mips@linux-mips.org
Subject: elocation truncated relocation truncated to fit: R_MIPS_GOT16
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <niklaus@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklaus@gmail.com
Precedence: bulk
X-list: linux-mips

 Hi,

 I setup cross compilation environment for mips and did a make . Why do
 i get the last following error relocation truncated to fit errors.

 http://www.toppers.jp/download.cgi/jsp-1.4.1.tar.gz is the place where
 i got the file.
 The first steps are
 tar xvzf jsp-1.4.1.tar.gz
 cd jsp
 ./configure -C mips3 -S vr4131
 cd cfg
 make
 cd ..
 make depend
 make


 pro@deb:~/jsp$ make
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./kernel ./config/mips3/exception_vector.S
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 sample1.c
 sample1.c: In function `task':
 sample1.c:160: warning: division by zero
 sample1.c:165: warning: division by zero
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./systask/timer.c
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./systask/serial.c
 In file included from ./systask/serial.c:45:
 ./config/mips3/vr4131/hw_serial.h: In function `sio_cls_por':
 ./config/mips3/vr4131/hw_serial.h:115: warning: the address of
 `vr4131_dsiu_openflag', will always evaluate as `true'
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./systask/logtask.c
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./library/log_output.c
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./library/vasyslog.c
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./library/t_perror.c
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./systask ./library/strerror.c
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 kernel_cfg.c
 In file included from kernel_cfg.c:27:
 ./config/mips3/vr4131/hw_serial.h: In function `sio_cls_por':
 ./config/mips3/vr4131/hw_serial.h:115: warning: the address of
 `vr4131_dsiu_openflag', will always evaluate as `true'
 mips-deb-linux-gcc -S  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./kernel ./config/mips3/makeoffset.c
 ./utils/genoffset makeoffset.s > tmpfile3
 mv tmpfile3 offset.h
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./kernel ./config/mips3/vr4131/sys_support.S
 mips-deb-linux-gcc -c  -msoft-float -mgp32 -g -O2 -mips3 -G 0
 -DGDB_STUB -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3
 -I./kernel ./config/mips3/cpu_support.S
 ./config/mips3/cpu_support.S: Assembler messages:
 ./config/mips3/cpu_support.S:133: Warning: No .cprestore pseudo-op
 used in PIC code
 ./config/mips3/cpu_support.S:148: Warning: No .cprestore pseudo-op
 used in PIC code
 ./config/mips3/cpu_support.S:378: Warning: No .cprestore pseudo-op
 used in PIC code
 ./config/mips3/cpu_support.S:238: Warning: Pretending global symbol
 used as branch target is local.
 ./config/mips3/cpu_support.S:267: Warning: Pretending global symbol
 used as branch target is local.
 ./config/mips3/cpu_support.S:561: Error: Cannot branch to undefined symbol.
 make: *** [cpu_support.o] Error 1


 the file cpu_support.S :561
 i have  the instruction
 j       call_texrtn

 I commented it. I was not sure what i was doing.

 Then i got some error saying "elf32-littlemips" , i changed it to
 elf32-tradlittlemips because that was what ld supported as a target.
 I got the following error . Can anyone help me why this occurs and how
 to resolve this .



 mips-deb-linux-gcc  -msoft-float -mgp32 -g -O2 -mips3 -G 0  -DGDB_STUB
 -I. -I./include  -I./config/mips3/vr4131 -I./config/mips3 -nostdlib
 -T ./config/mips3/vr4131/vr4131_elf_gdb.ld -o jsp \
                         exception_vector.o  sample1.o     timer.o
 serial.o logtask.o log_output.o vasyslog.o t_perror.o strerror.o
 kernel_cfg.o   libkernel.a   -lgcc
 /home/pro/crossenv/bin/../lib/gcc/mips-deb-linux/3.4.6/../../../../mips-deb-linux/bin/ld:
 region ROM0 is full (jsp section .rodata.str1.4)
 /home/pro/crossenv/bin/../lib/gcc/mips-deb-linux/3.4.6/../../../../mips-deb-linux/bin/ld:
 section .rodata.str1.4 [00000000a00004dc -> 00000000a0001046] overlaps
 section .text [00000000a0000700 -> 00000000a0007faf]
 /home/pro/crossenv/bin/../lib/gcc/mips-deb-linux/3.4.6/../../../../mips-deb-linux/bin/ld:
 jsp: section .text lma 0xa0000700 overlaps previous sections
 /home/pro/crossenv/bin/../lib/gcc/mips-deb-linux/3.4.6/../../../../mips-deb-linux/bin/ld:
 jsp: section .rodata lma 0xa0007fb0 overlaps previous sections
 exception_vector.o:./config/mips3/exception_vector.S:74: relocation
 truncated to fit: R_MIPS_GOT16 against `reset'
 exception_vector.o:./config/mips3/exception_vector.S:80: relocation
 truncated to fit: R_MIPS_GOT16 against `reset'
 exception_vector.o:./config/mips3/exception_vector.S:96: relocation
 truncated to fit: R_MIPS_GOT16 against `_kernel_cpu_experr'
 exception_vector.o:./config/mips3/exception_vector.S:112: relocation
 truncated to fit: R_MIPS_GOT16 against `_kernel_cpu_experr'
 exception_vector.o:./config/mips3/exception_vector.S:128: relocation
 truncated to fit: R_MIPS_GOT16 against `_kernel_cpu_experr'
 exception_vector.o:./config/mips3/exception_vector.S:144: relocation
 truncated to fit: R_MIPS_GOT16 against `_kernel_general_exception'
 libkernel.a(start.o):./config/mips3/start.S:69: relocation truncated
 to fit: R_MIPS_GOT16 against `_stack_top'
 libkernel.a(start.o):./config/mips3/start.S:73: relocation truncated
 to fit: R_MIPS_GOT16 against `_gp'
 libkernel.a(start.o):./config/mips3/start.S:114: relocation truncated
 to fit: R_MIPS_GOT16 against `hardware_init_hook'
 libkernel.a(start.o):./config/mips3/start.S:124: relocation truncated
 to fit: R_MIPS_GOT16 against `__bss_start'
 libkernel.a(start.o):./config/mips3/start.S:125: additional relocation
 overflows omitted from the output
 collect2: ld returned 1 exit status
 make: *** [jsp] Error 1

Please note i used the -Wa,-xgot options to compile still it failed.
Can someone suggest me a work around. Is there anyway i can increase
the size. If yes where in gcc . Any help would be greatly appreciated.

 Regards
 Nik
