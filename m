Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1RIvCG12560
	for linux-mips-outgoing; Wed, 27 Feb 2002 10:57:12 -0800
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1RIv8912556
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 10:57:08 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id JAA13001
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 09:56:59 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id JAA15608
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 09:57:00 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g1RHuSA09406
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 18:56:28 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id SAA26112
	for linux-mips@oss.sgi.com; Wed, 27 Feb 2002 18:56:58 +0100 (MET)
Message-Id: <200202271756.SAA26112@copsun18.mips.com>
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
To: linux-mips@oss.sgi.com
Date: Wed, 27 Feb 2002 18:56:58 +0100 (MET)
In-Reply-To: <20020226182231.A25493@dea.linux-mips.net> from "Ralf Baechle" at Feb 26, 2002 06:22:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

On Tue, Feb 26, 2002 at 09:55:30AM -0500, Jay Carlson wrote:
> Right.  In my ideal world, here's how it would work:
> 
> cc1 defaults to -G0.  I think we have that now.
> 
> gas defaults to -G0.  Messing with SUBTARGET_ASM_SPEC has that effect 
> for people who use the gcc driver, but anybody invoking gas directly 
> will still hit this problem, but too bad.
> 
> So I think the primary constituency for gas defaulting to -G8 are 
> existing cygnuhhhh I mean redhat embedded MIPS customers, outside of 
> Linux; that's who we should check with before we change the default.

We cannot change the default for non-Linux MIPS users without causing
massive problems. As far as I know, everybody uses -G8 as the default,
which can include such things as libraries (which may be delivered as
binary only).

So this is probably one of these things where the Linux/MIPS world will
do one thing, and the rest something else.

/Hartvig
