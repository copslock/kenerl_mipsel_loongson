Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5E5rmN30692
	for linux-mips-outgoing; Wed, 13 Jun 2001 22:53:48 -0700
Received: from foghorn.airs.com (IDENT:qmailr@foghorn.airs.com [63.201.54.26])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5E5rlP30689
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 22:53:47 -0700
Received: (qmail 32124 invoked by uid 10); 14 Jun 2001 05:53:47 -0000
Received: (qmail 27191 invoked by uid 269); 14 Jun 2001 05:53:42 -0000
Mail-Followup-To: gcc@gcc.gnu.org,
  binutils@sourceware.cygnus.com,
  linux-mips@oss.sgi.com,
  hjl@lucon.org
From: Ian Lance Taylor <ian@zembu.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
References: <20010613212940.A22683@lucon.org> <sir8wnvcch.fsf@daffy.airs.com>
Date: 13 Jun 2001 22:53:42 -0700
In-Reply-To: <sir8wnvcch.fsf@daffy.airs.com>
Message-ID: <sin17bvc7t.fsf@daffy.airs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ian Lance Taylor <ian@zembu.com> writes:

> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > In the MIPS gas, there is
> > 
> >     case M_JAL_A:
> 
> Not the relevant bit of code, not that it matters much.  The
> instruction
>       jal     $31,$25
> will be handled by the M_JAL_1 case in gas/config/tc-mips.c.

Sorry, M_JAL_2.

Ian
