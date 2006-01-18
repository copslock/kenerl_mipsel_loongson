Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 13:35:44 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:39442 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133607AbWARNfX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 13:35:23 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 526C464D54; Wed, 18 Jan 2006 13:38:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 620E88456; Wed, 18 Jan 2006 13:37:59 +0000 (GMT)
Date:	Wed, 18 Jan 2006 13:37:59 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	MIPS Linux List <linux-mips@linux-mips.org>,
	Stuart Anderson <anderson@netsweng.com>,
	David Daney <ddaney@avtrex.com>
Subject: Re: linux kernel building for mips malta target board
Message-ID: <20060118133759.GT6827@deprecation.cyrius.com>
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com> <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com> <436965B7.3000606@avtrex.com> <Pine.LNX.4.61.0511022057140.3511@trantor.stuart.netsweng.com> <20051103163306.GC3149@linux-mips.org> <20060118125203.GA21997@deprecation.cyrius.com> <20060118130559.GB3555@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118130559.GB3555@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-18 13:05]:
> > With current linux-mips git I still get the problem.  As a reminder,
> > the error is:
> > 
> >   CC      fs/compat_ioctl.o
> > fs/compat_ioctl.c: In function 'fd_ioctl_trans':
> > fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
> I have not been able to find some construct that keeps gcc happy and at the
> same time doesn't result in significantly worse code.  That matters because
> get_user / put_user are used very often throughout the kernel.

Who could help with that?  Maciej?  David Daney?

(See the original discussion and the proposed patch at
http://www.spinics.net/lists/mips/msg20671.html)
-- 
Martin Michlmayr
http://www.cyrius.com/
