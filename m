Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 17:59:20 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:45728 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225009AbUGSQ7P>;
	Mon, 19 Jul 2004 17:59:15 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i6JGxEe1026873;
	Mon, 19 Jul 2004 12:59:14 -0400
Received: from localhost (mail@vpnuser5.surrey.redhat.com [172.16.9.5])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i6JGxDa23738;
	Mon, 19 Jul 2004 12:59:13 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BmbTr-000087-00; Mon, 19 Jul 2004 17:59:11 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Mon, 19 Jul 2004 17:59:11 +0100
In-Reply-To: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Mon, 19 Jul 2004 17:35:00 +0200 (CEST)")
Message-ID: <87hds49bmo.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> Linux relies on simple operations (addition/subtraction and shifts) on
> "long long" variables being implemented inline without a call to
> libgcc, which isn't linked in.

Sorry, but I don't think this is a reasonable expection for 64-bit
shifts on 32-bit targets.  If linux insists on not using libgcc,
it should provide:

> After your change Linux has unresolved references to external __ashldi3(),
> __ashrdi3() and __lshrdi3() functions at the final link.

...these functions itself.

Richard
