Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2011 09:49:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37666 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491033Ab1FVHtd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jun 2011 09:49:33 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5M7nVZw016757;
        Wed, 22 Jun 2011 08:49:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5M7nUMB016753;
        Wed, 22 Jun 2011 08:49:30 +0100
Date:   Wed, 22 Jun 2011 08:49:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS:Netlogic:Specify architecture CFLAGS
Message-ID: <20110622074930.GA16240@linux-mips.org>
References: <20110621200627.GA16193@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110621200627.GA16193@jayachandranc.netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17873

On Wed, Jun 22, 2011 at 01:36:33AM +0530, Jayachandran C wrote:

> Use -march=xlr if available, otherwise fallback to mips64. This allows
> us to support compilation with MIPS toolchains which are not customized
> for XLR.

And it also works around the gas assertion error so applied.  Otherwise
I'd have only queued this for the next release after 3.0(.0).

  Ralf
