Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 23:54:47 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:2992 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20031981AbYBLXyj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Feb 2008 23:54:39 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 03A2C313C64;
	Tue, 12 Feb 2008 23:54:43 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 12 Feb 2008 23:54:42 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Feb 2008 15:54:23 -0800
Message-ID: <47B231AD.5050809@avtrex.com>
Date:	Tue, 12 Feb 2008 15:54:21 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Matteo Croce <rootkit85@yahoo.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Can't execute any MIPS  binary
References: <200802130034.25052.rootkit85@yahoo.it>
In-Reply-To: <200802130034.25052.rootkit85@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2008 23:54:23.0337 (UTC) FILETIME=[978F4D90:01C86DD2]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Matteo Croce wrote:
> Hi,
> I have a machine, an AR7 MIPS router I want to hack, but I'm unable
> to run _any_ executable on that machine outside the ones in the firmware.
> I tried building a static mips1 binary, but it fails so:
> 
> # /var/test.bin
> /var/test.bin: 1: Syntax error: "(" unexpected
> 
> so I downloaded a binary builtin in the firmware and I compared it to my own:
> 
> $ file busybox.bin test.bin
> busybox.bin: ELF 32-bit LSB executable, MIPS, MIPS-I version 1 (SYSV), dynamically linked (uses shared libs), stripped
> test.bin:    ELF 32-bit LSB executable, MIPS, version 1 (SYSV), statically linked, stripped
> 
> busybox.bin is the builtin busybox while test.bin is a static HelloWorld
> 
> I ran readelf on it:
> 
> $ readelf -h busybox.bin
> ELF Header:
>   Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF32
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              EXEC (Executable file)
>   Machine:                           MIPS R3000
>   Version:                           0x1
>   Entry point address:               0x4037e0
>   Start of program headers:          52 (bytes into file)
>   Start of section headers:          337304 (bytes into file)
>   Flags:                             0x5, noreorder, cpic, mips1
>   Size of this header:               52 (bytes)
>   Size of program headers:           32 (bytes)
>   Number of program headers:         6
>   Size of section headers:           40 (bytes)
>   Number of section headers:         21
>   Section header string table index: 20
> $ readelf -h test.bin
> ELF Header:
>   Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF32
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              EXEC (Executable file)
>   Machine:                           MIPS R3000
>   Version:                           0x1
>   Entry point address:               0x400140
>   Start of program headers:          52 (bytes into file)
>   Start of section headers:          11780 (bytes into file)
>   Flags:                             0x50001007, noreorder, pic, cpic, o32, mips32
>   Size of this header:               52 (bytes)
>   Size of program headers:           32 (bytes)
>   Number of program headers:         3
>   Size of section headers:           40 (bytes)
>   Number of section headers:         17
>   Section header string table index: 16
> $ diff -u <(readelf -h busybox.bin) <(readelf -h test.bin)
> --- /dev/fd/63  2008-02-13 00:26:48.880261477 +0100
> +++ /dev/fd/62  2008-02-13 00:26:48.880261477 +0100
> @@ -8,13 +8,13 @@
>    Type:                              EXEC (Executable file)
>    Machine:                           MIPS R3000
>    Version:                           0x1
> -  Entry point address:               0x4037e0
> +  Entry point address:               0x400140
>    Start of program headers:          52 (bytes into file)
> -  Start of section headers:          337304 (bytes into file)
> -  Flags:                             0x5, noreorder, cpic, mips1
> +  Start of section headers:          11780 (bytes into file)
> +  Flags:                             0x50001007, noreorder, pic, cpic, o32, mips32
>    Size of this header:               52 (bytes)
>    Size of program headers:           32 (bytes)
> -  Number of program headers:         6
> +  Number of program headers:         3
>    Size of section headers:           40 (bytes)
> -  Number of section headers:         21
> -  Section header string table index: 20
> +  Number of section headers:         17
> +  Section header string table index: 16
> 
> The router firmware uses:
> # cat /proc/version
> Linux version 2.4.17_mvl21-malta-mips_fp_le (root@localhost.localdomain) (gcc version 2.95.3 20010315 (release/MontaVista)) #1 Fri Mar 18 11:00:12 EST 2005
> 

IIRC, the definitions of the elf flags were wrong in 2.4.x (x < 20 or 25 
or something like that).  I had similar problems.

You should be able to run the binary if run a binary editor on it and 
clear the mips32 flag (i.e. change the flags from 0x50001007 to just 
0x1007).

If you want to generate the program with out the mips32 flag in the 
first place you have to compile everything (libc, libgcc crt*.o, program 
) with -mips1

It may be easier to run a program that post processes the executable to 
clear the flag.


David Daney
