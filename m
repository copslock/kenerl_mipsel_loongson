Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2MMpF400338
	for linux-mips-outgoing; Fri, 22 Mar 2002 14:51:15 -0800
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2MMpBq00335
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 14:51:11 -0800
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (SGI-8.9.3/8.9.3) with ESMTP id XAA28295
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 23:53:33 +0100 (MET)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.34 #1 (Debian))
	id 16oXuf-0001f6-00
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 23:53:33 +0100
Date: Fri, 22 Mar 2002 23:53:33 +0100
To: linux-mips@oss.sgi.com
Subject: Re: Bug in Assertion failure in macro_build_lui ....tc-mips.c
Message-ID: <20020322225332.GA13314@rembrandt.csv.ica.uni-stuttgart.de>
References: <007201c1d1ee$83bb33f0$9d00a8c0@sathya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007201c1d1ee$83bb33f0$9d00a8c0@sathya>
User-Agent: Mutt/1.3.27i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Sathya.N wrote:
> 
>  Hi,
> 
>   I am building the qla2x00.c driver (Fibre channel driver from Qlogic) as
> loadable module for our IP under Red Hat Linux 7.2(kernel version is 2.4.x)
> We are  using the Broadcom's BCM12500 Processor (MIPS Core).When I compiled
> the code , I am getting the output as given below. After the warnings ,you
> could see {standard input} Assembler messages: etc.,

Which binutils (gas) version are you using?

> /home/sathya/linux/src/linux/include/linux/modsetver.h -I/home/sathya/linux/
> src/linux/include -I/home/sathya/linux/src/linux/include/../drivers/scsi -Wa
> ll -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -pipe -fno-
> strict-aliasing -mcpu=sb1 -mips2 -mgp32 -mlong32 -mips16 -EB -D__SMP__  -CON
> FIG_SMP     -c -o qla2x00.o qla2x00.c

Could you add "-v --save-temps" to this command to find out how the
assembler is invoked and what the assembly in qla2x00.s looks like?


Thiemo
