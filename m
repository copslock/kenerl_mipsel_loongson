Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 06:48:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:38897 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBMGsn>;
	Thu, 13 Feb 2003 06:48:43 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1D6mb116081;
	Wed, 12 Feb 2003 22:48:37 -0800
Date: Wed, 12 Feb 2003 22:48:37 -0800
From: Jun Sun <jsun@mvista.com>
To: Steven Seeger <sseeger@stellartec.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: NEC VR4181A
Message-ID: <20030212224837.D16015@mvista.com>
References: <200302121823.09663.jscheel@activevb.de> <027601c2d2bc$8234acd0$3501a8c0@wssseeger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <027601c2d2bc$8234acd0$3501a8c0@wssseeger>; from sseeger@stellartec.com on Wed, Feb 12, 2003 at 09:30:58AM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 12, 2003 at 09:30:58AM -0800, Steven Seeger wrote:
> Julian,
> 
> We are doing a project here at work with that board. Are you using the NEC
> Osprey? 

Osprey uses Vr4181, which is a different chip from vr4181a.

> I'm happy with this processor although it is a bit slow. 

Yes, indeed.  Pretty the slowest MIPS CPU I ever have dealt.

> I managed to get
> worst case interrupt latency at 46 microseconds with linux going full blast
> on network and compact flash stuff with our external board. (using RTAI and
> kernel 2.4.18)

Interesting.  I was trying to get RT-Linux working at one time
but aborted that effort in the middle.

Jun
