Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 14:10:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37838 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492245Ab0BBNKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 14:10:00 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o12DAGSS014197;
        Tue, 2 Feb 2010 14:10:16 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o12DAGVv014196;
        Tue, 2 Feb 2010 14:10:16 +0100
Date:   Tue, 2 Feb 2010 14:10:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v5] Virtual memory size detection for 64 bit MIPS CPUs
Message-ID: <20100202131015.GB13987@linux-mips.org>
References: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com>
 <20100202130153.GB10837@linux-mips.org>
 <90edad821002020505x6ecfd03ejb03f316d9859b9db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad821002020505x6ecfd03ejb03f316d9859b9db@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 03:05:49PM +0200, Dmitri Vorobiev wrote:

> On Tue, Feb 2, 2010 at 3:01 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, Feb 02, 2010 at 02:37:41AM -0800, Guenter Roeck wrote:
> >
> > Pretty good, let the nitpicking start :-)
> 
> I haven't been following this closely enough, so maybe my question is
> stupid. However: will this work on SGI R5000? I'm using an Indy, so
> I'm quite concerned about this CPU.

The point is that your Indy right now is not working with a 64-bit kernel :)

  Ralf
