Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16LHdS32171
	for linux-mips-outgoing; Wed, 6 Feb 2002 13:17:39 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16LHZA32163
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 13:17:35 -0800
Received: from localhost.localdomain (taarna.sfbay.redhat.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA18750;
	Wed, 6 Feb 2002 13:17:26 -0800 (PST)
Subject: Re: PATCH: Modify the mips gas behavior for -g -O
From: Eric Christopher <echristo@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, binutils@sources.redhat.com
In-Reply-To: <20020206130037.A29208@lucon.org>
References: <yov5ofj65elj.fsf@broadcom.com>
	<15454.22661.855423.532827@gladsmuir.algor.co.uk>
	<20020204083115.C13384@lucon.org>
	<15454.47823.837119.847975@gladsmuir.algor.co.uk>
	<20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org>
	<20020205113017.A6144@lucon.org> <20020205135407.A8309@lucon.org>
	<20020206113259.A15431@dea.linux-mips.net>
	<20020206124538.A28632@lucon.org>  <20020206130037.A29208@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Feb 2002 13:16:47 -0800
Message-Id: <1013030208.19162.6.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Here is a patch which does what I want. Any comments?
> 

Does anyone care if we have MIPS compatibility? I remember seeing this a
few years ago and wondering why we were doing it this way. I remember at
one time debuggers had problems with optimized code, but gdb has come a
long way since then. Is there any reason to have this code in there at
all now, i.e. should we just go off of optimization level and not debug
level at all?

> Eric, can you approve
> 
> http://sources.redhat.com/ml/binutils/2002-02/msg00028.html
> 

If this is the one for header file information, then go ahead. We need
to come up with a better way of doing this though.

-eric

-- 
I will not use abbrev.
