Received:  by oss.sgi.com id <S554098AbRAZTr5>;
	Fri, 26 Jan 2001 11:47:57 -0800
Received: from saturn.mikemac.com ([216.99.199.88]:4872 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S553759AbRAZTrr>;
	Fri, 26 Jan 2001 11:47:47 -0800
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id LAA10155;
	Fri, 26 Jan 2001 11:47:45 -0800
Message-Id: <200101261947.LAA10155@saturn.mikemac.com>
To:     Pete Popov <ppopov@mvista.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: Your message of "Fri, 26 Jan 2001 11:39:17 PST."
             <3A71D265.231904BB@mvista.com> 
Date:   Fri, 26 Jan 2001 11:47:45 -0800
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>Date: Fri, 26 Jan 2001 11:39:17 -0800
>From: Pete Popov <ppopov@mvista.com>
>To: Mike McDonald <mikemac@mikemac.com>
>Subject: Re: Cross compiling RPMs
>
>Mike McDonald wrote:

>>   I have a working tool chain that I use to cross compile a kernel
>> with sources from. How do I convince rpm to use that chain?
>
>Is that tool chain setup to compile userland apps? Can you cross compile
>this:

  Not yet. One of the rpms I'd like to be able to compile is one
of the libc variants. :-)

>If so, then you need to modify the .spec file for the given rpm ...

  I was afraid you were going to say that! I was hoping there was some
way to do it without modifying the spec files by hand. Of course,
the Makefiles would also have to modified to support $(ROOT). Hmm,
maybe I need to write a script that'll build a sandbox that I can
chroot to before I do a 'rpm -ba'.

  Mike McDonald
  mikemac@mikemac.com
