Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2006 03:58:53 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:58794 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S8133825AbWCCD6p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Mar 2006 03:58:45 +0000
Received: by ozlabs.org (Postfix, from userid 1003)
	id E8B4467A04; Fri,  3 Mar 2006 15:06:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17415.49336.31224.641069@cargo.ozlabs.ibm.com>
Date:	Fri, 3 Mar 2006 15:06:16 +1100
From:	Paul Mackerras <paulus@samba.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	akpm@osdl.org
Subject: Re: jiffies_64 vs. jiffies
In-Reply-To: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
X-Mailer: VM 7.19 under Emacs 21.4.1
Return-Path: <paulus@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulus@samba.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto writes:

> Hi.  I noticed that the 'jiffies' variable has 'wall_jiffies + 1'
> value in most of time.  I'm using MIPS platform but I think this is
> same for other platforms.
> 
> I suppose this is due to gcc does not know that jiffies_64 and jiffies
> share same place.

I can confirm that the same thing happens on powerpc, both 32-bit and
64-bit.  The compiler loads up jiffies, jiffies_64 and wall_jiffies
into registers before storing back the incremented value into
jiffies_64 and then updating wall_jiffies.

Thanks for finding that, it explains some other strange things that I
have seen happen.

Paul.
