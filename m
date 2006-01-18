Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 15:49:56 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:46359 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465599AbWARPti (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 15:49:38 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0IFpIVI018036;
	Wed, 18 Jan 2006 15:51:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0IFpHYd018035;
	Wed, 18 Jan 2006 15:51:17 GMT
Date:	Wed, 18 Jan 2006 15:51:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: gdb gets confused with o32 core files, WANT_COMPAT_REG_H needed?
Message-ID: <20060118155117.GA17343@linux-mips.org>
References: <17162.16068.212165.340275@cortez.sw.starentnetworks.com> <20050828154530.GA26423@nevyn.them.org> <17162.16068.212165.340275@cortez.sw.starentnetworks.com> <20060116160925.GE28383@deprecation.cyrius.com> <20060118154319.GA25368@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118154319.GA25368@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 18, 2006 at 03:43:19PM +0000, Martin Michlmayr wrote:

> > > -#if CONFIG_MIPS64
> > > +#if defined(CONFIG_MIPS64) && !defined(WANT_COMPAT_REG_H)
> 
> Obviously, this should be CONFIG_64BIT now.

That was a GDB bug so no need for kernel changes.

  Ralf
