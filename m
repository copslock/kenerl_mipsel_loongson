Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2004 12:50:46 +0000 (GMT)
Received: from p508B6814.dip.t-dialin.net ([IPv6:::ffff:80.139.104.20]:31778
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225534AbUCBMuo>; Tue, 2 Mar 2004 12:50:44 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i22Coaex013622;
	Tue, 2 Mar 2004 13:50:36 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i22CoYwW013621;
	Tue, 2 Mar 2004 13:50:34 +0100
Date: Tue, 2 Mar 2004 13:50:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.6] Fixed ISA configuration
Message-ID: <20040302125034.GA13504@linux-mips.org>
References: <20040302195028.3addcdf7.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302195028.3addcdf7.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 02, 2004 at 07:50:28PM +0900, Yoichi Yuasa wrote:

> This patch solves the problem which cannot choose ISA support about CASIO E55, IBM WorkPad, and others.
> Please apply this patch to v2.6.

I've choosen to fix this a different way.  I don't think it's a good idea
to require users to know if they need to enable CONFIG_ISA or not because
the question isn't equivalent to having ISA slots or not, so there's
potencial for missconfiguration.  So my alternative patch which I checked
now uses reverse dependencies to eleminate the long depends line of the
config ISA block and only enable ISA where really necessary.

  Ralf
