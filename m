Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 21:03:21 +0000 (GMT)
Received: from p508B56E7.dip.t-dialin.net ([IPv6:::ffff:80.139.86.231]:14477
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225320AbTKTVDK>; Thu, 20 Nov 2003 21:03:10 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAKL33A0003787;
	Thu, 20 Nov 2003 22:03:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAKL2v4F003780;
	Thu, 20 Nov 2003 22:02:57 +0100
Date: Thu, 20 Nov 2003 22:02:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Colin.Helliwell@Zarlink.Com, linux-mips@linux-mips.org
Subject: Re: Compressed kernels
Message-ID: <20031120210257.GA758@linux-mips.org>
References: <OF86946D75.0D269E58-ON80256DE4.0031F58D@zarlink.com> <3FBCDBF7.7000307@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBCDBF7.7000307@embeddededge.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 20, 2003 at 10:21:27AM -0500, Dan Malek wrote:
> Date: Thu, 20 Nov 2003 10:21:27 -0500
> From: Dan Malek <dan@embeddededge.com>
> To: Colin.Helliwell@Zarlink.Com
> CC: linux-mips@linux-mips.org
> Subject: Re: Compressed kernels
> Content-Type: text/plain; charset=us-ascii; format=flowed
> 
> Colin.Helliwell@Zarlink.Com wrote:
> 
> >I'm running a 2.4.21 kernel tree, and would like to have kernel
> >compression. I wondered if this has gone back into the latest versions yet?
> 
> If you apply the 'zImage' patch from Pete's ftp directory (look in past
> e-mails for this discussion) you will see what I have done for a few of
> the boards I'm using.  It's quite trivial to add new boards to get
> this feature.  I'm still working on the method of attaching the
> compressed initrd to the same image, which I find quite useful for
> embedded applications.

Compressed kernels seem to be fairly high on everybody's list.  Due to
size limits of some boatloaders and flash memory being always too small
and too expensive I guess there would also be some interest in bzip2
support.

  Ralf
