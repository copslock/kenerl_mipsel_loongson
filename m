Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2007 07:36:02 +0100 (BST)
Received: from host224-147-dynamic.60-82-r.retail.telecomitalia.it ([82.60.147.224]:64260
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20027149AbXH0Gfy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Aug 2007 07:35:54 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IPYCT-0002W7-3q
	for linux-mips@linux-mips.org; Mon, 27 Aug 2007 08:35:50 +0200
Subject: Re: Exception while loading kernel
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <1188030215.13999.14.camel@scarafaggio>
References: <1188030215.13999.14.camel@scarafaggio>
Content-Type: text/plain
Date:	Mon, 27 Aug 2007 08:36:03 +0200
Message-Id: <1188196563.2177.13.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
I compiled the latest kernel 2.6.22.4 from www.kernel.org and 2.6.23-rc3
from linux-.mips.org using the .config from Debian
linux-image-2.6.22-1-r5k_ip32 and activating CONFIG_NFSD_V4 and a few
network device drivers.

The command I used to compile was:

$ fakeroot make-kpkg --revision 2:2.6.22 \
	--append-to-version -1gs-r5k-ip32 --arch-in-name buildpackage

When I boot an SGI O2 r5k with any of those kernel, I get this error message:
---------------------------------------------------------------------------
Loading 64-bit executable
Loading program segment 1 at 0x80005000, offset=0x0 4000, size = 0x0 4f8086
5dc000      (cache: 95.0%)Zeroing memory ar 0x82f611, size 0 0x0
Starting ELF64 kernel

Exception: <vector=Normal>
Status register: 0x34010082<CU1,CU0,FR,DE,IPL=8,KX,MODE=KERNEL>
Cause register: 0x8014<CE=0,IP8,EXC=WADE>
Exception PC: 0x802204fc, Exception RA: 0x804da7ac
Write address error exception, bad address: 0xfffff000
  Saved user regs in hex (&gpda 0x81060e08, &_regs 0x81061008):
  arg: 81070000 0 804ff518 1
  tmp: 81070000 1000 80516868 fff8054b ffffffff 81412ef4 a13fb0d0 8
  sve: 81070000 4083ae51 0 4608a976 0 0 0 80ee80d5
  t8 81070000 t9 0 at 0 v0 0 v1 0 k1 fffff000
  gp 81070000 fp 0 sp 0 ra 0

PANIC: Unexpected exception

[Press reset or ENTER to restart.]
---------------------------------------------------------------------------

If I understand correctly the problem happened at address 0x802204fc, so
I checked the system.map file and found
ffffffff802204c4 T __bzero
ffffffff80220524 t memset_partial

If I understand correctly, the kernel was executing the __bzero function
and tried accessing the invalid address 0xfffff000.

Other, maybe useful, addresses from system.map are:

ffffffff804da6e8 t init_bootmem_core
ffffffff804da7c8 t $L99

ffffffff80516868 b contig_bootmem_data

ffffffff804ff4e8 B boot_mem_map
ffffffff804ff7f0 B fw_arg0

>From these number, I guess that boot_mem_map contain an invalid address.
Is this correct?

Bye,
Giuseppe
