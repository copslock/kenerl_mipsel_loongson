Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Dec 2003 16:08:13 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:7079
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225269AbTL3QIL>; Tue, 30 Dec 2003 16:08:11 +0000
Received: (qmail 22131 invoked from network); 30 Dec 2003 16:08:08 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with DES-CBC3-SHA encrypted SMTP; 30 Dec 2003 16:08:08 -0000
Received: (qmail 7473 invoked by uid 502); 30 Dec 2003 08:08:08 -0800
Date: Tue, 30 Dec 2003 08:08:08 -0800
From: ilya@theIlya.com
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: supported systems running on 2.6 ?
Message-ID: <20031230160807.GB30019@gateway.total-knowledge.com>
References: <20031230144904.GA10358@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230144904.GA10358@sonycom.com>
User-Agent: Mutt/1.5.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

Are you trying 2.6.0 from linux-mips.org CVS?
If so, make sure it is no earlier then from yesterday. There was
non-CPU specific bug that was just fixed.

For reference: I have R212K-based SGI O2 running almost stable with
2.6.0. R5K O2's also boot, but show random segfaults and oopses, but
I still do not know what exactly is the reason for that.

	Ilya.

On Tue, Dec 30, 2003 at 03:49:04PM +0100, Dimitri Torfs wrote:
> Hi,
> 
>   are there already MIPS systems running on 2.6.0 ? If so, which ones
>   ? I'm currently porting a VR41xx based configuration from 2.4.24 to
>   2.6.0: boot sequence seems to be OK, but the init process doesn't
>   come up (it looks like its not properly laid out in memory, thus
>   continuously generating exceptions (do_signal()) ...). Is it too
>   soon to expect it to work ?
> 
>   Dimitri
> 
> -- 
> Dimitri Torfs             |  NSCE 
> dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
> tel: +32 2 2908451        |  1130 Brussel
> fax: +32 2 7262686        |  Belgium
> 
> 
