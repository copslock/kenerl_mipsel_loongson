Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 16:43:07 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:19520
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225205AbUIXPnB>; Fri, 24 Sep 2004 16:43:01 +0100
Received: (qmail 22303 invoked from network); 25 Sep 2004 01:42:50 +1000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 25 Sep 2004 01:42:50 +1000
Message-ID: <4154407A.4050204@longlandclan.hopto.org>
Date: Sat, 25 Sep 2004 01:42:50 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: "Stephen P. Becker" <geoman@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org> <41536765.9000304@longlandclan.hopto.org> <20040924090703.GA13468@paradigm.rfc822.org>
In-Reply-To: <20040924090703.GA13468@paradigm.rfc822.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Florian Lohoff wrote:
> On Fri, Sep 24, 2004 at 10:16:37AM +1000, Stuart Longland wrote:
>
>>Ahh yes... sorry, it was after midnight (GMT+10) and my mind must've
>>been elsewhere -- I meant o64.  I was planning on moving to either n32
>>or n64 userland eventually, but I won't do that unless I can get a
>>64-bit kernel going.
>
> The 64 bit kernel should work so far - With the ip22zilog.c fixes
> tsbogend just committed the console begins to work again.
>
> Includeing the patch i sent earlier my R5k Indy boots fine a 64bit
> current cvs head and goes into userspace.
>
> Using the "soo to be" rtc and statfs64 fixes everything seems to be
> fine for o32 userspace.

Tried the patch, for some reason 'patch' couldn't find some of the
files, and was expecting me to enter the paths in by hand... but once I
did that, it applied cleanly[1].

I still get much the same message from the PROM though:
- -------------------------------8<--------------------------------------
arcsboot: ARCS Linux ext2fs loader 0.3.8.2

Loading new from scsi(0)disk(1)rdisk(0)partition(0)
Allocated 0xe0 bytes for segments
Loading 64-bit executable
Loading program segment 2 at 0x88004000, offset=0x0 4000, size = 0x0 35b140
Loading program segment 3 at 0x88360020, offset=0x0 360020, size= 0x0 1c065
Zeroing memory at 0x8837c085 size = 0x21feb

Exception: <vector=Normal>
Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8010<CE=0,IP8,EXC=RADE>
Exception PC: 0x830f018, Exception RA: 0x88804514
Read address error exception, bad address: 0x830f018
Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: a8740000 88002000 88001fe0 18
  tmp: a8740000 2 8880e0b4 8360020 8880e0b0 887fe53c 887fe234 9fc55064
  sve: a8740000 3 400000 8000000 16 3f80 0 10000000
  t8 a8740000 t9 ffffffff at ffffffff v0 ffffffff v1 ffffffff k1 8360020
  gp a8740000 f0 ffffffff sp ffffffff ra ffffffff

PANIC: Unexpected exception

[Press reset or ENTER to restart.]
- ------------------------------->8--------------------------------------

Bypassing arcboot, I get:
- -------------------------------8<--------------------------------------
>> boot -f newlinux root=/dev/sda3

Exception: <vector=UTLB Miss>

Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
Exception PC: 0x9fc31644, Exception RA: 0x9fc3161c
exception, bad address: 0x8
Local I/O interrupt register 1: 0x80 <VR/GIO2>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: a8740000 0 0 887fe878
  tmp: a8740000 0 887fec2c 2d 887fe8d8 887fec20 a8746d10 9fc55064
  sve: a8740000 3 400000 8000000 16 3f80 0 10000000
  t8 a8740000 t9 ffffffff at ffffffff v0 ffffffff v1 ffffffff k1 0
  gp a8740000 f0 ffffffff sp ffffffff ra ffffffff

PANIC: Unexpected exception

[Press reset or ENTER to restart.]
- ------------------------------->8--------------------------------------

The latter one is very much like the one mentioned on the website I
quoted earlier... but as I mentioned then, the fix doesn't seem to apply
to the latest code.

I can't rule out it being something with my config though.  Has someone
got a working config for mips64 on this class of machine?  (even a
binary)  Seeing as it works on R5k, could we be dealing with an R4x00
bug here?
- --
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
1. except the Makefile and spaces.h files... it for some reason tried
patching linux/{Makefile,spaces.h} not linux/arch/... etc...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBVEB6uarJ1mMmSrkRAh6DAKCBBbry3yjtMkfZ9lFgGyfguSsPnwCeKRAz
UQOls5vmXNIkDNICUj77e80=
=+PVx
-----END PGP SIGNATURE-----
