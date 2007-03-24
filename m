Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 16:01:37 +0000 (GMT)
Received: from mail.blastwave.org ([147.87.98.10]:11191 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20022760AbXCXQBe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Mar 2007 16:01:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 60504F949;
	Sat, 24 Mar 2007 17:01:03 +0100 (MET)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UnMa-DRS2UB2; Sat, 24 Mar 2007 17:00:55 +0100 (MET)
Received: from jashugan.kinali.ch (jashugan.kinali.ch [213.144.135.203])
	by mail.blastwave.org (Postfix) with SMTP id 72F65F92A;
	Sat, 24 Mar 2007 17:00:55 +0100 (MET)
Date:	Sat, 24 Mar 2007 17:00:54 +0100
From:	Attila Kinali <attila@kinali.ch>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Marco Braga <marco.braga@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
Message-Id: <20070324170054.de933b0e.attila@kinali.ch>
In-Reply-To: <460532BF.6080605@ru.mvista.com>
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
	<20070324072308.c69557d0.attila@kinali.ch>
	<460532BF.6080605@ru.mvista.com>
Organization: NERV
X-Mailer: Sylpheed 2.4.0beta4 (GTK+ 2.8.20; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

On Sat, 24 Mar 2007 17:16:31 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> 4.3.9 System Considerations
> 
> The Au1550 PCI controller cannot be used with external PCI-to-PCI bridges that 
> have PCI bus-mastering devices on the secondary bus which target the Au1550 
> memory.

Damn, i overlooked that.
I guess we have to make some provisions that cardbus
cards don't do DMA into the alchemy :(

Thanks
			Attila Kinali

-- 
Linux ist... wenn man einfache Dinge auch mit einer kryptischen
post-fix Sprache loesen kann
                        -- Daniel Hottinger
