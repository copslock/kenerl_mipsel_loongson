Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49Ha1a02084
	for linux-mips-outgoing; Wed, 9 May 2001 10:36:01 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49Ha1F02081
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 10:36:01 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f49HZx030950;
	Wed, 9 May 2001 10:35:59 -0700
Message-ID: <3AF97F6F.1A8A50E4@mvista.com>
Date: Wed, 09 May 2001 10:33:35 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Tim Nguyen <tnguyen@drawbridge3.simpletech.com>
CC: linux-mips@oss.sgi.com
Subject: Re: MIPS 5Kc
References: <4.3.2.7.2.20010509095019.00a90830@sti-sun4>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Tim Nguyen wrote:
> 
> Hello all,
> 
> Does anybody have any comments concerning the Alta board with a MIPS 5Kc
> running Linux.  I hear that Linux modules aren't fully supported in their
> reference 2.2.12 kernel.  Are there any other known issues with that kernel
> -- how about the 2.4.1 kernel?  Any help will be greatly appreciated.

You are probably referring to the "Malta" board from MIPS Tech.  The
2.4.2 kernel runs on that board so I would suggest using that.  We've
tested and support the Malta board with a 4kc part, but running it with
a 5kc part shouldn't be much of an issue.

Pete
