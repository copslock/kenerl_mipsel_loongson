Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 05:32:58 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:42921 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8224772AbUHKEcx>;
	Wed, 11 Aug 2004 05:32:53 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i7B3v3fu024512;
	Tue, 10 Aug 2004 23:57:03 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7B4WiX07574;
	Wed, 11 Aug 2004 00:32:45 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i7B4WiV23126;
	Tue, 10 Aug 2004 21:32:44 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i7B4WiOo023115;
	Tue, 10 Aug 2004 21:32:44 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i7B4Wi6Q023113;
	Tue, 10 Aug 2004 21:32:44 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Tue, 10 Aug 2004 21:32:44 -0700
From: Richard Henderson <rth@redhat.com>
To: Paul Brook <paul@codesourcery.com>
Cc: gcc-patches@gcc.gnu.org, Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040811043244.GA23096@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Paul Brook <paul@codesourcery.com>, gcc-patches@gcc.gnu.org,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
References: <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <87zn5336h7.fsf@redhat.com> <20040810232020.GA21922@redhat.com> <200408110140.03725.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408110140.03725.paul@codesourcery.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 11, 2004 at 01:40:03AM +0100, Paul Brook wrote:
> ARM is actually shift count modulo 256

Ah, well.


r~
