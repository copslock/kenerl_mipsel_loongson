Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 19:34:33 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:18423 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225192AbTCaSec>;
	Mon, 31 Mar 2003 19:34:32 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA25323;
	Mon, 31 Mar 2003 10:34:25 -0800
Subject: Re: Au1500 hardware cache coherency
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E882FB8.BBFDACE2@ekner.info>
References: <3E882FB8.BBFDACE2@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1049135714.26674.19.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 10:35:14 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


> So before spending more time on debugging this, and creating patches
> for using HW coherency, I wanted to hear your input - maybe there are
> known problems in the Au1500 coherency implementation?

Looks like Eric already replied to your questions.

Patches to get the code to compile with NONCOHERENT_IO turned off would
be good, even if you don't want to do that yet. 

FYI, in the latest kernel I'm getting a panic when doing a very large
'cp -a' from nfs to ata100 disk (don't know if the disk itself matters)
(Pb1500 and Db1500).  The same test passes with a 2.4.18 kernel, so it
seems like it's not a hardware issue, unless the 2.4.18 kernel is just
getting lucky.  I'll be gone till 4/20 so I won't have time to debug it
until after I get back.

Pete
