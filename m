Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2003 13:03:11 +0000 (GMT)
Received: from audi.ibcp.fr ([IPv6:::ffff:193.51.160.127]:31448 "EHLO
	audi.ibcp.fr") by linux-mips.org with ESMTP id <S8225376AbTKLNCj> convert rfc822-to-8bit;
	Wed, 12 Nov 2003 13:02:39 +0000
Received: from gdeleage6.ibcp.fr (pc-bioinfo1.ibcp.fr [193.51.160.63])
	by audi.ibcp.fr (Postfix) with ESMTP id 94D3C7B391
	for <linux-mips@linux-mips.org>; Wed, 12 Nov 2003 14:02:38 +0100 (CET)
From: BETTLER Emmanuel <e.bettler@ibcp.fr>
Reply-To: e.bettler@ibcp.fr
Organization: IBCP - UCBL
To: linux-mips@linux-mips.org
Subject: O2 and Linux boot problem
Date: Wed, 12 Nov 2003 14:02:38 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311121402.38460.e.bettler@ibcp.fr>
Return-Path: <e.bettler@ibcp.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: e.bettler@ibcp.fr
Precedence: bulk
X-list: linux-mips

Hi,
i'm trying to install linux on a O2 (IP32, 300 Mhz R5000 with FPU, 128 M 
Memory) but until now without a lot of success.
With NetBSD, from the Boot CDRom 
(ftp://ftp.ayamura.org/people/ayamura/NetBSD/sgimipscd-1.6.1.iso.gz), i've an 
error message:
Cannot load scsi(0)disk(4)rdisk(0)partition(8)/boot.
Range check failure: section start 0x88002000, size 0xc460
Section would overwrite an already loaded program
Unable to execute scsi(0)disk(4)rdisk(0)partition(8)/boot: not enough space
etc...
parameters in the PROM were:
setenv SystemPartition scsi(0)disk(4)rdisk(0)partition(8)
setenv OSLoadPartition scsi(0)disk(4)rdisk(0)partition(0)
setenv OSLoader boot
setenv OSLoadFilename netbsd
setenv OSLoadOptions auto
boot

hum.. may be the wrong kernel, so with a boot -f boot.ip3
kernel was loaded and a kernel panic occured:
...
Exception: <vector=Normal>
Status register: 0x34010082<CU1,CU0,FR,DE,IPL=8,KX,MODE=KERNEL>
cause register: 0x8000801c<BD,CE=0,IP8,EXC=DBE>
Exception PC: 0x800094c0, Exception RA: 0x80003a68
Instruction Bus error
Saved user regs in hex (&gpda 0x810617d8, &_regs 0x810619d8):
arg: 81070000 0 1000 0
tmp: 81070000 1000 8000e610 59b1f0 8806a000 0 8000e3e0 a13fa538
sve: 81070000 c10696f4 0 461052d2 0 c11eb9a8 0 bf8ee226
t8 81070000 t9 0 at 0 v0 c108dbfe v1 0 k1 4
gp 81070000 fp 0 sp 0 ra 0

PANIC: Unexpected exception

i've tried also gentoo and debian but problem with the kernel was the same 
(not enough space or kernel panic with an automatic reboot so no error 
message available !!)
i'm waiting for any suggestion, kernel to boot etc..
the only kernel that seems to be ok is here:
http://www.linux-mips.org/~glaurung/
(2.5.47) but i don't know how to connect this kernel with an install process 
like with netbsd or debian.

help is welcome,

Manu


-- 
Dr. Emmanuel BETTLER
http://pbil.ibcp.fr/~bettler
Tel +33 (0)4 72 72 26 47 Fax +33 (0)4 72 72 26 04

Pôle BioInformatique Lyonnais Lyon Gerland (http://pbil.ibcp.fr)
Institut de Biologie et Chimie des Protéines (http://www.ibcp.fr)
7 passage du Vercors 69367 LYON cedex 7
FRANCE 
