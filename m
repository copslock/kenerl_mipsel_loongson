Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 13:26:52 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:55052 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225237AbUIBM0s>;
	Thu, 2 Sep 2004 13:26:48 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1C2qqL-0001pr-00; Thu, 02 Sep 2004 13:37:33 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1C2qfi-0001L1-00; Thu, 02 Sep 2004 13:26:34 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.4428.432876.304398@mips.com>
Date: Thu, 2 Sep 2004 13:25:48 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>, Emmanuel Michon <em@realmagic.fr>,
	linux-mips@linux-mips.org
Subject: Re: TLB dimensioning
In-Reply-To: <20040901233550.GA5721@linux-mips.org>
References: <1094033224.20643.1402.camel@nikita.france.sdesigns.com>
	<16693.52862.859233.198626@doms-laptop.algor.co.uk>
	<20040901233550.GA5721@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.849, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> The kernel's performance also relies on TLB performance.
> 
> The wired register is making it easy to test performance of kernel and
> application with a reduced size TLB; maybe I should make that a kernel
> feature.

An excellent suggestion.
