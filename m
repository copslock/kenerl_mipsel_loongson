Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 15:17:51 +0000 (GMT)
Received: from [62.38.114.37] ([62.38.114.37]:35229 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8134416AbWAIPRd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2006 15:17:33 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 7338D1F101;
	Mon,  9 Jan 2006 17:20:08 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Date:	Mon, 9 Jan 2006 17:20:01 +0200
User-Agent: KMail/1.9
Cc:	linux-mips@linux-mips.org, zhuzhenhua <zzh.hust@gmail.com>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <20060109145610.GB4286@linux-mips.org>
In-Reply-To: <20060109145610.GB4286@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091720.03822.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Monday 09 January 2006 4:56 pm, Ralf Baechle wrote:

> You've downloaded a kernel.org kernel it would seem - doesn't fly for MIPS.
> Instead get a kernel from linux-mips.org.
>
> The early_initcall() construct has been removed.
>
>   Ralf

What's the difference between the trees?
Aren't the MIPS patches supposed to be merged to Linus' tree?
