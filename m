Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 20:47:19 +0100 (BST)
Received: from alg145.algor.co.uk ([62.254.210.145]:61199 "EHLO
	dmz.algor.co.uk") by ftp.linux-mips.org with ESMTP id S3465590AbVI3TrB
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 20:47:01 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1ELQoL-0003Jm-00; Fri, 30 Sep 2005 20:44:49 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ELQqC-0002BW-00; Fri, 30 Sep 2005 20:46:44 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17213.38447.42728.297338@mips.com>
Date:	Fri, 30 Sep 2005 20:46:55 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: RFC: Revise n32 ptrace interface
In-Reply-To: <20050930000550.GE3983@linux-mips.org>
References: <20050922182601.GA10829@nevyn.them.org>
	<20050930000550.GE3983@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.846,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> I quite deliberately did omit DSP support from 64-bit ptrace(2); there
> is currently no MIPS64 processor with DSP support that I know of.

This is true so far. 

But assuming that 64-bit processing becomes increasingly interesting
(which seems certain) and that some kind of DSP support with extra
registers remains attractive (which seems fairly likely)... well, I'd
have said that any 64-bit MIPS CPU configured from now on is quite
likely to have extra DSP registers.

So while "you aren't going to need it" for a while, anyone thinking of
doing a non-compatible change to ptrace might want to reserve some
space for these registers.

--
Dominic
