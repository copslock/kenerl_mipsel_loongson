Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 19:31:34 +0000 (GMT)
Received: from shu.cs.utk.edu ([160.36.56.39]:29388 "EHLO shu.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S8133604AbWA3TbQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2006 19:31:16 +0000
Received: from localhost (shu [127.0.0.1])
	by shu.cs.utk.edu (Postfix) with ESMTP id C6F1713B3B
	for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 14:36:06 -0500 (EST)
Received: from shu.cs.utk.edu ([127.0.0.1])
 by localhost (shu [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04532-03 for <linux-mips@linux-mips.org>;
 Mon, 30 Jan 2006 14:36:05 -0500 (EST)
Received: from [10.113.38.86] (unknown [80.187.154.31])
	by shu.cs.utk.edu (Postfix) with ESMTP id CAEC713B28
	for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 14:36:04 -0500 (EST)
Subject: /dev/cpuid or /proc/cpuinfo
From:	Philip Mucci <mucci@cs.utk.edu>
To:	Linux MIPS <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.44.0601271349350.2185-100000@bharathi.midascomm.com>
References: <Pine.LNX.4.44.0601271349350.2185-100000@bharathi.midascomm.com>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Mon, 30 Jan 2006 18:54:29 +0000
Message-Id: <1138647269.4077.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Hello MIPSers,

In reference to the performance counting thread we had going earlier,
I've noticed a 'feature' I need out of MIPS/Linux that isn't currently
available. This has also recently come up on the oprofile list with one
of the oprofile/mips tools not being able to grab cpu Mhz
from /proc/cpuinfo because it's not there.

I have need to execute the mfc0 instruction on the config register and
grok the results to find out things like cache size etc. In addition, it
might be nice to also actually be able to find out the clock rate.
(Currently I grab BogoMIPS and punt.)

On the intel and PPC systems, I believe you can execute similar
instructions from user mode which makes things easy. However, of course
an MFC0 is a privileged instruction...meaning that if the value or
values aren't found in /proc/cpuinfo, I'm s.o.l.

What does the list think about this? Making a mips /dev/cpuid is a bit
gross but extending and grokking /proc/cpuinfo is perhaps grosser...and
many tools do just this (like PAPI and oprofile's opreport...)

Comments? I'm certainly willing to implement this, but I'd rather 'do it
right the first time' rather than get rotten vegetables thrown my way.

Phil
