Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 18:37:15 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:47540 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225192AbUGSRhL>;
	Mon, 19 Jul 2004 18:37:11 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i6JHbAe1004699;
	Mon, 19 Jul 2004 13:37:10 -0400
Received: from localhost (mail@vpnuser5.surrey.redhat.com [172.16.9.5])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i6JHb9a03018;
	Mon, 19 Jul 2004 13:37:09 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1Bmc4a-00009l-00; Mon, 19 Jul 2004 18:37:08 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
	<87hds49bmo.fsf@redhat.com>
	<Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Mon, 19 Jul 2004 18:37:08 +0100
In-Reply-To: <Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Mon, 19 Jul 2004 19:33:14 +0200 (CEST)")
Message-ID: <87zn5v99vf.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
>  Well, other targets, like the i386 (which didn't even have a 64-bit
> variation till recently), do not force Linux to go through such
> contortions.

But arm targets (for instance) don't provide inline 64-bit shifts,
do they?  I don't think there's anything special in the MIPS ISA
that makes them easier for MIPS than they are for ARM.

Richard
