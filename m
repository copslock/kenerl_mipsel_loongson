Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ONSZwJ001656
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 16:28:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ONSZUZ001655
	for linux-mips-outgoing; Wed, 24 Apr 2002 16:28:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ONSWwJ001652
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 16:28:32 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id QAA46078;
	Wed, 24 Apr 2002 16:28:58 -0700 (PDT)
Date: Wed, 24 Apr 2002 16:28:58 -0700
From: Geoffrey Espin <espin@idiom.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: Updates for RedHat 7.1/mips
Message-ID: <20020424162858.A44115@idiom.com>
References: <20020423155925.A8846@lucon.org> <20020424135339.A24558@idiom.com> <20020424140156.A28438@lucon.org> <20020424141136.A63873@idiom.com> <20020424141840.A28683@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020424141840.A28683@lucon.org>; from H . J . Lu on Wed, Apr 24, 2002 at 02:18:40PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 24, 2002 at 02:18:40PM -0700, H . J . Lu wrote:
> > Sorry, I should have specified my kernel *IS* recently (Monday)
> > from linux-mips.sourceforge.net.  And it was previously sync'd
> > to oss.sgi.com on Sunday, 21Apr02.
> Your kernel still have references to symbols in discarded sections. Please
> read linux/include/linux/init.h:

Woops, I wasn't working in my latest OSS/SF tree, as I thought.
All compiles and runs well.  Sorry for the noise.  Thanks for
the new tools, H.J..

Geoff
-- 
Geoffrey Espin
espin@idiom.com
--
