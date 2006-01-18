Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 15:41:00 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:14611 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133634AbWARPkl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 15:40:41 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B678364D54; Wed, 18 Jan 2006 15:43:40 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 053688456; Wed, 18 Jan 2006 15:43:19 +0000 (GMT)
Date:	Wed, 18 Jan 2006 15:43:19 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>,
	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: gdb gets confused with o32 core files, WANT_COMPAT_REG_H needed?
Message-ID: <20060118154319.GA25368@deprecation.cyrius.com>
References: <17162.16068.212165.340275@cortez.sw.starentnetworks.com> <20050828154530.GA26423@nevyn.them.org> <17162.16068.212165.340275@cortez.sw.starentnetworks.com> <20060116160925.GE28383@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116160925.GE28383@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-01-16 16:09]:
> Can this be applied?
> 
> 
> > Fix o32 core files under 64bit kernel to use correct register
> > offset in NT_PRSTATUS
> > Signed-off-by: Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
> >  
> > -#if CONFIG_MIPS64
> > +#if defined(CONFIG_MIPS64) && !defined(WANT_COMPAT_REG_H)

Obviously, this should be CONFIG_64BIT now.

-- 
Martin Michlmayr
http://www.cyrius.com/
