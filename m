Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 18:09:10 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:22252 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133655AbWAISIp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2006 18:08:45 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k09IB2Pc005743;
	Mon, 9 Jan 2006 10:11:03 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 09 Jan 2006 10:10:49 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k09IAmVP020146; Mon, 9
 Jan 2006 10:10:49 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 99DF82028; Mon, 9 Jan 2006
 11:10:48 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k09IJPak009954; Mon, 9 Jan 2006 11:19:25
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k09IJODT009953; Mon, 9 Jan 2006 11:19:24 -0700
Date:	Mon, 9 Jan 2006 11:19:24 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Rodolfo Giometti" <giometti@linux.it>
cc:	linux-mips@linux-mips.org
Subject: Re: ALCHEMY:  Add SD support to AU1200 MMC/SD driver
Message-ID: <20060109181924.GK17575@cosmic.amd.com>
References: <20051202190108.GF28227@cosmic.amd.com>
 <20051214134139.GN22061@hulk.enneenne.com>
 <20051214155324.GC9734@cosmic.amd.com>
 <20060109174505.GD1373@gundam.enneenne.com>
MIME-Version: 1.0
In-Reply-To: <20060109174505.GD1373@gundam.enneenne.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDC78A32C43579203-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 09/01/06 18:45 +0100, Rodolfo Giometti wrote:
> First of all I needed to disable the DMA support (dma = 0) and using
> the FIFO mode, since Au1100 dma support seems not well implemented (or
> not implemented at all) and my board freeze.

That sound you heard was me smacking my head because I'm an idiot.  Of
course, the DMA won't work for the AU1100, at least not that engine, so
you would certainly need to go for just PIO mode.

> After that, when I insert a 256MB MMC card I get the attached messages
> and the system refuses to power up the card (please, see the last
> message who reports the power status).

That message is innocent - it simply states that we couldn't identify your
card, so we're powering it down.  It looks like the card wasn't replying
to the CMD2, so the controller figured that there was nothing on the line.

> Have you any suggestions? :)

Well, first of all make sure that the driver is correct - I wrote it against
the AU1200 spec, so if there is something different in the AU1100 spec,
we'll have to #ifdef it.  Secondly, make sure the card really works.
Thirdly, you'll have to stick in printk() statements in the driver, to
make sure we're actually sending out the commands.  Finally, you might have
to stick a scope on the bus to make sure the protocol is sane on the
line.

Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
