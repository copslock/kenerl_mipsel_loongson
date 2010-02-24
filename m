Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 18:00:08 +0100 (CET)
Received: from g1t0028.austin.hp.com ([15.216.28.35]:39504 "EHLO
        g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab0BXRAE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 18:00:04 +0100
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
        by g1t0028.austin.hp.com (Postfix) with ESMTP id C2BE51C7A9;
        Wed, 24 Feb 2010 16:59:57 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g1t0039.austin.hp.com (Postfix) with ESMTP id A0DEF34287;
        Wed, 24 Feb 2010 16:59:57 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 80475CF0084;
        Wed, 24 Feb 2010 09:59:57 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7P7f4WEZpzOC; Wed, 24 Feb 2010 09:59:57 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id 6B456CF0008;
        Wed, 24 Feb 2010 09:59:57 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Reverting old hack
Date:   Wed, 24 Feb 2010 09:59:56 -0700
User-Agent: KMail/1.9.10
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20100220113134.GA27194@linux-mips.org> <20100224090333.44a16d0a.yuasa@linux-mips.org> <20100224164100.GD5130@linux-mips.org>
In-Reply-To: <20100224164100.GD5130@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002240959.56706.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Wednesday 24 February 2010 09:41:00 am Ralf Baechle wrote:
> On Wed, Feb 24, 2010 at 09:03:33AM +0900, Yoichi Yuasa wrote:
> 
> > > approach Ben suggested long ago:
> > >     http://marc.info/?l=linux-kernel&m=119733290624544&w=2
> > 
> > It works fine with 2.6.34 queue tree.
> > pci.c change is already committed by Ralf.
> 
> Which I just dropped from queue.  To keep the tree bisectable removal of
> the old hack and adding the fixup should be done in the same patch so I'd
> go for Bjorn's patch.

Right, thanks.

> There is another somewhat theoretical correctness issue.  Because the
> VIA SuperIO chip only decodes 24 bits of address space but port address
> space currently being configured as 32MB there is the theoretical
> possibility of I/O port addresses that alias with legacy addresses getting
> allocated.

Does this mean my comment:

+        * but the VT82C586 IDE controller does respond at 0x100001f0 because
+        * it only decodes the low 16 bits of the address.

should say "24 bits" instead of "16 bits"?

Bjorn
