Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DIGb523714
	for linux-mips-outgoing; Fri, 13 Jul 2001 11:16:37 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DIGXV23711;
	Fri, 13 Jul 2001 11:16:33 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f6DIGHT05463;
	Fri, 13 Jul 2001 20:16:17 +0200
Received: from gromit.moeb ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.30 #1)
	id 15L7Lp-0006r1-00; Fri, 13 Jul 2001 20:07:41 +0200
Received: by gromit.moeb (Postfix, from userid 207)
	id 1D2FF1EA2A; Fri, 13 Jul 2001 20:07:40 +0200 (CEST)
Mail-Copies-To: never
To: drepper@cygnus.com (Ulrich Drepper)
Cc: Ralf Baechle <ralf@oss.sgi.com>, "H . J . Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
References: <20010712182402.A10768@lucon.org>
	<20010713112635.A32010@bacchus.dhis.org> <m3lmlsu82u.fsf@otr.mynet>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 13 Jul 2001 20:07:40 +0200
In-Reply-To: <m3lmlsu82u.fsf@otr.mynet> (Ulrich Drepper's message of "13 Jul
 2001 09:06:49 -0700")
Message-ID: <u8u20gem8j.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ulrich Drepper <drepper@redhat.com> writes:

> Ralf Baechle <ralf@oss.sgi.com> writes:
> 
>> So please, go ahead.
> 
> So you say the patch is OK from your POV?

Just for the record, I also think it's ok - but will not apply it
since it depends on patches for generic code.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
