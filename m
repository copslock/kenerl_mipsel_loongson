Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2003 01:00:35 +0000 (GMT)
Received: from crosslink-village-512-1.bc.nu ([IPv6:::ffff:81.2.110.254]:33928
	"EHLO dhcp23.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225483AbTKMBAY>; Thu, 13 Nov 2003 01:00:24 +0000
Received: from dhcp23.swansea.linux.org.uk (localhost.localdomain [127.0.0.1])
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10) with ESMTP id hAD0uZPr013435;
	Thu, 13 Nov 2003 00:56:35 GMT
Received: (from alan@localhost)
	by dhcp23.swansea.linux.org.uk (8.12.10/8.12.10/Submit) id hAD0uYnG013433;
	Thu, 13 Nov 2003 00:56:34 GMT
X-Authentication-Warning: dhcp23.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jack Miller <jvmiller@earthlink.net>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <1068662598.2185.2.camel@jaco>
References: <1068662598.2185.2.camel@jaco>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1068684992.13276.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 13 Nov 2003 00:56:33 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mer, 2003-11-12 at 18:43, Jack Miller wrote:
>   Ralf,
>     Please apply this patch for the file drivers/ide/pci/alim15x3.c.  It
> fixes the LBA addressing mode for chip revisions <= 0xC4.  Thank-You.

It seems to break it not fix it.

addressing = 1 means no LBA48
addressing = 0 means LBA48

Alan
