Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15JSof30389
	for linux-mips-outgoing; Tue, 5 Feb 2002 11:28:50 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15JSiA30386
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 11:28:44 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA10568;
	Tue, 5 Feb 2002 11:28:36 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA21674;
	Tue, 5 Feb 2002 11:28:36 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g15JSAA29091;
	Tue, 5 Feb 2002 20:28:10 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id UAA21774;
	Tue, 5 Feb 2002 20:28:34 +0100 (MET)
Message-Id: <200202051928.UAA21774@copsun18.mips.com>
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Tue, 5 Feb 2002 20:28:34 +0100 (MET)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020205134113.9674G-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Feb 05, 2002 02:28:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Maciej W. Rozycki writes:
>  How do you maintain coherency on such a system?  To support such a model
> all shared area write accesses should be followed by explicit
> synchronization requests.  It should be trivial but tedious to do for
> Linux, but it might not be that easy for threads.

This would have to be a loosely coupled system - something using either
software coherency or uncached accesses for the shared areas. And then
LL/SC for synchronization primitives.

There are a fair number of SOC designs like this, even with more than
two processors.

/Hartvig
