Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5J8bUc12989
	for linux-mips-outgoing; Tue, 19 Jun 2001 01:37:30 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5J8bTV12986
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 01:37:29 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id A65281E4ED; Tue, 19 Jun 2001 10:37:23 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: Greg Satz <satz@ayrnetworks.com>
Cc: Brian Murphy <brian@murphy.dk>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Profiling support in glibc?
References: <B753C92D.5ABA%satz@ayrnetworks.com>
From: Andreas Jaeger <aj@suse.de>
Date: 19 Jun 2001 10:37:16 +0200
In-Reply-To: <B753C92D.5ABA%satz@ayrnetworks.com> (Greg Satz's message of "Mon, 18 Jun 2001 15:05:18 -0600")
Message-ID: <ho3d8weugz.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greg Satz <satz@ayrnetworks.com> writes:

> I was able to get profiling working using glibc-2.2.2 and gcc-2.95.3. Both
> packages needed changes. The compiler had a stack misalignment correction
> for glibc. Glibc didn't save all the registers nor treat sp/fp correctly.
> Currently files compiled with -pg need to be linked -static. Specs need to
> be updated to do this automatically.
> 
> I will send diffs if there is any interest.

Please send me diffs for glibc,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
