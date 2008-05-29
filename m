Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 02:00:05 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:38065 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20046671AbYE2LwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 12:52:19 +0100
Received: from bobafett.staff.proxad.net ([213.228.1.121]:43727 "EHLO
	bobafett.staff.proxad.net") by lappi.linux-mips.net with ESMTP
	id S1107570AbYE2LrN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 13:47:13 +0200
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id D263D1CA07;
	Thu, 29 May 2008 13:47:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at staff.proxad.net
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id g80jNbMPAjJ6; Thu, 29 May 2008 13:47:05 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net (nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 833A42ADB;
	Thu, 29 May 2008 13:47:05 +0200 (CEST)
From:	Nicolas Schichan <nschichan@freebox.fr>
Organization: Freebox
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: kexec on mips - anyone has it working?
Date:	Thu, 29 May 2008 13:47:04 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <483BCB75.4050901@wpkg.org> <200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org>
In-Reply-To: <483C4F73.4040909@wpkg.org>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805291347.05196.nschichan@freebox.fr>
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
Precedence: bulk
X-list: linux-mips

On Tuesday 27 May 2008 20:14:11 you wrote:
> Aah, I see.
>
> Anyway, it doesn't work - with or without this slight change in
> machine_kexec.c, with kexec compiled from the sources in the link you
> gave or with kexec-tools-testing-20080324, it just doesn't work on
> BCM43XX with OpenWRT patches. At least on Asus WL-500gP.

I'm not familiar with broadcom CPU names, but isn't BCM43XX supposed
to be a Wifi chipset ? :)

However,  could   you  kexec   a  kernel  from   a  kernel   that  has
CONFIG_MIPS_UNCACHED  set (under  "Kernel  hacking", "run  uncached")?
this will slow down the kernel that does the kexec, but if this works,
then it is most probably a cache problem.

Could you also indicate the last lines of kernel messages just before
the "Bye." ?

Are you trying to kexec a big kernel image ? how much RAM do you have
on the board ? are there some hardware that could have a hard time to
be re-probed by the kexeced linux kernel ?

Regards,

-- 
Nicolas Schichan
