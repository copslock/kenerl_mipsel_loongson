Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49EFAc28716
	for linux-mips-outgoing; Wed, 9 May 2001 07:15:10 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49EF8F28713
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 07:15:08 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id F04A01E275; Wed,  9 May 2001 16:15:07 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To: sjhill@cotw.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <20010505144708.A12575@paradigm.rfc822.org>
	<20010507163210.B2381@bacchus.dhis.org>
	<20010508202518.A13476@paradigm.rfc822.org>
	<20010508214313.A12528@bacchus.dhis.org>
	<20010509095955.A8392@sonycom.com>
	<20010509104635.D12267@paradigm.rfc822.org>
	<3AF934AE.38AB0089@cotw.com> <hoeltyemh0.fsf@gee.suse.de>
	<3AF93D3F.5E57070@cotw.com> <hopudid73g.fsf@gee.suse.de>
	<3AF94D3C.98A4E8@cotw.com> <hor8xybpjc.fsf@gee.suse.de>
	<3AF94EFE.88B7B1BD@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: 09 May 2001 16:15:06 +0200
In-Reply-To: <3AF94EFE.88B7B1BD@cotw.com> ("Steven J. Hill"'s message of "Wed, 09 May 2001 09:06:54 -0500")
Message-ID: <ho8zk6bod1.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Andreas Jaeger wrote:
> > 
> > So the one-liner you mailed should be all that has to be added?
> > 
> Yes and....
> 
> > > For the correct ld emulation, I assume you mean make changes in glibc
> > > to check for the proper target 'elf[32|64]trad[little|big]mips'?
> > 
> > That's what I mean,
> > 
> And these changes. If you want to commit the one-liner fine...but I will
> need some time today to make the fix to glibc to check for the proper
> emulation target. You can either wait and I can include the one-liner
> with the emulation check patch or commit it.

I prefer to wait,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
