Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M7uV426420
	for linux-mips-outgoing; Mon, 21 Jan 2002 23:56:31 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M7uTP26407
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 23:56:29 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id WAA12544;
	Mon, 21 Jan 2002 22:56:18 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0M6uH326612;
	Mon, 21 Jan 2002 22:56:17 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: Machida Hiroyuki <machida@sm.sony.co.jp>
Cc: kevink@mips.com, hjl@lucon.org, libc-hacker@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
References: <20020120221607T.machida@sm.sony.co.jp>
	<20020122152744C.machida@sm.sony.co.jp> <m38zaqsxgx.fsf@myware.mynet>
	<20020122154629F.machida@sm.sony.co.jp>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 21 Jan 2002 22:56:17 -0800
In-Reply-To: <20020122154629F.machida@sm.sony.co.jp>
Message-ID: <m34rleswku.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Machida Hiroyuki <machida@sm.sony.co.jp> writes:

> Please let us why. Acctually, glibc includes codes copyrighted by
> SUN and gcc includes codes copryrighed by HP and SGI.

It contains public domain code and the rest of the code is assigned.
If there is a header saying that somebody from a company wrote the
code this is mentioned but the person also has a document signed.

If you cannot live with this the code cannot be accepted.  Any further
discussion you have to have with the legal people at the FSF.  I've no
time for this.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
