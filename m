Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2002 08:25:00 +0200 (CEST)
Received: from p508B5F38.dip.t-dialin.net ([80.139.95.56]:54703 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123907AbSI3GY7>; Mon, 30 Sep 2002 08:24:59 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8U6Oi903070;
	Mon, 30 Sep 2002 08:24:44 +0200
Date: Mon, 30 Sep 2002 08:24:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@ftp.linux-mips.org: linux
Message-ID: <20020930082443.A2046@linux-mips.org>
References: <20020929014920Z1121744-9213+239@linux-mips.org> <20020930.135717.39150888.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020930.135717.39150888.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Mon, Sep 30, 2002 at 01:57:17PM +0900
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 30, 2002 at 01:57:17PM +0900, Atsushi Nemoto wrote:

> It seems some necessary codes for non-r4k CPUs were lost by this change.

Mercyfully sent to /dev/null you wanted to say.

> +	case CPU_SB1:
> +		/*
> +		 * XXX - This should be folded in to the "cleaner" handling,
> +		 * above
> +		 */
> +		memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000, 0x80);
> +		break;

This was a bug. Except_vec3_r4000 is only intended for the R4000/R4400, the
only MIPS CPUs which support the virtual coherency exception.  SB1 should
use except_vec4_generic instead.

> +	case CPU_TX39XX:
> +		memcpy((void *)(KSEG0 + 0x80), &except_vec3_generic, 0x80);

Eeek, will fix.  Consider the switch gone however.

  Ralf
