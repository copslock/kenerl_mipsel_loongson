Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11BpZg30136
	for linux-mips-outgoing; Fri, 1 Feb 2002 03:51:35 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11BpSd30131
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 03:51:29 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 2BD051EE67; Fri,  1 Feb 2002 11:49:43 +0100 (MET)
X-Authentication-Warning: sykes.suse.de: schwab set sender to schwab@suse.de using -f
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: kaz@ashi.footprints.net, hjl@lucon.org, macro@ds2.pg.gda.pl,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
References: <20020201.123523.50041631.machida@sm.sony.co.jp>
	<Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>
	<20020201.135903.123568420.machida@sm.sony.co.jp>
X-Yow: ..  I think I'd better go back to my DESK and toy with
 a few common MISAPPREHENSIONS...
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 01 Feb 2002 11:49:22 +0100
In-Reply-To: <20020201.135903.123568420.machida@sm.sony.co.jp> (Hiroyuki
 Machida's message of "Fri, 01 Feb 2002 13:59:03 +0900 (JST)")
Message-ID: <jebsf9bhot.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hiroyuki Machida <machida@sm.sony.co.jp> writes:

|> From: Kaz Kylheku <kaz@ashi.footprints.net>
|> Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
|> Date: Thu, 31 Jan 2002 20:02:25 -0800 (PST)
|> 
|> > On Fri, 1 Feb 2002, Hiroyuki Machida wrote:
|> > > Please note that "sc" may fail even if nobody write the
|> > > variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
|> > > MIPS RUN" for more detail.) 
|> > > So, after your patch applied, compare_and_swap() may fail, even if
|> > > *p is equal to oldval.
|> > 
|> > I can't think of anything that will break because of this, as long
|> > as the compare_and_swap eventually succeeds on some subsequent trial.
|> > If the atomic operation has to abort for some reason other than *p being
|> > unequal to oldval, that should be cool.
|> 
|> I mean that this patch breaks the spec of compare_and_swap().
|> 
|> In most case, this patch may works as Kaz said. If this patch have
|> no side-effect to any application, it's ok to apply the patch. But
|> we can't know how to use compare_and_swap() in all aplications in a
|> whole world. So we have to follow the spec.  

There is no way to find out anything about intermediate values of *p when
compare_and_swap returns zero.  The value of *p can change anytime, even
if it only was different from oldval just at the time compare_and_swap did
the comparison.  So there is zero chance that a spurious failure of
compare_and_swap breaks anything.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
