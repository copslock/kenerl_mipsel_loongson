Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 17:23:55 +0100 (CET)
Received: from g1t0029.austin.hp.com ([15.216.28.36]:11064 "EHLO
        g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492404Ab0BXQXt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 17:23:49 +0100
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
        by g1t0029.austin.hp.com (Postfix) with ESMTP id 3EEBD382E1;
        Wed, 24 Feb 2010 16:23:43 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g1t0039.austin.hp.com (Postfix) with ESMTP id 1D9AB3411B;
        Wed, 24 Feb 2010 16:23:42 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id F2FFBCF0084;
        Wed, 24 Feb 2010 09:23:41 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D98mpEt4Xr7o; Wed, 24 Feb 2010 09:23:41 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id DE760CF0008;
        Wed, 24 Feb 2010 09:23:41 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Reverting old hack
Date:   Wed, 24 Feb 2010 09:23:39 -0700
User-Agent: KMail/1.9.10
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20100220113134.GA27194@linux-mips.org> <201002231601.15136.bjorn.helgaas@hp.com> <20100224161341.GC5130@linux-mips.org>
In-Reply-To: <20100224161341.GC5130@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002240923.40797.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Wednesday 24 February 2010 09:13:41 am Ralf Baechle wrote:
> On Tue, Feb 23, 2010 at 04:01:14PM -0700, Bjorn Helgaas wrote:
> 
> > Yoichi, can you try the patch below?  I think this is basically the
> > approach Ben suggested long ago:
> >     http://marc.info/?l=linux-kernel&m=119733290624544&w=2
> 
> No Signed-off-by ...

Yep, I'll update it with a proper changelog and S-O-B.  I want to
look at the other platforms that have non-zero io_offsets; they
might need similar quirks.

Bjorn
