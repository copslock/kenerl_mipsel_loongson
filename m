Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Oct 2010 03:54:26 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1492025Ab0JBByW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Oct 2010 03:54:22 +0200
Date:   Sat, 2 Oct 2010 10:54:17 +0900
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, jbaron@redhat.com
Subject: Re: [PATCH] jump label: Add MIPS support.
Message-ID: <20101002015417.GA9360@linux-mips.org>
References: <1285697432-29244-1-git-send-email-ddaney@caviumnetworks.com>
 <1285969786.6750.19.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285969786.6750.19.camel@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 01, 2010 at 05:49:46PM -0400, Steven Rostedt wrote:

> On Tue, 2010-09-28 at 11:10 -0700, David Daney wrote:
> > When in Rome...
> > 
> > In order not to be left behind, we add jump label support for MIPS.
> > 
> > Tested on 64-bit big endian (Octeon), and 32-bit little endian
> > (malta/qemu).
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Jason Baron <jbaron@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> 
> I can pull this into tip with an Acked-by from Ralf. He was just in
> Tokyo with me, and I don't know when he'll be available to do so.

Monday probably.  Just packing up for the airport.

  Ralf
