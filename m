Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 22:50:18 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27122 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225223AbTCMWuR>;
	Thu, 13 Mar 2003 22:50:17 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA26741;
	Thu, 13 Mar 2003 14:50:14 -0800
Subject: Re: Patches for Au1000: PCI int problem, DB1500 board reset &
	ethernet
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E70E52E.B6FF1C2A@ekner.info>
References: <3E70E52E.B6FF1C2A@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047595825.819.134.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:50:25 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


> The second patch adds board reset using HW register for DB1500.

OK, that's applicable to all Db boards so I modified the patch and
applied it; might need to cleanup that later (the long ifdef line).

Pete
