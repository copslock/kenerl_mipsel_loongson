Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMJda327814
	for linux-mips-outgoing; Thu, 22 Nov 2001 11:39:36 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMJdXo27805
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 11:39:33 -0800
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id BD149125C3; Thu, 22 Nov 2001 10:39:31 -0800 (PST)
Received: by lucon.org (Postfix, from userid 1000)
	id 29F54EBC9; Thu, 22 Nov 2001 10:39:31 -0800 (PST)
Date: Thu, 22 Nov 2001 10:39:30 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU test on RedHat7.1
Message-ID: <20011122103930.A2007@lucon.org>
References: <3BFD1BA7.C4490465@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFD1BA7.C4490465@mips.com>; from carstenl@mips.com on Thu, Nov 22, 2001 at 04:37:11PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 22, 2001 at 04:37:11PM +0100, Carsten Langgaard wrote:
> The attached tests fails on my RedHat7.1 system, but works fine on my
> old HardHat5.1.
> Anyone got any idea.
> 
> compile:
> g++ -o fpu_test fpu_test.cc
> 

Many FPU related tests in the current glibc from CVS failed on MIPS. I
am planning to look into them. But I need to find time and docs on MIPS
FPU.


H.J.
