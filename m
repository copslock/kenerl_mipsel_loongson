Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2003 17:40:40 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44029 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225204AbTCFRkj>;
	Thu, 6 Mar 2003 17:40:39 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h26HeYL26116;
	Thu, 6 Mar 2003 09:40:34 -0800
Date: Thu, 6 Mar 2003 09:40:34 -0800
From: Jun Sun <jsun@mvista.com>
To: Tinga Shilo <tingashilo@yahoo.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: static variables access and gp
Message-ID: <20030306094034.A26071@mvista.com>
References: <20030306073017.65521.qmail@web41509.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030306073017.65521.qmail@web41509.mail.yahoo.com>; from tingashilo@yahoo.com on Wed, Mar 05, 2003 at 11:30:17PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 05, 2003 at 11:30:17PM -0800, Tinga Shilo wrote:
> Hi,
> I am implementing a kernel mechanism which is 
> very performance oriented. Along my long critical
> path,
> there is a static variable that needs to be accessed
> quite a few times. This variable is a structure which
> is approximately 60 bytes big.
> In there any way I can "convince" my kernel (compiled
> with gcc) to access this variable using gp ?
> Is gp usually used for this purpose in mips-linux ?
> Can it be ?
>

No.  gp is used by kernel to hold current process in 2.4
and current thread in 2.5.  Don't mess with it unless
you are absolutely sure what you are doing.

Jun
