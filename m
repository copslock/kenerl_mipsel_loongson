Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 12:04:02 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:35327 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225278AbUBAMEC>;
	Sun, 1 Feb 2004 12:04:02 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i11C40w2005358;
	Sun, 1 Feb 2004 13:04:00 +0100 (MET)
Date: Sun, 1 Feb 2004 13:04:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, jsun@mvista.com,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] enable genrtc for MIPS
In-Reply-To: <20040201.203005.74756858.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.GSO.4.58.0402011303140.20933@waterleaf.sonytel.be>
References: <20040130103913.E31937@mvista.com> <Pine.LNX.4.55.0401302012200.10311@jurand.ds.pg.gda.pl>
 <20040201.203005.74756858.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 1 Feb 2004, Atsushi Nemoto wrote:
> I think implementing rtc_get_time (mips specific) with get_rtc_time
> (genrtc) is more efficient than implementing get_rtc_time with
> rtc_get_time for most RTC chips.

Indeed, that's what I noticed a while ago, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
