Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2003 12:24:59 +0000 (GMT)
Received: from p508B634D.dip.t-dialin.net ([IPv6:::ffff:80.139.99.77]:10649
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225198AbTAOMY6>; Wed, 15 Jan 2003 12:24:58 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0FCOlD27772;
	Wed, 15 Jan 2003 13:24:47 +0100
Date: Wed, 15 Jan 2003 13:24:47 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Gilad Benjamini <gilad@riverhead.com>, linux-mips@linux-mips.org
Subject: Re: insmod failure: "Unhandled relocation" errors
Message-ID: <20030115132447.B27412@linux-mips.org>
References: <001801c2bbb4$a6177de0$7100000a@riverhead.com> <9030.1042587273@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9030.1042587273@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, Jan 15, 2003 at 10:34:33AM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 15, 2003 at 10:34:33AM +1100, Keith Owens wrote:

> modutils needs obj/obj_mips64.c.  The config and makefiles have to be
> tweaked to handle mips64, including combined 32/64 bit code, as for
> sparc32/sparc64.  Does anybody who knows mips64 feel like contributing
> the modutils code?

Until recently the big problem with implementing modules support for mips64
was the complete unusability of binutils.  Compared to the complexity of
getting binutils to work what it takes to get modutils to work is plain
trivial ...

  Ralf
