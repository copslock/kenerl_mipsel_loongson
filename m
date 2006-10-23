Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 22:30:28 +0100 (BST)
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59819 "EHLO
	ch-smtp02.sth.basefarm.net") by ftp.linux-mips.org with ESMTP
	id S20038803AbWJWVa0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 22:30:26 +0100
Received: from c83-250-8-219.bredband.comhem.se ([83.250.8.219]:60088 helo=mail.ferretporn.se)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <creideiki+linux-mips@ferretporn.se>)
	id 1Gc7NJ-0005SK-7k; Mon, 23 Oct 2006 23:30:25 +0200
Received: from peepoe.ferretporn.se (peepoe.ferretporn.se [192.168.0.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ferretporn.se (Postfix) with ESMTP id 944EDD1B3;
	Mon, 23 Oct 2006 23:30:24 +0200 (CEST)
From:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Extreme system overhead on large IP27
Date:	Mon, 23 Oct 2006 23:30:19 +0200
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se> <20061022232316.GA19127@linux-mips.org> <20061023001947.GA10853@linux-mips.org>
In-Reply-To: <20061023001947.GA10853@linux-mips.org>
X-Eric-Conspiracy: There is no conspiracy
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232330.23498.creideiki+linux-mips@ferretporn.se>
X-Scan-Result: No virus found in message 1Gc7NJ-0005SK-7k.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1Gc7NJ-0005SK-7k 2940e6f3072fafe5fc755d3f0cd898c0
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

On Monday 23 October 2006 02:19, Ralf Baechle wrote:
> Can you test below patch which adds oprofile support for the R10000
> family processors?

I've tried it, and it doesn't solve my problem. With the patch 
applied, "opcontrol --list-events" seems correct, but I still get no data 
from OProfile, neither from the CYCLES nor the INSTRUCTIONS_GRADUATED 
event. /var/lib/oprofile/oprofiled.log just repeats:

   Nr. samples lost cpu buffer overflow: 0
   Nr. samples received: 0
   Nr. backtrace aborted: 0

I tried both on the full machine and on only the R12000 rack with identical 
results. The R12000 rack alone also has the original problem with large 
system overhead.

-- 
Karl-Johan Karlsson
