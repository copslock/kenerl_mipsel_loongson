Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16LlXC00558
	for linux-mips-outgoing; Wed, 6 Feb 2002 13:47:33 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16LlUA00555
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 13:47:31 -0800
Received: from localhost.localdomain (taarna.sfbay.redhat.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA22008;
	Wed, 6 Feb 2002 13:47:23 -0800 (PST)
Subject: Re: PATCH: Modify the mips gas behavior for -g -O
From: Eric Christopher <echristo@redhat.com>
To: Ian Lance Taylor <ian@airs.com>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
In-Reply-To: <si665ap9vf.fsf@daffy.airs.com>
References: <yov5ofj65elj.fsf@broadcom.com>
	<15454.22661.855423.532827@gladsmuir.algor.co.uk>
	<20020204083115.C13384@lucon.org>
	<15454.47823.837119.847975@gladsmuir.algor.co.uk>
	<20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org>
	<20020205113017.A6144@lucon.org> <20020205135407.A8309@lucon.org>
	<20020206113259.A15431@dea.linux-mips.net>
	<20020206124538.A28632@lucon.org> <20020206130037.A29208@lucon.org>
	<1013030208.19162.6.camel@ghostwheel.cygnus.com> 
	<si665ap9vf.fsf@daffy.airs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Feb 2002 13:46:45 -0800
Message-Id: <1013032006.19159.13.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> In general the reason for this sort of compatibility is for easier gcc
> support.  It's normally more convenient if the GNU assembler and the
> native assembler present the same interface, so that you don't have to
> use --with-gnu-assembler to get the right result when configuring gcc.
> 

Ok. That's fair enough. I was hoping you'd pipe up here. :)

-eric

-- 
I will not use abbrev.
