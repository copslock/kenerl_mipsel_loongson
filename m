Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 15:26:08 +0000 (GMT)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:37578 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225264AbUK2P0D>;
	Mon, 29 Nov 2004 15:26:03 +0000
Received: (qmail 17142 invoked from network); 29 Nov 2004 15:25:55 -0000
Received: from unknown (HELO orphique) (Ladislav.Michl@62.77.73.201)
  by smtp.seznam.cz with SMTP; 29 Nov 2004 15:25:55 -0000
Received: from ladis by orphique with local (Exim 3.36 #1 (Debian))
	id 1CYnPY-0003pB-00; Mon, 29 Nov 2004 16:25:56 +0100
Date: Mon, 29 Nov 2004 16:25:56 +0100
To: Guido Guenther <agx@sigxcpu.org>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: arcboot cache
Message-ID: <20041129152556.GB14382@simek>
References: <20041123064011.GA17752@foobazco.org> <20041129144149.GB11653@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129144149.GB11653@bogon.ms20.nix>
User-Agent: Mutt/1.5.6+20040722i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 29, 2004 at 03:41:49PM +0100, Guido Guenther wrote:
> On Mon, Nov 22, 2004 at 10:40:12PM -0800, Keith M Wesolowski wrote:
> > Let's make arcboot 20x faster, shall we?  Tested on ip22, ip32.
> Very cool. Unfortunately I intended to rip out libext2fs anytime soon,
> anyways I'll apply the patch until then.

Guido, I imported arcboot-0.3.8.4 into CVS repository and commited this
patch as well as patch by Thiemo Seufer. Debian package builds fine and
arcboot is _much_ faster. Thanks Keith :)

Regards,
	ladis
