Received:  by oss.sgi.com id <S554079AbRBEDux>;
	Sun, 4 Feb 2001 19:50:53 -0800
Received: from c824216-a.stcla1.sfba.home.com ([24.176.212.15]:23539 "EHLO
        dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP id <S554040AbRBEDuq>;
	Sun, 4 Feb 2001 19:50:46 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f153iqB26896;
	Sun, 4 Feb 2001 19:44:52 -0800
Date:   Sun, 4 Feb 2001 19:44:52 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Quinn Jensen <jensenq@Lineo.COM>
Cc:     linux-mips@oss.sgi.com
Subject: Re: NFS root with cache on
Message-ID: <20010204194451.A26868@bacchus.dhis.org>
References: <3A79C869.2040001@Lineo.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A79C869.2040001@Lineo.COM>; from jensenq@Lineo.COM on Thu, Feb 01, 2001 at 01:34:49PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 01, 2001 at 01:34:49PM -0700, Quinn Jensen wrote:

> Is anyone else having trouble with NFS root on
> the 2.4.0 kernel?  It won't come up with the
> KSEG0 cache on unless I pepper the network driver
> with flush calls.

That's expected for most old network drivers that don't yet use the
new PCI DMA API documented in Documentation/DMA-mapping.txt.

What driver is this?

  Ralf
