Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2003 22:41:30 +0000 (GMT)
Received: from crosslink-village-512-1.bc.nu ([IPv6:::ffff:81.2.110.254]:3978
	"EHLO dhcp23.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225443AbTKMWlP>; Thu, 13 Nov 2003 22:41:15 +0000
Received: from dhcp23.swansea.linux.org.uk (localhost.localdomain [127.0.0.1])
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10) with ESMTP id hADMbSPr016340;
	Thu, 13 Nov 2003 22:37:28 GMT
Received: (from alan@localhost)
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10/Submit) id hADMbQGa016338;
	Thu, 13 Nov 2003 22:37:26 GMT
X-Authentication-Warning: dhcp23.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: RE: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jack Miller <jack.miller@pioneer-pdt.com>
Cc: Jack Miller <jvmiller@earthlink.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>
References: <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1068762590.16231.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 13 Nov 2003 22:37:25 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Iau, 2003-11-13 at 01:13, Jack Miller wrote:
>   Alan,
>     I am not so sure of that.  If you look at ide-disk.c:__ide_do_rw_disk(),
> there is a local variable assignment statement:
> 
>   u8 lba48 = (drive->addressing = 1) ? 1 : 0;
> 
>   So it would seem that the problem is elswhere ?

drive and hwif->addressing are different. (Not my idea don't blame me!)

In the last code I did before going on sabattical its all become a bit
irrelevant as I implemented the notion of lba48 pio-only
