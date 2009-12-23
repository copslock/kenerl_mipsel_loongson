Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2009 01:41:42 +0100 (CET)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:18626 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493662AbZLWAli (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Dec 2009 01:41:38 +0100
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAGP2MEurRN+J/2dsb2JhbADBXpcHhDME
X-IronPort-AV: E=Sophos;i="4.47,439,1257120000"; 
   d="scan'208";a="66572317"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 23 Dec 2009 00:41:30 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBN0fU7b028081;
        Wed, 23 Dec 2009 00:41:30 GMT
Date:   Tue, 22 Dec 2009 16:41:30 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     hermit <hermitcranecn@yahoo.com.cn>
Cc:     linux-mips@linux-mips.org
Subject: Re: Do_ade
Message-ID: <20091223004130.GA31076@dvomlehn-lnx2.corp.sa.net>
References: <26871250.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26871250.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 21, 2009 at 02:47:22AM -0600, hermit wrote:
> 
> We are trying to run WEBkit on MIPS 24ke system.
> we found a lot of "do_ade" print. but system doesn't crash. 
> because of do_ade print, the system performance seems poor.
> I wonder if there is any compile flag can remove do_ade warning?
> Thanks!
> -- 
> View this message in context: http://old.nabble.com/Do_ade-tp26871250p26871250.html
> Sent from the linux-mips main mailing list archive at Nabble.com.
> 
> 

If you get messages from do_ade(), it means that your application is
accessing data that is not aligned on a boundary that is a multiple
of the size of the data. Accessing such unaligned data causes an exception
that one would typically expect to kill your process. Fortunately, or
unfortunately, depending on your view, the code that handles this exception
can be configured to do one of three things:

o	Send a SIGBUS signal to your process, which generally kills it
o	Print a message and then emulate the unaligned load or store
o	Silently emulate the unaligned load or store

It sounds like your system is configured for the print and emulate option.
The emulation is quite a bit slower than a simple aligned load or store,
so I am not surprised you are seeing noticable performance impact. The warning
may be impacting your performance as it is printed sychronously, but even
if you silence the warning, your performance will suffer.

There are various ways that you can get unaligned accesses. One is to have
code that does bad pointer arithmetic. Another possiblity, one that I
encountered recently, is to have a bad gcc. IIRC gcc 4.1.0 had this problem.
Upgrading the version of gcc caused the problem to go away, but it wasn't
really clear what bug fix did the job. Anyway, I know that verson 4.3.2
works as you would expect.

I strongly recommend, if you have an older gcc, that you upgrade. An
instruction emulated through exception handling can easily be a hundred times
slower than that instruction operating on aligned data. If, however, you
really only want to quiet the warning, you must first mount the debugfs
filesystem: "mount -t debugfs debug /proc/sys/debug". Then write a zero to
/proc/sys/debug/mips/unaligned_action, i.e.
echo 0 >/proc/sys/debug/mips/unaligned_action.

-- 
David VL
