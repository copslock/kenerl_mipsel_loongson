Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g13AVhX13308
	for linux-mips-outgoing; Sun, 3 Feb 2002 02:31:43 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g13AVeA13290
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 02:31:40 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id SAA00195
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 18:34:32 -0800 (PST)
	mail_from (drepper@redhat.com)
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id SAA01398;
	Sat, 2 Feb 2002 18:29:56 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g132TpP17826;
	Sat, 2 Feb 2002 18:29:51 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
References: <20020201094025.A10392@lucon.org>
	<Pine.GSO.3.96.1020201223721.9982A-100000@delta.ds2.pg.gda.pl>
	<20020201144727.A15521@lucon.org>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 02 Feb 2002 18:29:51 -0800
In-Reply-To: <20020201144727.A15521@lucon.org>
Message-ID: <m3heozpaao.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> Like this?
> [...]

>From what I've seen this patch was generally agreed on.  I've checked
it in.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
