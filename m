Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:49:33 +0100 (BST)
Received: from kluster2.contactor.se ([193.15.23.26]:45291 "EHLO
	kluster2.contactor.se") by ftp.linux-mips.org with ESMTP
	id S20038808AbWJMMt2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:49:28 +0100
Received: from linux3.contactor.se (linux3.contactor.se [193.15.23.23])
	by kluster2.contactor.se (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id k9DCnGfu021294;
	Fri, 13 Oct 2006 14:49:16 +0200
Date:	Fri, 13 Oct 2006 14:49:16 +0200 (CEST)
From:	Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@linux3.contactor.se
To:	Dr Stephen Henson <lists@drh-consultancy.demon.co.uk>
cc:	linux-mips@linux-mips.org
Subject: Re: Problems with UPD61130 bootloader...
In-Reply-To: <452F89B6.7080401@drh-consultancy.demon.co.uk>
Message-ID: <Pine.LNX.4.64.0610131446040.12637@yvahk3.pbagnpgbe.fr>
References: <452F89B6.7080401@drh-consultancy.demon.co.uk>
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on kluster2.contactor.se
X-Virus-Status:	Clean
Return-Path: <daniel@haxx.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@haxx.se
Precedence: bulk
X-list: linux-mips

On Fri, 13 Oct 2006, Dr Stephen Henson wrote:

> There is an effort underway to port linux to the Topfield TF5800 PVR, it
> uses the NEC UPD61130 EMMA2 chipset.

...

> It seems that documents for this chipset are only available under NDA
> from NEC: is that correct?

Seems very likely, as other EMMA2 products seem to be under such restrictions.

There is however at least some sort of support for emma2rh in the 2.6.18 
kernel, so perhaps there have been some changes in their attitude.
