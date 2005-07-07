Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 23:49:55 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:47027
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226319AbVGGWtj>; Thu, 7 Jul 2005 23:49:39 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j67MlNYA001251;
	Thu, 7 Jul 2005 23:47:24 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j67MlMhu001250;
	Thu, 7 Jul 2005 23:47:23 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	rolf liu <rolfliu@gmail.com>
Cc:	ppopov@embeddedalley.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b7205070711424c119780@mail.gmail.com>
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
	 <1120257851.5987.37.camel@localhost.localdomain>
	 <2db32b7205070508504b675dd6@mail.gmail.com>
	 <1120756200.317.14.camel@localhost.localdomain>
	 <2db32b7205070711424c119780@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120776436.317.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Thu, 07 Jul 2005 23:47:17 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Iau, 2005-07-07 at 19:42, rolf liu wrote:
> Alan,
> Tried your patch on db1550 and linux 2.6.12. It still doesn't work. 
> During the boot-up, the kernel will hang up right after it prints out:
> 
> >>hdg: max request size: 128 KiB

> Any suggestion?

Its got started if it gets that far because the LBA48 status has been
checked. What occurs if you boot with ide=nodma ?
