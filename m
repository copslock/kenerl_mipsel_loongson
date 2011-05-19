Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 12:29:01 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36266 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491055Ab1ESK26 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 12:28:58 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JAT1lA010854;
        Thu, 19 May 2011 11:29:01 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JASxxo010851;
        Thu, 19 May 2011 11:28:59 +0100
Date:   Thu, 19 May 2011 11:28:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Philby John <pjohn@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
Message-ID: <20110519102859.GA10389@linux-mips.org>
References: <1302710833.14458.1.camel@localhost.localdomain>
 <4DA5DF7A.1030207@caviumnetworks.com>
 <1302803815.3322.4.camel@localhost.localdomain>
 <4DA74DFE.7030905@mvista.com>
 <4DA752CE.3010009@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA752CE.3010009@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 14, 2011 at 01:02:22PM -0700, David Daney wrote:

> Can someone with a defective bootloader verify that a zero size
> PT_NOTE header is as good as *no* PT_NOTE header?
> 
> If so, we should just omit the patch all together and tell people
> who are interested to use the strip command instead.

Where are we with this patch?  It's still bitrotting in patchworks and
the discussion did not seem to have come to a conclusion.  So for now
I'm going to mark https://patchwork.linux-mips.org/patch/2295/ as
"rejected" unless somebody convinces me to resurrect it again.

  Ralf
