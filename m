Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 21:54:06 +0100 (BST)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:46294 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8225458AbUC2Ux5>;
	Mon, 29 Mar 2004 21:53:57 +0100
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i2TKiFUr024693;
	Mon, 29 Mar 2004 12:44:15 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i2TKriO4009385;
	Mon, 29 Mar 2004 12:53:45 -0800 (PST)
Message-ID: <008901c415d0$3a94d5f0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Steven J. Hill" <sjhill@realitydiluted.com>,
	"Brian Murphy" <brian@murphy.dk>
Cc: <linux-mips@linux-mips.org>
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com>
Subject: Re: BUG in pcnet32.c?
Date: Mon, 29 Mar 2004 22:55:52 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Excellent. So my new BUG code detected another bad network driver. Your network
> driver is broken and it needs fixed. I will refer you to these posts between
> Jeff Garzik and myself when I found a similar issue on the 'natsemi.c' driver.
> Mapping a PCI address with length zero is a BUG, period. You length should
> be the maximum RX buffer length + 2. You will see from the patches in the
> messages below that this is for IP header alignment. Good luck and please let
> use know how it turns out.

Which reminds me of something I've been meaning to mention for a while.
Back in the dark days of Linux 2.2 on MIPS, I discovered that a number
of network drivers were subtly broken for MIPS because they allocated
enough extra space for IP header alignment, but not for cache line alignment.
Particularly on CPUs with write-back caches, it can be a Bad Thing if a cache 
line straddles two packet buffers, as the flush of one can cause the other to be
clobbered.  I had to redefine the alignment constant for MIPS to be a function
of the line size to have 100% solid operation of the Tulip and pcnet32 drivers.

The whole network driver cache management paradigm was redone for 2.4,
and I've often wondered whether the same potential problem exists, but never
had the time to go in and check.

There, I've mentioned it.  My conscience is clear.  ;o)
