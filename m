Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 14:39:26 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:35855 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225933AbVCDOjL>; Fri, 4 Mar 2005 14:39:11 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j24EcDFL011272;
	Fri, 4 Mar 2005 14:38:13 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j24Ec8tL011260;
	Fri, 4 Mar 2005 14:38:08 GMT
Date:	Fri, 4 Mar 2005 14:38:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] Cobalt 1/2: tidy up PCI fixups
Message-ID: <20050304143808.GA10224@linux-mips.org>
References: <20050301083852.GA2017@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301083852.GA2017@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 01, 2005 at 08:38:52AM +0000, Peter Horton wrote:

> It's not necessary to hide Galileo if we correctly mark it as a host
> bridge.

Indeed, that's the right thing to do and it should be done on a bunch
of other systems also.

  Ralf
