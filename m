Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 20:21:59 +0100 (CET)
Received: from mx2.redhat.com ([12.150.115.133]:13583 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1122121AbSKETV6>;
	Tue, 5 Nov 2002 20:21:58 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id gA5JKGP12450;
	Tue, 5 Nov 2002 14:20:16 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id gA5JLjl20109;
	Tue, 5 Nov 2002 14:21:45 -0500
Received: from dhcp-172-16-25-153.sfbay.redhat.com (dhcp-172-16-25-153.sfbay.redhat.com [172.16.25.153])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id gA5JLiD09981;
	Tue, 5 Nov 2002 11:21:44 -0800
Subject: Re: Problems generating shared library for MIPS using
	binutils-2.13...
From: Eric Christopher <echristo@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: binutils@sources.redhat.com, linux-mips@linux-mips.org
In-Reply-To: <20021105183220.GA8656@nevyn.them.org>
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl>
	<3DC68907.30708@realitydiluted.com>
	<wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>
	<20021105172627.GA5275@nevyn.them.org>
	<wvnpttjdgoc.fsf@talisman.cambridge.redhat.com> 
	<20021105183220.GA8656@nevyn.them.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Nov 2002 11:21:37 -0800
Message-Id: <1036524097.1509.169.camel@ghostwheel>
Mime-Version: 1.0
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> The principal thing is that I want O32 code.  You can't use a higher
> ISA level than MIPS2 and still use O32, as far as I understand. And
> this setup has a 32-bit kernel, so using MIPS3/4/64 instructions in
> userspace is a real losing proposition.
> 

You should be able to do -mips32 -mabi=32, however, I wouldn't bet on
this working atm :)

> I obviously want -mtune=sb1.  So probably I should just be using
> -mtune=sb1 -mips2.  And hack the GENERATE_BRANCHLIKELY test to honor
> -mtune.  Blech, I wish these options were less confusing!
> 

:) Good idea on the GENERATE_BRANCHLIKELY. I think it probably should be
dependent on mtune anyhow.

-eric

-- 
Yeah, I used to play basketball...
