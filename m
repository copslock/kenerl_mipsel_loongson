Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GMYpo12418
	for linux-mips-outgoing; Thu, 16 Aug 2001 15:34:51 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GMYoj12415
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 15:34:50 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7GMdMA30471;
	Thu, 16 Aug 2001 15:39:28 -0700
Message-ID: <3B7C4B6D.5080409@pacbell.net>
Date: Thu, 16 Aug 2001 15:38:37 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Jun Sun <jsun@mvista.com>, Daniel Jacobowitz <dan@debian.org>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
References: <018201c12680$8f13e680$0deca8c0@Ulysses> <20010816115349.A12153@nevyn.them.org> <3B7C1BB9.7011790E@mvista.com> <01b001c12693$b4920140$0deca8c0@Ulysses> <3B7C3C75.4AB05B13@mvista.com> <01c701c126a3$7c5bcbc0$0deca8c0@Ulysses>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

<cut>

> Strange indeed.  And note that if the code were correct, your
> surmise about the init_fpu() path being "logically the correct"
> one would no longer be true - we'd be saving the FPU state of
> the current process for no good reason.
> 
> The more I look at the FPU management code, the more I marvel
> that it even gives an appearance of working...

Maybe no one has stress tested it enough up till now. As soon as we
put he mips boards in QA we found a few fpu problems immediately.  I hope
those were it and we weren't just scratching the surface.

Pete
