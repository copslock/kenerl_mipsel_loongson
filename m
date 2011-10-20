Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2011 15:33:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41844 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491152Ab1JTNcy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2011 15:32:54 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9KDWoFC007427;
        Thu, 20 Oct 2011 14:32:50 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9KDWmRK007408;
        Thu, 20 Oct 2011 14:32:48 +0100
Date:   Thu, 20 Oct 2011 14:32:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: fix the build with C=1
Message-ID: <20111020133248.GA20032@linux-mips.org>
References: <1319063607-11316-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319063607-11316-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14974

On Thu, Oct 20, 2011 at 01:33:27AM +0300, Aaro Koskinen wrote:

> When trying to compile the 3.1-rc10 kernel for my MIPS board with C=1
> (sparse checking), the build fails early with the error:

This is triggered by builds with GCC 4.5 and newer.

Applied.  Thanks!

  Ralf
