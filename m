Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2007 14:01:45 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:14051 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20022693AbXH0NBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Aug 2007 14:01:37 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A5A2D200A1EF;
	Mon, 27 Aug 2007 15:01:05 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29684-01-97; Mon, 27 Aug 2007 15:01:04 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 69BD7200A1C0;
	Mon, 27 Aug 2007 15:01:04 +0200 (CEST)
Message-ID: <46D2CB0F.7020505@27m.se>
Date:	Mon, 27 Aug 2007 15:01:03 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.12 (X11/20070730)
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Exception while loading kernel
References: <1188030215.13999.14.camel@scarafaggio> <1188196563.2177.13.camel@scarafaggio>
In-Reply-To: <1188196563.2177.13.camel@scarafaggio>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

What about trying 2.6.22 from linux-mips.org in first place?

//Markus

Giuseppe Sacco wrote:
> Hi all, I compiled the latest kernel 2.6.22.4 from www.kernel.org
> and 2.6.23-rc3 from linux-.mips.org using the .config from Debian
> linux-image-2.6.22-1-r5k_ip32 and activating CONFIG_NFSD_V4 and a
> few network device drivers.
>
> The command I used to compile was:
>
> $ fakeroot make-kpkg --revision 2:2.6.22 \ --append-to-version
> -1gs-r5k-ip32 --arch-in-name buildpackage
>
> When I boot an SGI O2 r5k with any of those kernel, I get this
> error message:
> ---------------------------------------------------------------------------
>  Loading 64-bit executable Loading program segment 1 at 0x80005000,
> offset=0x0 4000, size = 0x0 4f8086 5dc000      (cache:
> 95.0%)Zeroing memory ar 0x82f611, size 0 0x0 Starting ELF64 kernel
>
> Exception: <vector=Normal> Status register:
> 0x34010082<CU1,CU0,FR,DE,IPL=8,KX,MODE=KERNEL> Cause register:
> 0x8014<CE=0,IP8,EXC=WADE> Exception PC: 0x802204fc, Exception RA:
> 0x804da7ac Write address error exception, bad address: 0xfffff000
> Saved user regs in hex (&gpda 0x81060e08, &_regs 0x81061008): arg:
> 81070000 0 804ff518 1 tmp: 81070000 1000 80516868 fff8054b ffffffff
> 81412ef4 a13fb0d0 8 sve: 81070000 4083ae51 0 4608a976 0 0 0
> 80ee80d5 t8 81070000 t9 0 at 0 v0 0 v1 0 k1 fffff000 gp 81070000 fp
> 0 sp 0 ra 0
>
> PANIC: Unexpected exception
>
> [Press reset or ENTER to restart.]
> ---------------------------------------------------------------------------
>
>
> If I understand correctly the problem happened at address
> 0x802204fc, so I checked the system.map file and found
> ffffffff802204c4 T __bzero ffffffff80220524 t memset_partial
>
> If I understand correctly, the kernel was executing the __bzero
> function and tried accessing the invalid address 0xfffff000.
>
> Other, maybe useful, addresses from system.map are:
>
> ffffffff804da6e8 t init_bootmem_core ffffffff804da7c8 t $L99
>
> ffffffff80516868 b contig_bootmem_data
>
> ffffffff804ff4e8 B boot_mem_map ffffffff804ff7f0 B fw_arg0
>
>> From these number, I guess that boot_mem_map contain an invalid
>> address.
> Is this correct?
>
> Bye, Giuseppe
>
>


- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0ssO6I0XmJx2NrwRCBk2AKCxH0yLfT8oA8Eu4GXyuIn/jRpbYQCfUphJ
YfP0wfQiLu2Qd+tz8+PZHQM=
=ofTk
-----END PGP SIGNATURE-----
