Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2003 18:14:07 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22519 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225371AbTJ2SOE>;
	Wed, 29 Oct 2003 18:14:04 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h9TIE0106288;
	Wed, 29 Oct 2003 10:14:00 -0800
Date: Wed, 29 Oct 2003 10:14:00 -0800
From: Jun Sun <jsun@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com,
	jsun@mvista.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
Message-ID: <20031029101400.J30683@mvista.com>
References: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp> <20031029.163201.39178653.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031029.163201.39178653.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Wed, Oct 29, 2003 at 04:32:01PM +0900
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2003 at 04:32:01PM +0900, Atsushi Nemoto wrote:
> >>>>> On Wed, 22 Oct 2003 17:11:18 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> anemo> I have a problem that my huge dynamically linked program cause
> anemo> SIGSEGV or SIGBUS immediately after running from main() on
> anemo> mips-linux.
> 
> anemo> Digging into this problem, I found that GOT entries are
> anemo> corrupted.
> ...
> anemo> My program is huge enough so that older binutils causes
> anemo> "relocation truncated to fit" error.
> 
> More information.  My program's .got size exceeds 64K.  It seems the
> corruption does not happen if .got size is smaller then 64K.
> 
> $ mips-linux-readelf -e myapp
> ...
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
> ...
>   [21] .got              PROGBITS        100b15d0 a075d0 013a04 04 WAp  0   0 16
> 

Isn't this a known problem in binutils?  IIRC, someone is working or has
added "--big-got" support.

Jun
