Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 22:35:16 +0200 (CEST)
Received: from polyphem.dascon.de ([212.117.81.146]:21175 "HELO mail.dascon.de")
	by ftp.linux-mips.org with SMTP id S8133818AbWEVUfI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2006 22:35:08 +0200
Received: by mail.dascon.de (Postfix, from userid 10)
	id 39E8510A75A; Mon, 22 May 2006 22:35:08 +0200 (CEST)
Received: by discworld.dascon.de (Postfix, from userid 1000)
	id DAB293B70B; Mon, 22 May 2006 22:32:08 +0200 (CEST)
Date:	Mon, 22 May 2006 22:32:08 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Soundcard problems on Cobalt Qube 2
Message-ID: <20060522203208.GB3740@discworld.dascon.de>
References: <20060521181323.GA3740@discworld.dascon.de> <20060523.002728.126141842.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523.002728.126141842.anemo@mba.ocn.ne.jp>
X-message-flag:	Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.11+cvs20060403
From:	rincewind@discworld.dascon.de (Michael Schwingen)
Return-Path: <rincewind@discworld.dascon.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rincewind@discworld.dascon.de
Precedence: bulk
X-list: linux-mips

On Tue, May 23, 2006 at 12:27:28AM +0900, Atsushi Nemoto wrote:
> 
> I know one problem in ALSA on mips, but not sure it is relevant to
> your crash.
> 
> http://www.linux-mips.org/archives/linux-mips/2006-01/msg00327.html
> 
> And here is an updated (still ugly) patch against current git.

Wow!

Ugly maybe, but it fixes the crashes - YMF744 works fine now (the card sound
a bit distorted, but that may well be the hardware - that's why I wanted the
ICE1712 card). I have not tried the ESS card, because that got non-crashing
lockups before.

ICE1712 does not crash, but reports underruns and the aplay process hangs -
I will see if I can track this down a bit more.

cu
Michael
-- 
Some people have no repect of age unless it is bottled.
