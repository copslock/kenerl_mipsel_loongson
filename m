Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 01:39:30 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:21778 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133758AbWBXBjW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 01:39:22 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B0CB464D3E; Fri, 24 Feb 2006 01:46:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D9DAF9017; Fri, 24 Feb 2006 01:46:32 +0000 (GMT)
Resent-From: tbm@cyrius.com
Resent-Date: Fri, 24 Feb 2006 01:46:32 +0000
Resent-Message-ID: <20060224014632.GA26157@deprecation.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Date:	Fri, 24 Feb 2006 01:13:26 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Peter Horton <pdh@colonel-panic.org>
Subject: Re: Diff between Linus' and linux-mips git: tulip
Message-ID: <20060224011324.GN9704@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001907.GC17967@deprecation.cyrius.com> <20060220230349.GB1122@colonel-panic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220230349.GB1122@colonel-panic.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Peter Horton <pdh@colonel-panic.org> [2006-02-20 23:03]:
> > -                       /* No media table either */
> > -                       tp->flags &= ~HAS_MEDIA_TABLE;
> > +		       /* Ensure our media table fixup get's applied */
> > +		       memcpy(ee_data + 16, ee_data, 8);
> >  #endif
> >  #ifdef CONFIG_MIPS_COBALT
> Didn't the memcpy() used to be inside the CONFIG_MIPS_COBALT section ?
> Looking at tulip/eeprom.c I can't work out why it was ever there though

Yeah, and it's still there in the Cobalt section.  But now (in the
mips tree) it's _also_ there for CONFIG_DDB5477.  So I have several
questions:
 - can we just get rid of the code between CONFIG_MIPS_COBALT?
 - should the CONFIG_DDB5477 change be reverted (probably), and do we
   need these special cases for CONFIG_DDB* anyway or can they be
   solved in a better way (e.g. by putting something in eeprom.c).

It seems mips is the only arch that mucks around with "#ifdef CONFIG_"
in this file...
-- 
Martin Michlmayr
http://www.cyrius.com/
