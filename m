Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 22:07:38 +0000 (GMT)
Received: from p508B6BBF.dip.t-dialin.net ([IPv6:::ffff:80.139.107.191]:36120
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbUKBWHe>; Tue, 2 Nov 2004 22:07:34 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id iA2N7Xir031291;
	Wed, 3 Nov 2004 00:07:33 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id iA2N7X2k031290;
	Wed, 3 Nov 2004 00:07:33 +0100
Date: Wed, 3 Nov 2004 00:07:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Manish Lachwani <mlachwani@prometheus.mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Support for PMC-Sierra Ocelot-3 in 2.6
Message-ID: <20041102230733.GC28025@linux-mips.org>
References: <20041102201720.GB24674@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102201720.GB24674@prometheus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 02, 2004 at 12:17:20PM -0800, Manish Lachwani wrote:

> +#ifdef CONFIG_MIPS64
> +		0xfffffffffc807000;
> +#else
> +		0xfc807000;
> +#endif

Ouch.  Rather ugly.  I suggest you rely on the implicit sign extension
of the compiler instead.

  Ralf
