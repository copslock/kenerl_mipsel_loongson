Received:  by oss.sgi.com id <S553802AbRCNUCm>;
	Wed, 14 Mar 2001 12:02:42 -0800
Received: from u-203-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.203]:16893
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553796AbRCNUCX>; Wed, 14 Mar 2001 12:02:23 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2EK27M02757;
	Wed, 14 Mar 2001 21:02:07 +0100
Date:   Wed, 14 Mar 2001 21:02:07 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010314210207.C1911@bacchus.dhis.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <3AAFCB24.E7910A9B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAFCB24.E7910A9B@mvista.com>; from jsun@mvista.com on Wed, Mar 14, 2001 at 11:48:52AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Mar 14, 2001 at 11:48:52AM -0800, Jun Sun wrote:

> Although -mmad is generic, why do we need it for kernel compiling?  If no good
> reason, I propose to remove -mmad from the Makefile for Nevada chip.

The compiler actually emits a few mmad instructions, so this instruction
actually make a small difference.

> Of course, we still need to fix the -mmad implying -m4650 bug ...

I guess I leave the -mmad flag in the kernel source as reminder for somebody
to fix this ...

  Ralf
