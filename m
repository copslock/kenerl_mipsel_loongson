Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IMWBA12189
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:32:11 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IMW8P12186
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:32:09 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA03905;
	Fri, 18 Jan 2002 13:32:01 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0ILVxE13939;
	Fri, 18 Jan 2002 13:31:59 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: Justin Carlson <justincarlson@cmu.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <1011389085.7765.69.camel@gs256.sp.cs.cmu.edu>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Jan 2002 13:31:59 -0800
In-Reply-To: <1011389085.7765.69.camel@gs256.sp.cs.cmu.edu>
Message-ID: <m34rlj2vn4.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Justin Carlson <justincarlson@cmu.edu> writes:

> _Why_ do we need a general register which is read-only to userland?  Are
> you trying to store thread-context information in a fast way?  Why does
> this need to happen?

Read-only is no requirement.  It is possible to live with this
arrangement is all I said.  If it's a normal register, fine, this is
how it works on most platforms.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
