Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1880Iw21187
	for linux-mips-outgoing; Fri, 8 Feb 2002 00:00:18 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1880DA21183
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 00:00:14 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 581011E24B; Fri,  8 Feb 2002 09:00:07 +0100 (MET)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Not use branch likely on mips
References: <20020205180243.A11993@lucon.org> <hoadulk25q.fsf@gee.suse.de>
	<20020207091327.B15331@lucon.org>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 08 Feb 2002 09:00:02 +0100
In-Reply-To: <20020207091327.B15331@lucon.org> ("H . J . Lu"'s message of
 "Thu, 7 Feb 2002 09:13:27 -0800")
Message-ID: <hou1sswghp.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> On Thu, Feb 07, 2002 at 11:38:09AM +0100, Andreas Jaeger wrote:
>> "H . J . Lu" <hjl@lucon.org> writes:
>> 
>> > This patch removes branch likely.
>> 
>> Please update the copyright years next time.
>> 
>> I've committed the patch,
>> 
>
> Here is a new patch. I have checked in a gcc patch which makes
> ".set noreorder" unnecessary even with "gcc -g".

But what about current GCC releases?  Does it work there also without
problems?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
