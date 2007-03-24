Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 06:23:45 +0000 (GMT)
Received: from mail.blastwave.org ([147.87.98.10]:64158 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20022497AbXCXGXn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Mar 2007 06:23:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 79A70F988;
	Sat, 24 Mar 2007 07:23:12 +0100 (MET)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id s40jtGPl9UNr; Sat, 24 Mar 2007 07:23:09 +0100 (MET)
Received: from jashugan.kinali.ch (jashugan.kinali.ch [213.144.135.203])
	by mail.blastwave.org (Postfix) with SMTP id C559BF97F;
	Sat, 24 Mar 2007 07:23:08 +0100 (MET)
Date:	Sat, 24 Mar 2007 07:23:08 +0100
From:	Attila Kinali <attila@kinali.ch>
To:	"Marco Braga" <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
Message-Id: <20070324072308.c69557d0.attila@kinali.ch>
In-Reply-To: <d459bb380703200933w501736cfmfbd19cc1b03f8ed1@mail.gmail.com>
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
	<200703200204.l2K24WgH020041@centurysys.co.jp>
	<45FFEDED.6060708@ru.mvista.com>
	<d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
	<45FFFE8B.1010806@ru.mvista.com>
	<d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>
	<4600052B.40901@ru.mvista.com>
	<d459bb380703200908t2ab759f0u352dc0014ebe0b17@mail.gmail.com>
	<46000ADD.3050309@ru.mvista.com>
	<d459bb380703200933w501736cfmfbd19cc1b03f8ed1@mail.gmail.com>
Organization: NERV
X-Mailer: Sylpheed 2.4.0beta4 (GTK+ 2.8.20; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

On Tue, 20 Mar 2007 17:33:54 +0100
"Marco Braga" <marco.braga@gmail.com> wrote:

> To sum it up, Cardbus bridge is not a viable solution on Au1500 for
> hotswapping devices, since any decent one (bus mastering) will not work.
> USB2.0 should instead work with PCI based controllers, that must be
> connected to the main PCI device (directly to Au1500).

We are using a board with a Au1550 with cardbus (PCI1520) and
USB2.0. The USB controller is directly connected to PCI.
Although cardbus isn't fully tested yet, USB seems to work fine
(atleast i haven't heard of any problems), but i don't know
from the top of my head which chip they used.

Also, the Au1550 doesn't seem to have the master-behind-bridge
bug as the 1500 does (at least according to the datasheet),
so i guess cardbus should work also with "decent" cards :)


HTH 
			Attila Kinali


-- 
Linux ist... wenn man einfache Dinge auch mit einer kryptischen
post-fix Sprache loesen kann
                        -- Daniel Hottinger
