Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jan 2009 03:35:22 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:39070 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S24063297AbZAEDfT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Jan 2009 03:35:19 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id E792432221A;
	Mon,  5 Jan 2009 03:35:07 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon,  5 Jan 2009 03:35:07 +0000 (UTC)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE:  SMP8634 Linux boot
Date:	Sun, 4 Jan 2009 19:35:05 -0800
Message-ID: <01049E563C8ECC43AD6B53A5AF419B380128FE3B@avtrex-server2.hq2.avtrex.com>
In-Reply-To: <gjqihv$h6m$1@ger.gmane.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic:  SMP8634 Linux boot
Thread-Index: AclufGPRqkJP5+S0TX6x55Twb7U56AAaYNeA
From:	"Mark Edson" <medson@avtrex.com>
To:	"Andi" <opencode@gmx.net>, <linux-mips@linux-mips.org>
Return-Path: <medson@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: medson@avtrex.com
Precedence: bulk
X-list: linux-mips

We use MAJIC-LT boot loader.  Our steps on the MAJIC-LT host are:
	$ cd /opt/edtm/targets/sigma_vantage
	$ /opt/edtm/bin/monice -v4kec -d majic-lt:e -l    (monice should
report connected)
	MON> ew 0xa003fffc =3
	MON> ew 0xa003fffc =2
	MON> ew 0xa0030000 =0xE34111BA
	MON> ew 0xa003fffc =0xa4444
	MON> ew 0xa003fffc =0
	MON> ew 0xa006f000 = 0x60000
	MON> l yamon.elf
	MON> l reset.elf
	Mon> g 

And that gives us a YAMON> prompt on the serial console of the 8634.

From _that_ YAMON> prompt, we load the real xenv/zboot/yamon like this:

YAMON> load uu 0xb0100000   (send zboot2.bin.uu)
	<watch for returned load size>
YAMON> load uu 0xb0200000    (send zbimage-yamon.uu)
	<watch for returned load size>
YAMON> pflash write 0 0xb0100000 <size of zboot2.bin>
YAMON> pflash write 0x40000 0xb0200000 200704 <size of zbimage-yamon>

Then when you reboot w/o JTAG, it should give you a YAMON prompt on the
console.

Good luck...

Mark

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Andi
Sent: Sunday, January 04, 2009 6:54 AM
To: linux-mips@linux-mips.org
Subject: SMP8634 Linux boot

Hi List,

First of all, sorry for asking a slightly off topic question on that
list but it has something to do with MIPS and Linux though.
As I don't have a working zboot image, I am trying to load zboot or
yamon via JTAG to a SMP8634 board in order to boot Linux afterwards. I
followed the instructions described in smp8634-documentation and was
able to build a yamon and reboot image which successfully loads on a
plain smp8634. Unfortunately, this is not the case when building yamon
with XENV support or when trying to load a zboot image instead. On the
other hand I can't load Linux on a yamon without XENV support, yet.
After loading xboot which fails to load zboot now, do I have to
initialize the memory mapping or other registers prior loading any other
code like yamon or zboot? If so, which one?

Any help to load Linux is very appreciated.

Best regards,
	Andi
