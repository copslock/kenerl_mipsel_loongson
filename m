Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 00:43:43 +0100 (BST)
Received: from p508B7223.dip.t-dialin.net ([IPv6:::ffff:80.139.114.35]:23060
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225489AbUC3Xnn>; Wed, 31 Mar 2004 00:43:43 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2UNhgoM007933;
	Wed, 31 Mar 2004 01:43:42 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2UNhgxl007932;
	Wed, 31 Mar 2004 01:43:42 +0200
Date: Wed, 31 Mar 2004 01:43:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Lijun Chen <chenli@nortelnetworks.com>
Cc: linux-mips@linux-mips.org
Subject: Re: exception priority for BCM1250
Message-ID: <20040330234342.GB7543@linux-mips.org>
References: <4069F90D.9060903@americasm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4069F90D.9060903@americasm01.nt.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 30, 2004 at 05:47:41PM -0500, Lijun Chen wrote:

> Does anybody know which mips family SB1 core on bcm1250 falls into?
> It is a MIPS64 processor, does it belong to 5K family or 20Kc?

They're all MIPS64.

> What about the exception priorities, such as cache error exception, bus 
> error exception, and so on? Are they maskable or non-maskable? It is not
> clear from BCM1250 and sb1 core manuals.

This is explained in the MIPS64 spec.

  Ralf
