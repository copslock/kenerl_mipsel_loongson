Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 16:51:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48630 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492478Ab0CQPvq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 16:51:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2HFpa1d008172;
        Wed, 17 Mar 2010 16:51:37 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2HFpVXZ008159;
        Wed, 17 Mar 2010 16:51:31 +0100
Date:   Wed, 17 Mar 2010 16:51:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
Cc:     Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-ID: <20100317155126.GE4554@linux-mips.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
 <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
 <20100301023316.GB23086@linux-sh.org>
 <9cdbb57f1003020713x4e897af9ka87e348bf782f380@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdbb57f1003020713x4e897af9ka87e348bf782f380@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 02, 2010 at 04:13:11PM +0100, Andrea Gelmini wrote:

> 2010/3/1 Paul Mundt <lethal@linux-sh.org>:
> Hi Paul,
>    thanks for your reply.
> 
> > I'll apply the sh part by itself, and I suppose Ralf will do the same for
> > MIPS. I'm a bit confused as to why these were lumped together when 65 out
> > of 66 oneliner patches made no use of ad-hoc grouping.
> 
> After the experience with GregKH, I was looking for others maintainer
> interested in code cleanup. So I sent some patches over random files.
> If you care, I can checkpatch.pl all mips subtree and send you patches (if any).

Feel free to - but remember that the coding style document is a guideline
not something to be followed unconditionally.

  Ralf
