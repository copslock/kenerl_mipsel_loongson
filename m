Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2003 12:58:04 +0000 (GMT)
Received: from p508B634D.dip.t-dialin.net ([IPv6:::ffff:80.139.99.77]:40601
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225198AbTAOM6E>; Wed, 15 Jan 2003 12:58:04 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0FCm8728283;
	Wed, 15 Jan 2003 13:48:08 +0100
Date: Wed, 15 Jan 2003 13:48:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] INTERNAL_SYSCALL for linux-mips
Message-ID: <20030115134808.C27412@linux-mips.org>
References: <20030114230607.GH27645@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114230607.GH27645@bogon.ms20.nix>; from agx@sigxcpu.org on Wed, Jan 15, 2003 at 12:06:08AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 15, 2003 at 12:06:08AM +0100, Guido Guenther wrote:

> +	register long __v0 asm("$2"); 					\
> +	register long __a3 asm("$7"); 					\

The patch looks fine to me but as a word of warning - I'm using the same
code construct is also being used in the kernel but I've found it very
fragile wrt. misscompilation by gcc over the years ...

  Ralf
