Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 11:21:49 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42473 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491192Ab1HBJVp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 11:21:45 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p729Lbqi018132;
        Tue, 2 Aug 2011 10:21:38 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p729Lapn018129;
        Tue, 2 Aug 2011 10:21:36 +0100
Date:   Tue, 2 Aug 2011 10:21:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Enable C0_UserLocal probing.
Message-ID: <20110802092136.GA12709@linux-mips.org>
References: <1309908953-1726-1-git-send-email-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309908953-1726-1-git-send-email-david.daney@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1160

On Tue, Jul 05, 2011 at 04:35:53PM -0700, David Daney wrote:

> Octeon2 processor cores have a UserLocal register.  Remove the hard
> coded negative probe and allow the standard probing to detect this
> feature.

Applied, thanks!

  Ralf
