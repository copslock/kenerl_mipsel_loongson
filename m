Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 16:58:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46581 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011764AbbFJO6HMsJ4V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jun 2015 16:58:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5AEw5kI007257;
        Wed, 10 Jun 2015 16:58:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5AEw49C007255;
        Wed, 10 Jun 2015 16:58:04 +0200
Date:   Wed, 10 Jun 2015 16:58:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Generic kernel features that need architecture(mips) support
Message-ID: <20150610145804.GG2753@linux-mips.org>
References: <55759543.1010408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55759543.1010408@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47917
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

On Mon, Jun 08, 2015 at 03:14:43PM +0200, Xose Vazquez Perez wrote:

> If there is anything wrong, please report it in this thread:
> https://marc.info/?t=143332955700003


>    locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API

This one was easy - we have the functions in the code just no "select
HAVE_CMPXCHG_LOCAL" Kconfig.

How are the documentation files in Documentation/features/ maintained?
They were automatically generated so I wonder if I have to take care
of anything.

  Ralf
