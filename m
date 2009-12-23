Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2009 19:16:19 +0100 (CET)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:45282 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492384AbZLWSQO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Dec 2009 19:16:14 +0100
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEALDtMUurRN+J/2dsb2JhbADBXZcJhDME
X-IronPort-AV: E=Sophos;i="4.47,443,1257120000"; 
   d="scan'208";a="66927732"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 23 Dec 2009 18:15:59 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBNIFxRw023958;
        Wed, 23 Dec 2009 18:15:59 GMT
Date:   Wed, 23 Dec 2009 10:15:59 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     hermit <hermitcranecn@yahoo.com.cn>, linux-mips@linux-mips.org
Subject: Re: Do_ade
Message-ID: <20091223181558.GA10047@dvomlehn-lnx2.corp.sa.net>
References: <26871250.post@talk.nabble.com> <20091223004130.GA31076@dvomlehn-lnx2.corp.sa.net> <26897656.post@talk.nabble.com> <20091223124029.GA11295@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091223124029.GA11295@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 23, 2009 at 06:40:29AM -0600, Ralf Baechle wrote:
> On Wed, Dec 23, 2009 at 02:42:48AM -0800, hermit wrote:
> 
> >        My GCC version is 4.2.3. it seems that it is not too old. I believe
> > there is bad pointer arithmetic. 
> >        Here is the do_ade print:
> >        do_ade, 542 address error exception occurs! MediaPlayerServ(pid:839)
> >         (a0 == 7edff5b6 a1 == 302daaca a2 == 00000002 a3 == 302daaca)
> >         (gp == 302e2730 sp == 7edff578 t9 == 2afb4640)
> >         (epc == 302c3250, ra == 302c3388)
> >         Suppose we can find which function cause "bad pointer arithmetic". 
> >         I am new to MIPS, anybody can tell me how i can find the function?
> >         Thanks!
> 
> This is not the normal kernel printout.  It would seem that somebody who
> didn't know about the existence of the logging code added this code.  The
> number 542 presumably is a line number and do_ade is in
> arch/mips/kernel/unaligned.c.  So look around line 542 in that file.

If I understand hermit's problem, knowing the line in unaligned.c won't
help much since the problem appears to be in the application MediaPayerServ.
My suggestion is to use addr2line on the location where the exception
occurred, which is the EPC value 302c3250. The addr2line utility can be used
on the unstripped version of the userspace executable to determine the
function, file, and line number where the unaligned access was made.

>   Ralf

-- 
David VL
