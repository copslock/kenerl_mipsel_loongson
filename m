Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 11:12:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39451 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491800Ab1EMJMa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 11:12:30 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4D9BvIW024060;
        Fri, 13 May 2011 10:11:57 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4D9Buda024058;
        Fri, 13 May 2011 10:11:56 +0100
Date:   Fri, 13 May 2011 10:11:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix build breakage in cpu-probe.c
Message-ID: <20110513091156.GA18174@linux-mips.org>
References: <1305246299-7517-1-git-send-email-ddaney@caviumnetworks.com>
 <BANLkTim4UXhMC9BWvSgFWbWCiR4AdWjGeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTim4UXhMC9BWvSgFWbWCiR4AdWjGeg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 12, 2011 at 06:26:09PM -0700, Kevin Cernekee wrote:

> BTW: the commit messages got a little messed up on the two patches
> that had a secondary "From:" header to override the author field.  Is
> there something I should be doing differently here?

You did exactly the right thing.  I messed up when manually converting the
patch files into the pseudo quilt format I'm using for linux-queue.

  Ralf
