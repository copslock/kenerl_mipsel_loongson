Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 16:24:34 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:41753 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133495AbWBNQYZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 16:24:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1EGPrvC030805;
	Tue, 14 Feb 2006 16:25:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1EGPo3P030803;
	Tue, 14 Feb 2006 16:25:50 GMT
Date:	Tue, 14 Feb 2006 16:25:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Peter 'p2' De Schrijver" <p2@mind.be>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060214162550.GC21016@linux-mips.org>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl> <20060213223951.GA4226@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213223951.GA4226@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 13, 2006 at 10:39:51PM +0000, Martin Michlmayr wrote:

>   LD      .tmp_vmlinux1
> arch/mips/kernel/built-in.o: In function `einval':arch/mips/kernel/scall32-o32.S:(.text+0xb6c0): undefined reference to `sys_newfstatat'

Fixed yesterday, didn't get around to push it out until today.

  Ralf
