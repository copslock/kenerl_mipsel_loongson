Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 23:32:37 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:6675 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225335AbUJNWcb>; Thu, 14 Oct 2004 23:32:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E2F93F59B4; Fri, 15 Oct 2004 00:32:20 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26160-06; Fri, 15 Oct 2004 00:32:20 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9A18FF59A2; Fri, 15 Oct 2004 00:32:20 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9EMWc6C018017;
	Fri, 15 Oct 2004 00:32:39 +0200
Date: Thu, 14 Oct 2004 23:32:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
In-Reply-To: <416EFBAB.8050600@mvista.com>
Message-ID: <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org>
 <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Oct 2004, Manish Lachwani wrote:

> Honestly, I dont have the manual to determine the port address space 

 Well, have you considered getting one?

> bits. Hence, I set it to this value to MAX (i.e. 0xffffffff). Probably, 
> should have mentioned that when sending the patch. Do you want me to try 
> with this value (0x01ffffff) ?

 Absolutely -- unfortunately I cannot test the change myself ATM.

  Maciej
