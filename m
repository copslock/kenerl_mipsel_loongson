Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LM8BX15734
	for linux-mips-outgoing; Mon, 21 Jan 2002 14:08:11 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LM87P15728
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 14:08:07 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id NAA03560;
	Mon, 21 Jan 2002 13:07:14 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0LL7DI24457;
	Mon, 21 Jan 2002 13:07:13 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses>
	<Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl>
	<20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet>
	<20020121105253.B28087@lucon.org>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 21 Jan 2002 13:07:13 -0800
In-Reply-To: <20020121105253.B28087@lucon.org>
Message-ID: <m3lmertnum.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> Thq question is if we should reserve $23 outside of glibc. $23 is
> a saved register in the MIPS ABI. It doesn't change across function
> calls. If applications outside of glibc don't need to access the
> thread register directly, that means $23 can be used as a saved
> register.

It depends on the final decisions os the thrad ABI but it is best to
assume that compiler-generated code will access the register.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
