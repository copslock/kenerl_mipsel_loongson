Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EHJsc06341
	for linux-mips-outgoing; Thu, 14 Jun 2001 10:19:54 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EHJrP06338
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 10:19:53 -0700
Received: from dot.cygnus.com (dot.cygnus.com [205.180.230.224])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id KAA23416;
	Thu, 14 Jun 2001 10:19:52 -0700 (PDT)
Received: (from rth@localhost)
	by dot.cygnus.com (8.11.0/8.11.0) id f5EHJqs28846;
	Thu, 14 Jun 2001 10:19:52 -0700
X-Authentication-Warning: dot.cygnus.com: rth set sender to rth@redhat.com using -f
Date: Thu, 14 Jun 2001 10:19:51 -0700
From: Richard Henderson <rth@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010614101951.B28824@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org,
	binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
References: <20010613212940.A22683@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010613212940.A22683@lucon.org>; from hjl@lucon.org on Wed, Jun 13, 2001 at 09:29:40PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 09:29:40PM -0700, H . J . Lu wrote:
> Now we have
> 
> $LEHB5:
>         la      $25,foobar
> 	jalr	$25
> 	nop
> 	lw	$gp,cprestore($sp)
> $LEHE5:
> 
> When foobar throws an exception, GP won't get restored. What we want is
> 
> $LEHB5:
>         la      $25,foobar
> 	jalr	$25
> 	nop
> $LEHE5:
> 	lw	$gp,cprestore($sp)

Um, what exactly do you think the difference between these two is?

Hint: nothing.

I could have sworn there was an exception_receiver pattern on mips
to handle this, but I don't see it now.  It's relatively easy to fix;
see TARGET_LD_BUGGY_LDGP is handled on alpha.


r~
