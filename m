Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 00:43:23 +0200 (CEST)
Received: from mx2.redhat.com ([12.150.115.133]:59908 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1122978AbSJOWnW>;
	Wed, 16 Oct 2002 00:43:22 +0200
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g9FMgYs15719;
	Tue, 15 Oct 2002 18:42:34 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g9FMhDl11018;
	Tue, 15 Oct 2002 18:43:14 -0400
Received: from localhost.localdomain (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g9FMhDD15320;
	Tue, 15 Oct 2002 15:43:13 -0700
Received: (from rth@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g9FMhBw25531;
	Tue, 15 Oct 2002 15:43:11 -0700
X-Authentication-Warning: localhost.localdomain: rth set sender to rth@redhat.com using -f
Date: Tue, 15 Oct 2002 15:43:11 -0700
From: Richard Henderson <rth@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Alexandre Oliva <aoliva@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
Message-ID: <20021015224311.GL25225@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"H. J. Lu" <hjl@lucon.org>, Alexandre Oliva <aoliva@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
References: <wvnit05ovct.fsf@talisman.cambridge.redhat.com> <20021014091649.A29353@lucon.org> <wvnfzv9ou6j.fsf@talisman.cambridge.redhat.com> <20021014101640.A30133@lucon.org> <orhefo3oht.fsf@free.redhat.lsd.ic.unicamp.br> <20021014105055.B30830@lucon.org> <orzntg298z.fsf@free.redhat.lsd.ic.unicamp.br> <20021014110118.B30940@lucon.org> <orelas24n2.fsf@free.redhat.lsd.ic.unicamp.br> <20021014123940.A32333@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014123940.A32333@lucon.org>
User-Agent: Mutt/1.4i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 14, 2002 at 12:39:40PM -0700, H. J. Lu wrote:
> Can gcc not to emit nop nor noreorder when it tries to fill the delay
> slot with nop?

Because Ideally, gcc will emit

	.set nomacro
	.set noreorder

at the top of the assembly file and never change it.
I hope Eric's mips-rewrite-branch makes it this far.


r~
