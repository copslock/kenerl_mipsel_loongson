Received:  by oss.sgi.com id <S554233AbRBEKJE>;
	Mon, 5 Feb 2001 02:09:04 -0800
Received: from c824216-a.stcla1.sfba.home.com ([24.176.212.15]:11513 "EHLO
        dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP id <S554156AbRBEKIp>;
	Mon, 5 Feb 2001 02:08:45 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f15A2fM30380;
	Mon, 5 Feb 2001 02:02:41 -0800
Date:   Mon, 5 Feb 2001 02:02:41 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Filesystem corruption
Message-ID: <20010205020241.A30062@bacchus.dhis.org>
References: <3A781F33.6B28D19C@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A781F33.6B28D19C@mips.com>; from carstenl@mips.com on Wed, Jan 31, 2001 at 03:20:35PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 31, 2001 at 03:20:35PM +0100, Carsten Langgaard wrote:

> Has anyone seen problems with fsck on the latest 2.4.0 kernel ?
> My filesystem gets corrupted from time to time when I use the latest
> 2.4.0 kernel.

2.4.1 is known to cause fs corruption for all architectures; 2.4.0 should
actually be fine.  I just reached 8 days of uptime on a 32p Origin 2000,
so it can't be that bad.

  Ralf
