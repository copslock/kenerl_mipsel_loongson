Received:  by oss.sgi.com id <S554158AbRBEF0x>;
	Sun, 4 Feb 2001 21:26:53 -0800
Received: from c824216-a.stcla1.sfba.home.com ([24.176.212.15]:37108 "EHLO
        dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP id <S554101AbRBEF0d>;
	Sun, 4 Feb 2001 21:26:33 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f155KNl27723;
	Sun, 4 Feb 2001 21:20:23 -0800
Date:   Sun, 4 Feb 2001 21:20:23 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Kenneth C Barr <kbarr@MIT.EDU>, linux-mips@oss.sgi.com
Subject: Re: netbooting indy
Message-ID: <20010204212023.B27490@bacchus.dhis.org>
References: <Pine.LNX.4.30.0102010926190.20992-100000@springhead.px.uk.com> <Pine.GSO.4.30L.0102012329020.18202-100000@biohazard-cafe.mit.edu> <20010202103607.C18620@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010202103607.C18620@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Feb 02, 2001 at 10:36:07AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 02, 2001 at 10:36:07AM +0100, Florian Lohoff wrote:

> > 2.  Similar behavior with 3 different ELF kernel images (hardhat,
> > vmlinux-indy-2.2.1-990226, and the 2.4.0-test9).  I get the spinning
> 
> Ever tried using an ECOFF image ? Some proms cant load elf ..

If that's the problem the firmware will complain loudly.

  Ralf
