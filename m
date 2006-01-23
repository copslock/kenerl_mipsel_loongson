Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 11:09:37 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:28939 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3458576AbWAWLJN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 11:09:13 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 7F2F164D3D; Mon, 23 Jan 2006 11:13:20 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A0F66846B; Mon, 23 Jan 2006 11:13:11 +0000 (GMT)
Date:	Mon, 23 Jan 2006 11:13:11 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation compile fails: opcode not supported (eret)
Message-ID: <20060123111311.GA21394@deprecation.cyrius.com>
References: <20060121195956.GA15498@deprecation.cyrius.com> <43D2F4D9.6010406@gentoo.org> <20060122131153.GB5543@deprecation.cyrius.com> <Pine.LNX.4.64N.0601231035300.27141@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601231035300.27141@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-01-23 10:36]:
> > That's right, reverting Ralf's commit
> >   Remove stray .set mips3 resulting in 64-bit instruction in 32-bit kernels.
> > makes it compile.
> 
>  This ".set mips3" should protect that "eret" alone then.

Can you please commit a fix to git.
-- 
Martin Michlmayr
http://www.cyrius.com/
