Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2006 13:12:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46023 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S3686668AbWF3MMt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2006 13:12:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5UCCmCA009212;
	Fri, 30 Jun 2006 13:12:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5UCCmpQ009211;
	Fri, 30 Jun 2006 13:12:48 +0100
Date:	Fri, 30 Jun 2006 13:12:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Au1xxx sound registration and power management
Message-ID: <20060630121247.GA8716@linux-mips.org>
References: <20060630100256.GW7300@hulk.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630100256.GW7300@hulk.enneenne.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 30, 2006 at 12:02:56PM +0200, Rodolfo Giometti wrote:

> here a patch to support device registration and power management for
> the au1xxx ALSA driver.
> 
> Ciao,
> 
> Rodolfo
> 
> P.S. Please, let me know if I should send this patch to other lists
> too.

Yes, this patch is touching 80% ALSA code, so please send it to:

SOUND
P:      Jaroslav Kysela
M:      perex@suse.cz
L:      alsa-devel@alsa-project.org
S:      Maintained

  Ralf

PS: And if you want your patches considerd, add Signed-off-by: lines :)
