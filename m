Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 20:41:34 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:17938 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224902AbVDGTlT>; Thu, 7 Apr 2005 20:41:19 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j37JfADt028501;
	Thu, 7 Apr 2005 20:41:10 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j37Jf9aO028500;
	Thu, 7 Apr 2005 20:41:09 +0100
Date:	Thu, 7 Apr 2005 20:41:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pratik Patel <pratikgpatel@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: need libpcap.a for mipsel platform
Message-ID: <20050407194109.GA27344@linux-mips.org>
References: <fda764b0504071230516cde06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda764b0504071230516cde06@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 07, 2005 at 12:30:26PM -0700, Pratik Patel wrote:

> I wanted the libpcap.a file compiled for the MIPSEL flatform. I am
> working on Linksys WRT54GS router and I have problems compiling
> libpcap for target platform. I tried many different ways but no
> success!
> 
> If anyone has the pre-compiled libpcap.a file for MIPSEL platform,
> please mail it to me.

I suggest you get that from your favorite Linux distribution.

As a guess on a small system like the WRT54G you're using uclibc and I'd
expect some problem when building libpcap against uclibc.

  Ralf
