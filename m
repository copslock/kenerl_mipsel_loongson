Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5E5p1a30205
	for linux-mips-outgoing; Wed, 13 Jun 2001 22:51:01 -0700
Received: from foghorn.airs.com (IDENT:qmailr@foghorn.airs.com [63.201.54.26])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5E5oxP30202
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 22:50:59 -0700
Received: (qmail 32101 invoked by uid 10); 14 Jun 2001 05:50:59 -0000
Received: (qmail 27150 invoked by uid 269); 14 Jun 2001 05:50:54 -0000
Mail-Followup-To: gcc@gcc.gnu.org,
  binutils@sourceware.cygnus.com,
  linux-mips@oss.sgi.com,
  hjl@lucon.org
From: Ian Lance Taylor <ian@zembu.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
References: <20010613212940.A22683@lucon.org>
Date: 13 Jun 2001 22:50:54 -0700
In-Reply-To: <20010613212940.A22683@lucon.org>
Message-ID: <sir8wnvcch.fsf@daffy.airs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> In the MIPS gas, there is
> 
>     case M_JAL_A:

Not the relevant bit of code, not that it matters much.  The
instruction
      jal     $31,$25
will be handled by the M_JAL_1 case in gas/config/tc-mips.c.

> Does anyone have any suggestions how to fix it?

Traditional MIPS assemblers try to make life easier by doing this sort
of translation.  Modern MIPS compilers sidestep the translation
because they can do better.  In this case gcc evidently needs to do
better in order to makes it exception handling model work.  gcc should
generate a jalr instruction, and should restore the GP register
itself.

(I suppose that it would be theoretically possible for gas to
recognize labels of the special form $LEHEn.  But that seems quite
dreadful and quite fragile.)

Ian
