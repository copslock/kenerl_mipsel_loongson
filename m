Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 00:44:24 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:49679 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133714AbWCBAoM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 00:44:12 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E341064D3D; Thu,  2 Mar 2006 00:52:02 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id DF0E38545; Thu,  2 Mar 2006 01:51:52 +0100 (CET)
Resent-From: tbm@cyrius.com
Resent-Date: Thu, 2 Mar 2006 00:51:52 +0000
Resent-Message-ID: <20060302005152.GB4118@deprecation.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Received: by deprecation.cyrius.com (Postfix, from userid 10)
	id 808B39122; Wed,  1 Mar 2006 23:04:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sorrow.cyrius.com (Postfix) with ESMTP id 0933364D3D
	for <tbm@cyrius.com>; Wed,  1 Mar 2006 21:53:15 +0000 (UTC)
Received: from nephila.localnet (i-83-67-53-76.freedom2surf.net [83.67.53.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sorrow.cyrius.com (Postfix) with ESMTP id C2A8864D3E
	for <tbm@cyrius.com>; Wed,  1 Mar 2006 21:53:12 +0000 (UTC)
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1FEZFu-0000n5-Vx
	for tbm@cyrius.com; Wed, 01 Mar 2006 21:53:10 +0000
Date:	Wed, 1 Mar 2006 21:53:10 +0000
To:	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: Diff between Linus' and linux-mips git: tulip
Message-ID: <20060301215310.GB2993@colonel-panic.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001907.GC17967@deprecation.cyrius.com> <20060220230349.GB1122@colonel-panic.org> <20060224011324.GN9704@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224011324.GN9704@deprecation.cyrius.com>
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cyrius.com
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 24, 2006 at 01:13:27AM +0000, Martin Michlmayr wrote:
> * Peter Horton <pdh@colonel-panic.org> [2006-02-20 23:03]:
> > > -                       /* No media table either */
> > > -                       tp->flags &= ~HAS_MEDIA_TABLE;
> > > +		       /* Ensure our media table fixup get's applied */
> > > +		       memcpy(ee_data + 16, ee_data, 8);
> > >  #endif
> > >  #ifdef CONFIG_MIPS_COBALT
> > Didn't the memcpy() used to be inside the CONFIG_MIPS_COBALT section ?
> > Looking at tulip/eeprom.c I can't work out why it was ever there though
> 
> Yeah, and it's still there in the Cobalt section.  But now (in the
> mips tree) it's _also_ there for CONFIG_DDB5477.  So I have several
> questions:
>  - can we just get rid of the code between CONFIG_MIPS_COBALT?
>  - should the CONFIG_DDB5477 change be reverted (probably), and do we
>    need these special cases for CONFIG_DDB* anyway or can they be
>    solved in a better way (e.g. by putting something in eeprom.c).
> 
> It seems mips is the only arch that mucks around with "#ifdef CONFIG_"
> in this file...

Looks like both the "sa_offset = 0" and "memcpy(...)" are required to
ensure our fixup from tulip/eeprom.c gets applied. I don't know why it
only seems to be us that needs it :-(

P.
