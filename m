Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2004 17:44:57 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65007 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224987AbUBPRo5>;
	Mon, 16 Feb 2004 17:44:57 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i1GHirtS011719;
	Mon, 16 Feb 2004 09:44:53 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i1GHiqhe011717;
	Mon, 16 Feb 2004 09:44:52 -0800
Date: Mon, 16 Feb 2004 09:44:52 -0800
From: Jun Sun <jsun@mvista.com>
To: Kaz Sasayama <kazssym@netscape.net>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Linux 2.6 on DDB5477?
Message-ID: <20040216174452.GA11711@mvista.com>
References: <067BC2F8.2E443D82.001F92DE@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067BC2F8.2E443D82.001F92DE@netscape.net>
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 16, 2004 at 12:19:32AM -0500, Kaz Sasayama wrote:
> Is anyone working on DDB5477 config of Linux 2.6?  I tried to compile it 
> but got many errors that I could not fix completely.  If there is a working
> patch, please let me know.
> 

It basically works fine here, with a couple of known issues:

. sound driver is broken.  Just comment it out.
. if you use rockhopper baseboard, you will the following patch to access
  the ethernet on baseboard.  [Ralf, we need to fix origin and apply this
  patch somehow]
. under long time stress test, ether driver may go down.

Jun

diff -u -r1.25 pci.c
--- arch/mips/pci/pci.c 19 Jan 2004 16:28:13 -0000      1.25
+++ arch/mips/pci/pci.c 16 Feb 2004 17:41:38 -0000
@@ -166,7 +166,7 @@
 
        pci_read_config_word(dev, PCI_COMMAND, &cmd);
        old_cmd = cmd;
-       for(idx=0; idx<6; idx++) {
+       for(idx=0; idx< PCI_NUM_RESOURCES; idx++) {
                /* Only set up the requested stuff */
                if (!(mask & (1<<idx)))
                        continue;
