Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 09:09:51 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:40717 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225241AbTFEIJs>;
	Thu, 5 Jun 2003 09:09:48 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19Nprv-0000hj-00; Thu, 05 Jun 2003 09:13:07 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 19Npo1-0006vT-00; Thu, 05 Jun 2003 09:09:05 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16094.64161.12926.645512@doms-laptop.algor.co.uk>
Date: Thu, 5 Jun 2003 09:09:05 +0100
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
In-Reply-To: <20030604183836.B25414@mvista.com>
References: <20030604153930.H19122@mvista.com>
	<20030604231547.GA22410@linux-mips.org>
	<20030604164652.J19122@mvista.com>
	<20030605001232.GA5626@linux-mips.org>
	<20030604183836.B25414@mvista.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-17.4, required 4, AWL,
	BAYES_01, QUOTED_EMAIL_TEXT, REFERENCES)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips



> Therefore for a set of "conforming" SMP systems which don't
> have the listed 3 issues, we provide a feasible solution.
> I don't see how we can avoid this - unless we don't care about
> getting time right.

Interesting.  I guess you only need to get time "right enough" -
there's an unavoidable fuzziness about the synchronisation of events
on different CPUs (corresponding to the uncertainties of the timing of
any rendezvous between them).

A naive network synchronisation protocol - analogous to your first
proposal - would leave clocks differing by a network round-trip time
or so: but NTP does a lot better.  So in principle you should be able
to scale NTP to create a clock synchronised within some fraction of
the time taken by a CPU-to-CPU communication... but compressing the
essence of the NTP protocol into something which runs fast enough
might be interesting!

My 5-minutes-over-breakfast feeling is that you should be able to
figure out a way to get time right enough; try reading up how NTP
works and see whether it can be made to work?

--
Dominic
