Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Oct 2002 14:02:53 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:18314 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1123905AbSJTMCx>; Sun, 20 Oct 2002 14:02:53 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 183Emz-003KXz-00; Sun, 20 Oct 2002 14:02:37 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 183Emy-0001yz-00; Sun, 20 Oct 2002 14:02:36 +0200
Date: Sun, 20 Oct 2002 14:02:36 +0200
To: Martin Schulze <joey@infodrom.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Correct colour handling
Message-ID: <20021020120236.GA7562@rembrandt.csv.ica.uni-stuttgart.de>
References: <20021019165053.GR14430@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019165053.GR14430@finlandia.infodrom.north.de>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Martin Schulze wrote:
> Moin Ralf,
> 
> please apply the patch below which will correct colour handling.  The
> outcome of this patch will only be visible with a monochrome graphics
> card since they can see what is written on the screen again.
> 
> As you can see, not all occasions where the currently used colour is
> changed, isn't protected by the 'if (can_do_color)' check.  Some
> occurrences though use it.
> 
> This patch is done basically by Thiemo Seufer during this years'
> Oldenburg meeting.

This is not-so-true, I didn't even touch the keyboard. ;-)


Thiemo
