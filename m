Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 09:51:06 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:51582 "EHLO
	gw.icm.edu.pl") by linux-mips.org with ESMTP id <S8225263AbUCPJvC>;
	Tue, 16 Mar 2004 09:51:02 +0000
Received: from rekin.icm.edu.pl (mail@rekin.icm.edu.pl [192.168.1.132])
	by gw.icm.edu.pl (8.12.9/8.12.6/rzm-4.6/icm) with ESMTP id i2G9opA0000011
	for <linux-mips@linux-mips.org>; Tue, 16 Mar 2004 10:50:55 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1B3BDn-0005Aw-00
	for <linux-mips@linux-mips.org>; Tue, 16 Mar 2004 10:50:51 +0100
Date: Tue, 16 Mar 2004 10:50:51 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips <linux-mips@linux-mips.org>
Subject: Re: newport console fixes
Message-ID: <20040316095051.GA19755@icm.edu.pl>
Mail-Followup-To: linux-mips <linux-mips@linux-mips.org>
References: <20040315135708.GA7861@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315135708.GA7861@fh-brandenburg.de>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Mon, Mar 15, 2004 at 02:57:08PM +0100, Markus Dahms wrote:
> Hello list,
> 
> I patched the newport console driver to have the correct colormap
> when exiting X11 / switching from X11 to console.
> This problem doesn't affect all versions of the newport, the old
> revision in my very old indy doesn't show these effects.
> Some revision information of my (different) newports is written in
> the header of the attached diff.

Just for the record, my Indy also exhibits this fault, but has different
cmap revision than yours:

NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A,
     xmap9 revision A, cmap revision C, bt445 revision D
NG1: Screensize 1280x1024

> #### old newport, works w/o patch
> #
> # NG1: Revision 3, 8 bitplanes, REX3 revision B, VC2 revision A, 
> #      xmap9 revision A, cmap revision C, bt445 revision A
> # NG1: Screensize 1296x1024
> #
> ## (strange resolution, isn't it? - X does 1280x1024 anyway)
> 
> #### new newport, works w/ patch
> #
> # NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A,
> #      xmap9 revision A, cmap revision D, bt445 revision D
> # NG1: Screensize 1280x1024

Regards,

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
