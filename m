Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 18:19:22 +0100 (BST)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26018 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20030717AbXJLRTO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 18:19:14 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 8411E1B56C3;
	Fri, 12 Oct 2007 19:19:52 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id C8E443CE3E5; Fri, 12 Oct 2007 19:19:38 +0200 (CEST)
Date:	Fri, 12 Oct 2007 19:19:38 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discardable strings for init and exit sections
Message-ID: <20071012171938.GB6476@stusta.de>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 12, 2007 at 05:50:01PM +0100, Maciej W. Rozycki wrote:

>  We currently have infrastructure for discardable text and data, but no 
> such thing for strings.  This is especially notable for inline strings 
> such as ones used by printk() which are left behind resident in the memory 
> throughout the life of the system even though code referring to them has 
> been removed.
> 
>  Following a short discussion at the linux-mips list, here is a proposed 
> implementation for discardable strings.  It adds __initstr and __exitstr 
> plus most of the usual variations, but most importantly it adds wrapper 
> macros that may be used for inline strings that make them be put in
> separate sections which may then be discarded, while still preserving the 
> usual merging property of sections containing strings.  The macros are 
> called _i() and _e(), with the other alternatives adding at most two 
> letters each.  This has been inspired by how the GNU gettext handles 
> localised strings in a way that does not add too much clutter and the 
> result is still reasonably well readable.  Some use examples have been 
> included in <linux/init.h>.
>...

I have an objection against this approach:

Our __*init*/__*exit* annotations are already a constant source of bugs, 
and adding more pifalls (e.g. forgotten removal of _i()/_e() when a 
function is no longer __*init*/__*exit*) doesn't sound like a good plan.

Shouldn't it be possible to automatically determine where to put the 
strings? I don't know enough gcc/ld voodoo for being able to tell 
whether it is currently possible, and if yes how, but doing it 
automatically sounds like the only solution that wouldn't result in an
unmaintainable mess.

Ideally, even the current annotations might one day no longer be 
required and replaced with some way to express things like "everything 
only required by module_init() can be __init".

cu
Adrian

BTW: Please add diffstat output when sending patches.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
