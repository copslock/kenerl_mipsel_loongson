Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2004 19:07:43 +0100 (BST)
Received: from p508B61D6.dip.t-dialin.net ([IPv6:::ffff:80.139.97.214]:50197
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224917AbUJDSHa>; Mon, 4 Oct 2004 19:07:30 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i94I7RdO021520;
	Mon, 4 Oct 2004 20:07:27 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i94I7QhH021519;
	Mon, 4 Oct 2004 20:07:26 +0200
Date: Mon, 4 Oct 2004 20:07:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Christopher G. Stach II" <cgs@ldsys.net>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Kconfig for R5k/RM7k sc
Message-ID: <20041004180726.GA21448@linux-mips.org>
References: <1096821864.3883.11.camel@sex-machine.chi.ldsys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096821864.3883.11.camel@sex-machine.chi.ldsys.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 03, 2004 at 11:44:24AM -0500, Christopher G. Stach II wrote:

>     This should prevent the rm7k sc code from being built for IP32, etc.

This would prevent the kernel from running on RM7k IP32 and add the
R5000 stuff to loads of machines that don't have it.  No way.

  Ralf
