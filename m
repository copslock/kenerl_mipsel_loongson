Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 19:34:51 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:10881
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225527AbUBATev>; Sun, 1 Feb 2004 19:34:51 +0000
Received: (qmail 18569 invoked by uid 204); 2 Feb 2004 05:34:31 +1000
Received: from stuartl@longlandclan.hopto.org by www by uid 201 with qmail-scanner-1.16 
 (clamscan: 0.60. spamassassin: 2.61.  Clear:. 
 Processed in 0.37343 secs); 01 Feb 2004 19:34:31 -0000
Received: from unknown (HELO longlandclan.hopto.org) (192.168.0.1)
  by 192.168.5.1 with SMTP; 2 Feb 2004 05:34:30 +1000
Message-ID: <401D54C6.40207@longlandclan.hopto.org>
Date: Mon, 02 Feb 2004 05:34:30 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Merker <karsten@excalibur.cologne.de>
CC: Linux MIPS Mailing list <linux-mips@linux-mips.org>
Subject: Re: Problems with LCD panel & SCSI support with Linux 2.4.24-pre2
 on Cobalt Qube II
References: <401D06A6.4050905@longlandclan.hopto.org> <20040201145448.GA1945@excalibur.cologne.de>
In-Reply-To: <20040201145448.GA1945@excalibur.cologne.de>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karsten Merker wrote:
| On Mon, Feb 02, 2004 at 12:01:10AM +1000, Stuart Longland wrote:
|
|
|>	Just the other day, I dragged out the old Gateway Microserver I have
|>here (a rebadged Cobalt Qube II) with the idea of setting it up as a
|>fileserver.
|
| [snip]
|
|>January, 2004) -- This seems to have corrected the hard lockups I had
|>previously, however, the SCSI card still doesn't work and now the LCD
|>panel on the back no-longer functions.
|
|
| The device id for the LCD panel has changed in newer kernel versions;
| the minor device id seems to be selected dynamically now:
|
| static struct miscdevice lcd_dev = {
|         MISC_DYNAMIC_MINOR,
|         "lcd",
|         &lcd_fops
| };
|
| HTH,
| Karsten
Hi,
	Thanks for that, this fixes the LCD problem, it's working fine now.  If
it's more dynamic, it looks like using devfs might be a better option --
although I'm trying to avoid enabling stuff that enlarges my kernel (I'm
at 600kB now).  At the moment, I'll see about putting a hack in the
scripts to recreate /dev/lcd at boot.

	Now to nail the problem with SCSI.

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

iD8DBQFAHVTGuarJ1mMmSrkRAqNpAJ9V854J4m+gt1A7mvU07VtaxOSHhwCgjT+9
zTPOAD4j9C3uP8TffZrxBe8=
=7adl
-----END PGP SIGNATURE-----
