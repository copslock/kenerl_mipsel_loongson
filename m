Received:  by oss.sgi.com id <S553847AbQKCNhj>;
	Fri, 3 Nov 2000 05:37:39 -0800
Received: from mx.mips.com ([206.31.31.226]:16542 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553843AbQKCNhe>;
	Fri, 3 Nov 2000 05:37:34 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA11417;
	Fri, 3 Nov 2000 05:36:54 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA06990;
	Fri, 3 Nov 2000 05:37:11 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id OAA21463;
	Fri, 3 Nov 2000 14:35:49 +0100 (MET)
Message-ID: <3A02BF34.6D0B52D5@mips.com>
Date:   Fri, 03 Nov 2000 14:35:49 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: ATLAS board!
References: <3A032BBF.4D0613B5@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The loader in the prom-monitor (YAMON), doesn't understand the elf-format,
you have to convert your kernel image to a SREC format.
You can do it the following way:

objcopy -O srec vmlinux vmlinux.srec

/Carsten



Nicu Popovici wrote:

> Hello ,
>
> I have an Atlas board with a mips processor. I managed to cross compile
> a MIPS kernel on our I686 machines but when I try to load the kernel
> image on the mips with the following command ( I do not know other way
> and if there is one please let me know ) "load
> tftp:/linux/mipseb/vmlinux "  I get the following error
>
> About to load tftp://192.168.200.1/linux/mipseb/di_vmlinux5000
> Press Ctrl-C to break
> Error : Line too long
> Diag  : Line 1, ELF
>
> Can anyone help me ?
>
> Regards,
> Nicu

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
