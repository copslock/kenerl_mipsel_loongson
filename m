Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 13:50:16 +0000 (GMT)
Received: from p508B69C2.dip.t-dialin.net ([IPv6:::ffff:80.139.105.194]:30900
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225241AbTA2NuQ>; Wed, 29 Jan 2003 13:50:16 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0TDo6E25774;
	Wed, 29 Jan 2003 14:50:06 +0100
Date: Wed, 29 Jan 2003 14:50:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Skippie <skippie@skynet.be>
Cc: linux-mips@linux-mips.org
Subject: Re: XFree XZ support
Message-ID: <20030129145006.A25701@linux-mips.org>
References: <20030129131542.D9C3C13EC0A@crassus.kulnet.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030129131542.D9C3C13EC0A@crassus.kulnet.kuleuven.ac.be>; from skippie@skynet.be on Wed, Jan 29, 2003 at 02:15:41PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 29, 2003 at 02:15:41PM +0100, Skippie wrote:

> could it than be possible to use fbdev for the xz card, or is this also
> unsupported?

This is a card that's magnitudes too complex to support.  Even with docs
it was to hard.  Something as trivial as printing a character to the
screen involves writing firmware for the i860 processor(s) of the XZ.

  Ralf
