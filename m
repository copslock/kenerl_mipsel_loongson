Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 23:35:57 +0000 (GMT)
Received: from p508B7A49.dip.t-dialin.net ([IPv6:::ffff:80.139.122.73]:51497
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225299AbUCVXf4>; Mon, 22 Mar 2004 23:35:56 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2MNYioM023694;
	Tue, 23 Mar 2004 00:34:44 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2MNYeC9023693;
	Tue, 23 Mar 2004 00:34:40 +0100
Date: Tue, 23 Mar 2004 00:34:40 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Christopher G. Stach II" <cgs@ldsys.net>
Cc: linux-mips@linux-mips.org
Subject: Re: minor patches
Message-ID: <20040322233440.GA22611@linux-mips.org>
References: <1079996219.15310.60.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079996219.15310.60.camel@localhost>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Leave CONFIG_MAPPED kernel disabled for now; it seems like this option
doesn't deliver the performance benefict it is expected.  The reason it's
implemented is primarily because IRIX does the same kernel code
replication and they actually seem to benefit.

  Ralf
