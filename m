Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 14:01:25 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:27009
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225365AbUBAOBY>; Sun, 1 Feb 2004 14:01:24 +0000
Received: (qmail 14472 invoked by uid 204); 2 Feb 2004 00:01:13 +1000
Received: from stuartl@longlandclan.hopto.org by www by uid 201 with qmail-scanner-1.16 
 (clamscan: 0.60. spamassassin: 2.61.  Clear:. 
 Processed in 0.43109 secs); 01 Feb 2004 14:01:13 -0000
Received: from unknown (HELO longlandclan.hopto.org) (192.168.0.1)
  by 192.168.5.1 with SMTP; 2 Feb 2004 00:01:12 +1000
Message-ID: <401D06A6.4050905@longlandclan.hopto.org>
Date: Mon, 02 Feb 2004 00:01:10 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux MIPS Mailing list <linux-mips@linux-mips.org>
Subject: Problems with LCD panel & SCSI support with Linux 2.4.24-pre2 on
 Cobalt Qube II
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi All,
	Just the other day, I dragged out the old Gateway Microserver I have
here (a rebadged Cobalt Qube II) with the idea of setting it up as a
fileserver.

	I opened the box and dropped in an Advansys PCI SCSI card (I don't
recall the exact model) into the PCI slot, with the intent of hooking up
external SCSI drives.  I also replaced the HDD with a 40GB IBM Deskstar
I had sitting around.  On loading Debian Woody, I discover that there is
no SCSI support in the kernel, so I set about building one.

	Managed to cross compile 2.4.18 with the media patches, etc -- All
seemed to work, apart from SCSI.  modprobe advansys would complain that
the card was not present.  I also experienced hard lockups when I tried
dumping some large files to it over the LAN.

	Upgraded it to Linux 2.4.24-pre2 (CVS checkout from linux-mips done 6th
January, 2004) -- This seems to have corrected the hard lockups I had
previously, however, the SCSI card still doesn't work and now the LCD
panel on the back no-longer functions.

	I have uploaded what information I have (including output from
logfiles, lspci output, modprobe output, my toolchain versions, the
kernel config used, etc) to
http://www.longlandclan.hopto.org/~stuartl/mipsel-errors/.

	The toolchain was created on a i686-pc-linux-gnu host using the
crossdev.sh script on Gentoo Linux.  The kernel used was patched using
patches from http://people.debian.org/~pm/mips-cobalt/kernel/

	Is there anything I might have missed in trying to set this up?  I'm
fairly new to the MIPS architecture, this is the first time I managed to
get a custom MIPS kernel to boot correctly in a usable manner.  I've
noticed comments that the Cobalt support is suffering some "bit rot" and
hence, it has been quite shakey lately (well, for me anyway), however
I'd like to help out with ironing out these problems if possible.

Thanks,
- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Atomic Linux Project    <--->    http://atomicl.berlios.de/ |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAHQamuarJ1mMmSrkRAqywAJ0UElNVynKCWy+eM0XkTHiF3+XEvwCdF0jf
kisAh5RcXv53aK/ogycmPVk=
=rxip
-----END PGP SIGNATURE-----
