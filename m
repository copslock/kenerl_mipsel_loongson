Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 18:43:20 +0100 (BST)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:904 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225252AbUIXRnQ>;
	Fri, 24 Sep 2004 18:43:16 +0100
Received: from burza.icm.edu.pl (burza.icm.edu.pl [192.168.1.198])
	by atol.icm.edu.pl (8.12.3/8.12.6/rzm-4.6/icm) with ESMTP id i8OHhDJI009579
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 19:43:14 +0200
Received: from liandra.icm.edu.pl (liandra.icm.edu.pl [192.168.1.116])
	by burza.icm.edu.pl (8.12.9/8.12.9/rzm-2.9.3/icm) with ESMTP id i8OHhFn8029576
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 19:43:15 +0200 (CEST)
Received: by liandra.icm.edu.pl (Postfix, from userid 5242)
	id 782773F2E; Fri, 24 Sep 2004 19:43:14 +0200 (CEST)
Date: Fri, 24 Sep 2004 19:43:14 +0200
From: "Dominik 'Rathann' Mierzejewski" <D.Mierzejewski@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: redhat/7.3/NIISI updated
Message-ID: <20040924174313.GB6050@liandra.icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <4154597C.3080405@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154597C.3080405@niisi.msk.ru>
User-Agent: Mutt/1.5.6i
Return-Path: <D.Mierzejewski@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: D.Mierzejewski@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Fri, Sep 24, 2004 at 09:29:32PM +0400, Gleb O. Raiko wrote:
> Hello,
> 
> I've uploaded new NIISI packages in 
> ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/NIISI/
> 
> The NIISI packages are updated version of H.J. Lu's mini-port of RedHat 7.3.
> 
> Most important change in this update is all packages from mini-port and 
> previous NIISI updates were recompiled due to a bug in the C/C++ 
> compiler from the original toolchain package. Of course, the bug itself 
> is fixed in toolchain.
> 
> Other changes include RH/FL security fixes and a lot of new stuff.
> 
> Finally, a (not-so-)minimal root fs package  is provided in tools.

Is there a HOWTO available specifically for cross-building RH7.3 for MIPS
on another (x86) RedHat/Fedora box?

-- 
Dominik 'Rathann' Mierzejewski <rathann*at*icm.edu.pl>
Interdisciplinary Centre for Mathematical and Computational Modelling
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810
