Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 17:13:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2690 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025543AbXEaQNR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 17:13:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VGD5np012572;
	Thu, 31 May 2007 17:13:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4VGD4iL012571;
	Thu, 31 May 2007 17:13:04 +0100
Date:	Thu, 31 May 2007 17:13:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SMTC Patch
Message-ID: <20070531161304.GD4425@linux-mips.org>
References: <465C2DD8.6090208@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465C2DD8.6090208@mips.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 29, 2007 at 03:42:48PM +0200, Kevin D. Kissell wrote:

> The attached patch fixes some problems with the linux-mips.org
> 2.6.21 kernel for SMTC kernels for the Malta platform.
> 
> The fix to smtc.c just eliminates a warning that crept in.
> 
> The fixes to traps.c eliminate a hypothetical problem with
> out-of-bounds arguments (which were being reported, but acted
> upon anyway, which was somewhat insane)

set_vi_srs_handler is a void function, so currently can't return an
error either and not scribbling around isn't really a solution either
because no matter waht, for a vector number >= 8 won't work right.
So I went for a more drastic solution using BUG_ON().

> and a real one with
> PageMask going uninitialized in VPE 1 on any MIPS MT processor
> that doesn't reset PageMask to a sane value, which the archtecture
> does not require.
> 
> The restoration of the #define in mips-boards/generic/time.c
> is necessary to make the Malta SMTC kernel build.  If whoever
> deleted it has a good reason for it not to be done the way it's
> done, that's OK, but *some* definition must be provided.

I really don't see why we should fix code that writes r/o bits in a
failed attempt to do something that already happens elsewhere, so I
applied the patch which Chris sent in private.

Btw, your patch was dealing with four separate issues.  Would be kind of
handy if something like that would be submitted as four separate patches.

  Ralf

PS: A Signed-off-by: line please!
