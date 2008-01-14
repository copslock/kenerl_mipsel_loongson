Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 22:02:26 +0000 (GMT)
Received: from harold.telenet-ops.be ([195.130.133.65]:5771 "EHLO
	harold.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20035518AbYANWCS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 22:02:18 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by harold.telenet-ops.be (Postfix) with SMTP id E27C030082;
	Mon, 14 Jan 2008 23:02:17 +0100 (CET)
Received: from anakin (d54C15D55.access.telenet.be [84.193.93.85])
	by harold.telenet-ops.be (Postfix) with ESMTP id C756930083;
	Mon, 14 Jan 2008 23:02:17 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin (8.14.1/8.14.1/Debian-9) with ESMTP id m0EM2HEE004010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2008 23:02:17 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id m0EM2HaO004007;
	Mon, 14 Jan 2008 23:02:17 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 14 Jan 2008 23:02:17 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SPAM] [PATCH][MIPS] Add Atlas to feature-removal-schedule.
In-Reply-To: <478BD0D2.2060004@gmail.com>
Message-ID: <Pine.LNX.4.64.0801142302001.2335@anakin>
References: <478BD0D2.2060004@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 15 Jan 2008, Dmitri Vorobiev wrote:
> Ralf Baechle on Atlas board support in the linux-mips mailing list:
> 
> Maciej is promising to fix it up since a few years ;-)  Aside of that it's
> safe to say the Atlas is dead like a coffin nail.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
> ---
>  Documentation/feature-removal-schedule.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 20c4c8b..c053318 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -333,3 +333,11 @@ Why:	This driver has been marked obsolete for many years.
>  Who:	Stephen Hemminger <shemminger@linux-foundation.org>
>  
>  ---------------------------
> +
> +What:	Support for MIPS Technologies' Altas evaluation board
                                               ^^^^^
					       Atlas

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
