Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 00:41:51 +0100 (BST)
Received: from p508B7223.dip.t-dialin.net ([IPv6:::ffff:80.139.114.35]:14868
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225479AbUC3Xlv>; Wed, 31 Mar 2004 00:41:51 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2UNfooM007880;
	Wed, 31 Mar 2004 01:41:50 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2UNfnFD007879;
	Wed, 31 Mar 2004 01:41:49 +0200
Date: Wed, 31 Mar 2004 01:41:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Lijun Chen <chenli@nortelnetworks.com>
Cc: linux-mips@linux-mips.org
Subject: Re: exception priority for BCM1250
Message-ID: <20040330234149.GA7543@linux-mips.org>
References: <4069F90D.9060903@americasm01.nt.com> <406A04DA.8070604@americasm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406A04DA.8070604@americasm01.nt.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 30, 2004 at 06:38:02PM -0500, Lijun Chen wrote:

> Further to my last email, another question is if multiple simultaneous 
> exceptions occur, or kernel is
> handling an exception, another exception occurs, how linux handles this?

Not at all.  Exceptions have priorities and so simply the highest
priority will be taken and therefore handled.

  Ralf
