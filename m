Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 14:09:30 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:17695 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226327AbVGFNJO>; Wed, 6 Jul 2005 14:09:14 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j66D9MTM017205;
	Wed, 6 Jul 2005 14:09:22 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j66D9MOq017204;
	Wed, 6 Jul 2005 14:09:22 +0100
Date:	Wed, 6 Jul 2005 14:09:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arianna Arona <arianna@dsi.unimi.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.12 DOES read MAC address
Message-ID: <20050706130921.GJ3226@linux-mips.org>
References: <200507061448.02561.arianna@dsi.unimi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061448.02561.arianna@dsi.unimi.it>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 06, 2005 at 02:48:02PM +0200, Arianna Arona wrote:

> I've compiled the kernel myself and now it reads MAC address at boot time.
> Problem solved? NO. Ethernet card does not trasmit any packets on the net.
> 
> I have a question: how is your ethernet card? Mine is a card with network, 2 
> consoles and a SCSI port in it. Could be this the problem?

Same IOC3 card as every Origin.  We're looking into the issue.  Part of
the problems seems to be the hardware isn't behaving exactly the way I
thought it is meant to ...

  Ralf
