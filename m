Received:  by oss.sgi.com id <S553758AbRBUTRs>;
	Wed, 21 Feb 2001 11:17:48 -0800
Received: from u-233-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.233]:64752
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553683AbRBUTRW>; Wed, 21 Feb 2001 11:17:22 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1LF4IM22028;
	Wed, 21 Feb 2001 16:04:18 +0100
Date:   Wed, 21 Feb 2001 16:04:18 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jim Freeman <jfree@sovereign.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: sync plea
Message-ID: <20010221160418.A21995@bacchus.dhis.org>
References: <20010221060711.A26654@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010221060711.A26654@sovereign.org>; from jfree@sovereign.org on Wed, Feb 21, 2001 at 06:07:11AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 21, 2001 at 06:07:11AM -0700, Jim Freeman wrote:

> I have a farm of MIPS, PPC, and IA32 machines that I need to
> keep running from a common current source tree.
> 
> The recent mips update into 2.4.2pre2 (thankyouthankyouthankyou...)
> has helped in this task, but the diff between any 2.4.2pre[n>=2] or
> 2.4.1-ac[n>=9] tree vs the MIPS cvs tree is still huge, and painful
> to cull through to wind up with a sane mips patch (should be fairly
> small since the update into 2.4.2pre2) against a 2.4.*{pre*|-ac*} tree.
> 
> A sync of mips cvs to any 2.4.1{pre*|-ac*} kernel post 2.4.2pre2
> would be of great use, but I don't know how much pain that entails
> for the maintainers.
> 
> In lieu of that, can anyone clue me in to newbie tricks (CVS or
> otherwise) for syncing 2 trees less painfully than culling diffs?

Imagine, that's what we do on a daily base.  The most easy receipe to make
diffs less painfull is half a gig of RAM which brings time for diffing
two kernel trees down to ~ 2s on an Origin or decent PC.

Unfortunately Linus dropped piles of additional patches I sent to him.
That's the standard way this works, so just wait ...

  Ralf
