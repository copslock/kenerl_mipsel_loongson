Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 13:15:47 +0200 (CEST)
Received: from p508B7090.dip.t-dialin.net ([80.139.112.144]:23740 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123891AbSJALPr>; Tue, 1 Oct 2002 13:15:47 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g91BFQd00637;
	Tue, 1 Oct 2002 13:15:26 +0200
Date: Tue, 1 Oct 2002 13:15:25 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Brian Murphy <brian@murphy.dk>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.4] Re: ide-dma bug (cache flushing)
Message-ID: <20021001131525.A616@linux-mips.org>
References: <3D7FAB4A.4010802@murphy.dk> <3D80F5CF.1040905@murphy.dk> <3D99762D.4E6A7F85@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D99762D.4E6A7F85@mips.com>; from carstenl@mips.com on Tue, Oct 01, 2002 at 12:17:17PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 01, 2002 at 12:17:17PM +0200, Carsten Langgaard wrote:

> Ralf, could you please apply the patch below.
> Please also apply it to include/asm-mips64/pci.h (the 64-bit version).

Looks ok.   The 2.5 version also deserves another thought ...

  Ralf
