Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 12:13:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43710 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20030135AbZDBLNT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 12:13:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n32BDE2w003030;
	Thu, 2 Apr 2009 13:13:16 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n32BDCSx003028;
	Thu, 2 Apr 2009 13:13:12 +0200
Date:	Thu, 2 Apr 2009 13:13:12 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, wuzj@lemote.com
Subject: Re: [PATCH] added Loongson cpu-feature-overrides.h
Message-ID: <20090402111312.GA1678@linux-mips.org>
References: <1238658105-23260-1-git-send-email-r0bertz@gentoo.org> <20090402105613.GC28319@adriano.hkcable.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090402105613.GC28319@adriano.hkcable.com.hk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 02, 2009 at 06:56:13PM +0800, Zhang Le wrote:

> On 15:41 Thu 02 Apr     , Zhang Le wrote:
> > diff --git a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
> > new file mode 100644
> > index 0000000..550a10d
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
> 
> [snip]
> 
> > +#define cpu_icache_snoops_remote_store	1
> 
> This maybe should not exist here, since this only matters on SMP.
> It exists in Wu's version. Maybe Wu could explain it. Maybe it is just a typo.
> 
> Pulling him in.

This simply doesn't matter on a uniprocessor system.

  Ralf
