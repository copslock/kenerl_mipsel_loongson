Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64EjrRw007792
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 07:45:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64EjrAk007791
	for linux-mips-outgoing; Thu, 4 Jul 2002 07:45:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from snog.front.onramp.ca (snog.front.onramp.ca [198.163.180.7])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64EjkRw007782
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 07:45:47 -0700
Received: (qmail 30045 invoked from network); 4 Jul 2002 14:49:49 -0000
Received: from gateway.hgeng.com (HELO shadowfax.hgeng.com) (199.246.74.82)
  by 0 with SMTP; 4 Jul 2002 14:49:49 -0000
Received: from dilbert.hgeng.com (dilbert.hgeng.com [192.168.1.6])
	by shadowfax.hgeng.com (8.12.1/8.12.1/Debian -3) with ESMTP id g64EnmgO020933
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 10:49:48 -0400
Subject: Re: X server blanking out virtual consoles?
From: Michael Hill <mikehill@hgeng.com>
To: linux-mips@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 04 Jul 2002 10:49:48 -0400
Message-Id: <1025794188.10696.205.camel@dilbert>
Mime-Version: 1.0
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Guido,

On Tue, 2002-06-11 at 03:55, Guido Guenther wrote: 

> On Tue, Jun 11, 2002 at 09:04:49AM +1000, vik wrote:
> 
> > Just about everything is working on my indy with debian, but when I run
> > X, everything on the virtual consoles disappear. I can see the cursor
> > but that's all. The card is an 8 bit newport.
> 
> Known issue that I really have to debug someday. Until then try the
> patch by Dominik Behr at:
>  http://honk.physik.uni-konstanz.de/linux-mips/x/x.html#bugs

Works brilliantly for me with one small side effect.

Mike
