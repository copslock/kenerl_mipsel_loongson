Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Dec 2004 03:49:40 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:55814
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225435AbULDDte>; Sat, 4 Dec 2004 03:49:34 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CaQvI-0002HQ-00; Sat, 04 Dec 2004 04:49:28 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CaQvG-0006we-00; Sat, 04 Dec 2004 04:49:26 +0100
Date: Sat, 4 Dec 2004 04:49:26 +0100
To: Kaj-Michael Lang <milang@tal.org>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: arcboot initrd+iso9660+shell patch
Message-ID: <20041204034926.GJ8714@rembrandt.csv.ica.uni-stuttgart.de>
References: <001301c4d960$382122c0$54dc10c3@amos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301c4d960$382122c0$54dc10c3@amos>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kaj-Michael Lang wrote:
> Hi
> 
> The patch is kinda large so I won't send it to the list, unless
> it's ok? It is about 73k.
> 
> The patch does:
> - Add initrd support (arcboot.conf: initrd=/ramdisk.gz)
> - Add interactive/shell mode
>   - Load kernel
>   - Load ramdisk
>   - Edit kernel cmdline arguments
>   - ls
>   - help for list of commands
> - Add working iso9660 support
> - Unfinished romfs support
> - It's probably a mess
> - Probably has many bugs here and there
> - To start interactive mode boot with -i as parameter:
>   "arcboot -i"
> - Tested on IP32 only (and patch changes default to IP32 :)
> 
> http://home.tal.org/~milang/o2/patches/arcboot_onion_iso_shell_initrd-1.patch

Great! A few comments, though:

 - About CFLAGS: Using -g is almost always a good idea, even if you strip
   the binaries afterwards. Using -march=mips3 is a bad idea if we ever
   want to support Indigo1 etc. It also breaks build with older compilers,
   and doesn't provide any relevant performance gain.
 - _PARM_LIMIT was 32 to match the kernel param limit. If you change it to
   allow more for arcboot, make sure it complains if more than 32 params
   are passed to the kernel.
 - ARC_CDROM/ARC_DISK shouldn't have a leading pci(0) for ip22, PROMPT
   should be arcboot@ip22 in that case.
 - Default SUBARCH should remain ip22. Better: Build both unconditionally
   unless overridden by a SUBARCH setting.
 - The tip22 stuff is broken (at least: doesn't match what's in CVS).


Thiemo
