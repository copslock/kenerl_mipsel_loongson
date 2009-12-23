Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Dec 2009 13:40:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56367 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492459AbZLWMka (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Dec 2009 13:40:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBNCeVxq012022;
        Wed, 23 Dec 2009 12:40:31 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBNCeT2o012005;
        Wed, 23 Dec 2009 12:40:29 GMT
Date:   Wed, 23 Dec 2009 12:40:29 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     hermit <hermitcranecn@yahoo.com.cn>
Cc:     linux-mips@linux-mips.org
Subject: Re: Do_ade
Message-ID: <20091223124029.GA11295@linux-mips.org>
References: <26871250.post@talk.nabble.com>
 <20091223004130.GA31076@dvomlehn-lnx2.corp.sa.net>
 <26897656.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26897656.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 23, 2009 at 02:42:48AM -0800, hermit wrote:

>        My GCC version is 4.2.3. it seems that it is not too old. I believe
> there is bad pointer arithmetic. 
>        Here is the do_ade print:
>        do_ade, 542 address error exception occurs! MediaPlayerServ(pid:839)
>         (a0 == 7edff5b6 a1 == 302daaca a2 == 00000002 a3 == 302daaca)
>         (gp == 302e2730 sp == 7edff578 t9 == 2afb4640)
>         (epc == 302c3250, ra == 302c3388)
>         Suppose we can find which function cause "bad pointer arithmetic". 
>         I am new to MIPS, anybody can tell me how i can find the function?
>         Thanks!

This is not the normal kernel printout.  It would seem that somebody who
didn't know about the existence of the logging code added this code.  The
number 542 presumably is a line number and do_ade is in
arch/mips/kernel/unaligned.c.  So look around line 542 in that file.

  Ralf
