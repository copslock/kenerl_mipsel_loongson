Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 09:37:00 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:25071 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224912AbUHRIg4>;
	Wed, 18 Aug 2004 09:36:56 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7I8asn1024409;
	Wed, 18 Aug 2004 10:36:54 +0200 (MEST)
Date: Wed, 18 Aug 2004 10:36:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: bel racu <belracu22@rediffmail.com>
cc: Arravind babu <aravindforl@yahoo.co.in>,
	binutils@sources.redhat.com,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Doubt on rootfs
In-Reply-To: <20040818061528.31314.qmail@webmail18.rediffmail.com>
Message-ID: <Pine.GSO.4.58.0408181036070.28415@waterleaf.sonytel.be>
References: <20040818061528.31314.qmail@webmail18.rediffmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 18 Aug 2004, bel racu wrote:
> when u issue the Mount command it will display all the mounted
> devices. U can also "cat /etc/mout" file to check the mounted devices
> in your system.

Or better, `cat /proc/mount', since /etc/mount may be out-of-date.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
