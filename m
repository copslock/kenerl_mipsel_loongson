Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 17:48:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52060 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491891Ab1CCQr7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 17:47:59 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p23Glfhn004740;
        Thu, 3 Mar 2011 17:47:41 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p23GlcSx004736;
        Thu, 3 Mar 2011 17:47:38 +0100
Date:   Thu, 3 Mar 2011 17:47:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     kernelnewbies@nl.linux.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Memory Compaction feature.
Message-ID: <20110303164738.GA3863@linux-mips.org>
References: <AANLkTikFHPYf74QNKYEQD2o+=VvZgVNGgbbydcUiF0WF@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikFHPYf74QNKYEQD2o+=VvZgVNGgbbydcUiF0WF@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 03, 2011 at 06:32:35PM +0530, naveen yadav wrote:

[I changed the bogus linux-arm-kernel-request@lists.arm.linux.org.uk
address to linux-arm-kernel@lists.infradead.org.  I have no idea where
people keep pulling out -request addresses.]

> I want clarification is anybody verify this feature on ARM or MIPS architecture.
> 
> http://lwn.net/Articles/381677/

This got merged for 2.6.35 and as it doesn't tinker with architecture
specific code I assume it should just work on all architectures.  However
I have no reports of success or failure on MIPS.

  Ralf
