Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 22:34:07 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:31493 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3467366AbWBMWd5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 22:33:57 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C482864D3D; Mon, 13 Feb 2006 22:40:06 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 996F582BB; Mon, 13 Feb 2006 22:39:51 +0000 (GMT)
Date:	Mon, 13 Feb 2006 22:39:51 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Peter 'p2' De Schrijver <p2@mind.be>,
	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060213223951.GA4226@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-13 09:15]:
>  The following change fixes the problem for me -- it looks like an 
> omission from some recent changes elsewhere.  Ralf, please apply.

Current git and the standard decstation config fails to build with:

  LD      .tmp_vmlinux1
arch/mips/kernel/built-in.o: In function `einval':arch/mips/kernel/scall32-o32.S:(.text+0xb6c0): undefined reference to `sys_newfstatat'

This is with binutils 2.16.1cvs20060117-1 and gcc 4.0.3 20051201.
-- 
Martin Michlmayr
http://www.cyrius.com/
