Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5NG7bd31511
	for linux-mips-outgoing; Sat, 23 Jun 2001 09:07:37 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5NG7aV31508
	for <linux-mips@oss.sgi.com>; Sat, 23 Jun 2001 09:07:36 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5NG7U020937;
	Sat, 23 Jun 2001 09:07:30 -0700
Message-ID: <3B34BE3B.B72D40F1@mvista.com>
Date: Sat, 23 Jun 2001 09:05:15 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: CONFIG_MIPS_UNCACHED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I looked at the code and it appears this config may not work properly.

My understanding is that if CPU has been running with cache enabled, and,
presummably, have many dirty cache entries, and if you suddenly change config
register to run kernel uncached, you *don't* get all the dirty cache lines
flushed into memory.  Therefore, you will be accessing stale data in memory.

Is this right?  If so, we need a better way to run CPU uncached.

In the past, I have been a private patch to do so.  It seems pretty difficult
to come up a generic, because we want to figure out the CPU type and disable
cache *before* kernel starts to modify any memory content.

BTW, this comes to me as I observe some weired behavior when I try to run
uncached.

Jun
