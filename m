Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M0V4b19013
	for linux-mips-outgoing; Mon, 21 Jan 2002 16:31:04 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M0UxP19010;
	Mon, 21 Jan 2002 16:30:59 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id PAA04615; Mon, 21 Jan 2002 15:29:44 -0800 (PST)
	mail_from (drepper@redhat.com)
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id PAA16882;
	Mon, 21 Jan 2002 15:22:31 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0LNMUQ24648;
	Mon, 21 Jan 2002 15:22:30 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, "H . J . Lu" <hjl@lucon.org>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020119162415.B31028@dea.linux-mips.net>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 21 Jan 2002 15:22:29 -0800
In-Reply-To: <20020119162415.B31028@dea.linux-mips.net>
Message-ID: <m3d703thl6.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle <ralf@oss.sgi.com> writes:

> Changing the kernel for the small number of threaded applications that
> exists and taking a performance impact for the kernel itself and anything
> that's using threads is an exquisite example for a bad tradeoff.

Well, it seems you haven't read what I wrote.  It's not about a small
number of threaded applications anymore.  The thread register will be
part of the ABI and all applications, threaded or not, will use it.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
