Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2003 02:42:06 +0000 (GMT)
Received: from p508B5C7D.dip.t-dialin.net ([IPv6:::ffff:80.139.92.125]:62339
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225425AbTKVClz>; Sat, 22 Nov 2003 02:41:55 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAM2fiA0005458;
	Sat, 22 Nov 2003 03:41:44 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAM2fhks005457;
	Sat, 22 Nov 2003 03:41:43 +0100
Date: Sat, 22 Nov 2003 03:41:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Colin.Helliwell@Zarlink.Com
Cc: linux-mips@linux-mips.org
Subject: Re: Compressed kernels
Message-ID: <20031122024143.GA25296@linux-mips.org>
References: <OF86946D75.0D269E58-ON80256DE4.0031F58D@zarlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF86946D75.0D269E58-ON80256DE4.0031F58D@zarlink.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 20, 2003 at 09:10:41AM +0000, Colin.Helliwell@Zarlink.Com wrote:

> I'm running a 2.4.21 kernel tree, and would like to have kernel
> compression. I wondered if this has gone back into the latest versions yet?
> Or is the old EV64120 code worth adapting to my needs?

The old code apparently was functioning but replicating code from zlib and
generally was carrying half a firmware as it's baggage.

  Ralf
