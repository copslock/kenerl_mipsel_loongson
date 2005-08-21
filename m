Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2005 20:57:02 +0100 (BST)
Received: from ylpvm29-ext.prodigy.net ([IPv6:::ffff:207.115.57.60]:65460 "EHLO
	ylpvm29.prodigy.net") by linux-mips.org with ESMTP
	id <S8225322AbVHUT4p>; Sun, 21 Aug 2005 20:56:45 +0100
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j7LK1o4w019800
	for <linux-mips@linux-mips.org>; Sun, 21 Aug 2005 16:01:51 -0400
X-ORBL:	[63.205.185.3]
Received: from stupidest.org (adsl-63-205-185-3.dsl.snfc21.pacbell.net [63.205.185.3])
	by pimout3-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j7LK1pgi165638;
	Sun, 21 Aug 2005 16:01:52 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 5DE65528F22; Sun, 21 Aug 2005 13:01:51 -0700 (PDT)
Date:	Sun, 21 Aug 2005 13:01:51 -0700
From:	Chris Wedgwood <cw@f00f.org>
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
Cc:	mohanlal jangir <mohanlaljangir@hotmail.com>,
	linux-mips@linux-mips.org
Subject: Re: NPTL info needed
Message-ID: <20050821200151.GA23815@taniwha.stupidest.org>
References: <200508181804.LAA04568@mon-irva-10.broadcom.com> <4304D201.2060306@mvista.com> <BAY18-DAV2A05369EA8C7D91990C16D2B50@phx.gbl> <4308D75D.3090205@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4308D75D.3090205@realitydiluted.com>
Return-Path: <cw@f00f.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw@f00f.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 21, 2005 at 02:34:53PM -0500, Steven J. Hill wrote:

> If you are wanting to work with NPTL and MIPS, please use the latest
> Linux version from the Linux/MIPS cvs tree. The latest releases of
> binutils-2.16.x contain NPTL support for MIPS. You will need to use
> the HEAD of gcc cvs and the HEAD of glibc cvs in order to get the
> MIPS NPTL support. Please note that NO backport of NPTL will be done
> to versions of GCC older than 4.1.0. Have fun.

How stable is GCC is head?  Hostorically thre have been periods of
time when gcc itself wasn't stable or the code it produce wasn't
stable.
