Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 23:00:03 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:13557 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224847AbSLDWAD>;
	Wed, 4 Dec 2002 23:00:03 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gB4Lxol29483;
	Wed, 4 Dec 2002 13:59:50 -0800
Date: Wed, 4 Dec 2002 13:59:50 -0800
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: possible Malta 4Kc cache problem ...
Message-ID: <20021204135950.T4363@mvista.com>
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <007501c29b78$f34680e0$10eca8c0@grendel>; from kevink@mips.com on Wed, Dec 04, 2002 at 10:38:36AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 10:38:36AM +0100, Kevin D. Kissell wrote:
> 
> Which version of the 4Kc manual are you looking at?  I'm looking
> at a very recent version of the 4Kc Software User's Manual
> (version 1.17, dated September 25, 2002), and it only shows
> Hit_Writeback_D to be invalid for *secondary and teritary*
> caches, which makes sense, since the 4KSc doesn't have any.
>

I was looking at rev 1.12, Jan 3, 2001.

Good to know that 4K family does have Hit_WRiteback_D.  However,
since it is "recommanded" instead of "required".  Shouldn't we
still use "Hit_Writeback_Inv_D" just to be on the safe side?

Jun
