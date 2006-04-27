Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 00:09:03 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:45073 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133815AbWD0XIv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 00:08:51 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3EB6864D5D; Thu, 27 Apr 2006 23:08:14 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4A39F66DD3; Thu, 27 Apr 2006 17:38:05 +0200 (CEST)
Resent-From: tbm@cyrius.com
Resent-Date: Thu, 27 Apr 2006 17:38:05 +0200
Resent-Message-ID: <20060427153805.GD8057@deprecation.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Received: by deprecation.cyrius.com (Postfix, from userid 10)
	id D889066EE6; Thu, 27 Apr 2006 13:49:14 +0200 (CEST)
Received: from murphy.debian.org (murphy.debian.org [146.82.138.6])
	by sorrow.cyrius.com (Postfix) with ESMTP id AA87564D3D
	for <tbm@cyrius.com>; Thu, 27 Apr 2006 04:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by murphy.debian.org (Postfix) with QMQP
	id DA9892E199; Wed, 26 Apr 2006 23:46:48 -0500 (CDT)
Old-Return-Path: <ssp@woodland.ru>
Received: from woodland.ru (unknown [217.107.114.2])
	by murphy.debian.org (Postfix) with ESMTP id 9B1BB2E425
	for <debian-mips@lists.debian.org>; Wed, 26 Apr 2006 23:46:41 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by woodland.ru with local; Thu, 27 Apr 2006 11:33:41 +0600
Date:	Thu, 27 Apr 2006 11:33:41 +0600
From:	Sergey Sivkov <ssp@woodland.ru>
To:	debian-mips@lists.debian.org
Subject: Re: SNI RM300C with R10000
Message-ID: <20060427053341.GA32305@woodland.ru>
References: <20060425075615.GA15261@woodland.ru> <20060425091123.GD7822@deprecation.cyrius.com> <20060426221619.GB21670@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060426221619.GB21670@linux-mips.org>
User-Agent: Mutt/1.4i
X-Rc-Virus: 2005-11-10_01
X-Rc-Spam: 2006-04-09_01
Resent-Message-ID: <WcRIx.A.gID.4yEUEB@murphy>
Resent-From: debian-mips@lists.debian.org
X-Mailing-List:	<debian-mips@lists.debian.org> archive/latest/6394
X-Loop:	debian-mips@lists.debian.org
Precedence: list
Resent-Sender: debian-mips-request@lists.debian.org
Resent-Date: Wed, 26 Apr 2006 23:46:48 -0500 (CDT)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Thanks for all replies.

I have readed wiki pages at http://www.linux-mips.org. For now i know what type of RM300C i have:
big endian RM300C-80 with R10000 and SNI Monitor.

AFAIK, i have next options to start Linux on that computer:
1.\ to use network boot
2.\ to create boot CD with Disk Volume Header
3.\ to change bootloader to ARC and to use Debian MIPS boot CD.
I can't use option 3 because we have purchased RM300C as used hardware w/o any documentation and licensies (and w/o SCSI discs).
Will kernels placed at http://silicon-verl.de/home/flo/projects/snirm/kernel/ work with big endian R10000?
Can i create test version of boot CD with Disk Volume Header and Linux kernel only?

					WBR, ssp

On Wed, Apr 26, 2006 at 11:16:20PM +0100, Ralf Baechle wrote:
> On Tue, Apr 25, 2006 at 11:11:23AM +0200, Martin Michlmayr wrote:
> 
> > * Sergey Sivkov <ssp@woodland.ru> [2006-04-25 13:56]:
> > > I have SNI RM300C with R10000 CPU. Is there any chance i'll be able
> > > to start Linux on that computer?
> > 
> > Certainly not out of the box.  However, Ralf Baechle (the MIPS kernel
> > maintainer) has (or used to have) a RM200C so it might be possible to
> > get it going.
> > 
> > Ralf, what's the status of RM200C/RM300C support?
> 
> Slight bitrot but would be easy to fix that.  The reason for the bitrot
> is that my RM is still in Germany ...
> 
>   Ralf
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-mips-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> 


-- 
To UNSUBSCRIBE, email to debian-mips-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
