Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 20:13:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47462 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827424Ab3FRSNQbBbyh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 20:13:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5IIDFsF029882;
        Tue, 18 Jun 2013 20:13:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5IICxjE029874;
        Tue, 18 Jun 2013 20:12:59 +0200
Date:   Tue, 18 Jun 2013 20:12:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: delete Wind River ppmc eval board support.
Message-ID: <20130618181259.GA29391@linux-mips.org>
References: <1371578470-29924-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371578470-29924-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Jun 18, 2013 at 02:01:10PM -0400, Paul Gortmaker wrote:

> This board has been EOL for many years now; lets not burden
> people doing build coverage and other tree wide work with
> working on essentially dead files.

Good riddance!

One of the platforms that I don't recall ever receiving any kind of
feedback for.  So I'm following the kill first, ask later protocol.
I queued the patch for 3.11 but people still have a chance of speaking
up :-)

  Ralf
