Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GMVpN01960
	for linux-mips-outgoing; Mon, 16 Jul 2001 15:31:51 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GMVmV01957;
	Mon, 16 Jul 2001 15:31:48 -0700
Received: from otr.mynet (fiendish.cygnus.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id PAA01949;
	Mon, 16 Jul 2001 15:31:35 -0700 (PDT)
Received: (from drepper@localhost)
	by otr.mynet (8.11.2/8.11.2) id f6GMRBW23098;
	Mon, 16 Jul 2001 15:27:11 -0700
X-Authentication-Warning: otr.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
References: <20010712182402.A10768@lucon.org>
	<20010713112635.A32010@bacchus.dhis.org> <m3lmlsu82u.fsf@otr.mynet>
	<20010713111010.A25902@lucon.org>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 16 Jul 2001 15:27:11 -0700
In-Reply-To: "H . J . Lu"'s message of "Fri, 13 Jul 2001 11:10:10 -0700"
Message-ID: <m34rsco6gw.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> My last patch was not ok :-(. Somehow, make didn't rebuild. In this
> patch, I rewrote RESOLVE_GOTSYM with RESOLVE to help prelink.

Applied now.  Thanks,

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
