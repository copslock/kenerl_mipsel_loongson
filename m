Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IM8Lc13115
	for linux-mips-outgoing; Mon, 18 Feb 2002 14:08:21 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IM8J913112
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 14:08:19 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 0AB651EA6E; Mon, 18 Feb 2002 22:08:05 +0100 (MET)
X-Authentication-Warning: sykes.suse.de: schwab set sender to schwab@suse.de using -f
To: Geoff Keating <geoffk@redhat.com>
Cc: moshier@moshier.net, fxzhang@ict.ac.cn, linux-mips@oss.sgi.com,
   libc-alpha@sources.redhat.com
Subject: Re: math broken on mips
References: <Pine.LNX.4.44.0202181419220.25604-100000@moshier.net>
	<200202182018.g1IKIk802891@desire.geoffk.org>
X-Yow: I have many CHARTS and DIAGRAMS..
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 18 Feb 2002 22:07:59 +0100
In-Reply-To: <200202182018.g1IKIk802891@desire.geoffk.org> (Geoff Keating's
 message of "Mon, 18 Feb 2002 12:18:46 -0800")
Message-ID: <jey9hq8pn4.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geoff Keating <geoffk@geoffk.org> writes:

|> ... actually, C99 seems to imply that all supported rounding
|> precisions should work for the math library

Only if #pragma STDC FENV_ACCESS "on" is in effect.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
