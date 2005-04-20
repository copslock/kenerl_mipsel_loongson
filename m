Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 14:13:23 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:22800 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226106AbVDTNNJ>; Wed, 20 Apr 2005 14:13:09 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3KDD5XV016057;
	Wed, 20 Apr 2005 14:13:05 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3KDD41l016056;
	Wed, 20 Apr 2005 14:13:04 +0100
Date:	Wed, 20 Apr 2005 14:13:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: ieee754[sd]p_neg workaround
Message-ID: <20050420131304.GF5212@linux-mips.org>
References: <20050420.174023.113589096.nemoto@toshiba-tops.co.jp> <Pine.LNX.4.61L.0504201312520.7109@blysk.ds.pg.gda.pl> <16998.20933.14301.397793@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16998.20933.14301.397793@arsenal.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 20, 2005 at 01:57:41PM +0100, Dominic Sweetman wrote:

> So file a bug against glibc, but we should fix the emulator so it
> correctly imitates the MIPS instruction set...

As a matter of defensive design I think we should try to follow the
establish behaviour if nothing more specific is defined anywhere.

  Ralf
