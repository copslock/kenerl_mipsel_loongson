Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jul 2010 04:12:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42939 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491959Ab0GJCMt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Jul 2010 04:12:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6A2CTQ8017421;
        Sat, 10 Jul 2010 03:12:29 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6A2CSRB017418;
        Sat, 10 Jul 2010 03:12:28 +0100
Date:   Sat, 10 Jul 2010 03:12:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Li Hong <lihong.hi@gmail.com>, Ingo Molnar <mingo@elte.hu>,
        Matt Fleming <matt@console-pimps.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] tracing: recordmcount.pl: Fix $mcount_regex for MIPS.
Message-ID: <20100710021227.GA16134@linux-mips.org>
References: <1278712325-12050-1-git-send-email-ddaney@caviumnetworks.com>
 <1278721562.1537.169.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1278721562.1537.169.camel@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 09, 2010 at 08:26:02PM -0400, Steven Rostedt wrote:

> I'd like to get an Acked-by from Ralf and Wu before pulling this.

I talked through this on irc with David and it is the right thing to do.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
