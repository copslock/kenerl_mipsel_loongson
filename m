Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2002 22:56:28 +0200 (CEST)
Received: from p508B7AB5.dip.t-dialin.net ([80.139.122.181]:19332 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123906AbSIZU41>; Thu, 26 Sep 2002 22:56:27 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8QKuCG26843;
	Thu, 26 Sep 2002 22:56:12 +0200
Date: Thu, 26 Sep 2002 22:56:11 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alex deVries <adevries@linuxcare.com>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020926225611.A26300@linux-mips.org>
References: <3D92B80A.3080802@linuxcare.com> <20020926171033.GA13337@paradigm.rfc822.org> <3D935DE6.7020206@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D935DE6.7020206@linuxcare.com>; from adevries@linuxcare.com on Thu, Sep 26, 2002 at 03:20:06PM -0400
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 26, 2002 at 03:20:06PM -0400, Alex deVries wrote:

Nice to hear from you again after years of silence.

> So making a tool that writes the 8k volume header is easy.  If I 
> understand properly, that points to a filename on the EFS filesystem 
> that follows it.
> 
> What open source tools do we have to create such an EFS filesystem?

None.  The in-kernel EFS filesystem is read-only.

  Ralf
