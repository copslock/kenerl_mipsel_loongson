Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2Q46jg02397
	for linux-mips-outgoing; Sun, 25 Mar 2001 20:06:45 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2Q46iM02394
	for <linux-mips@oss.sgi.com>; Sun, 25 Mar 2001 20:06:44 -0800
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 50E63109CE; Sun, 25 Mar 2001 20:07:08 -0800 (PST)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id B47741F429; Sun, 25 Mar 2001 20:06:42 -0800 (PST)
Date: Sun, 25 Mar 2001 20:06:42 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Joe deBlaquiere <jadb@redhat.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
Message-ID: <20010325200642.C25362@foobazco.org>
References: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses> <3ABEB120.8020609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABEB120.8020609@redhat.com>; from jadb@redhat.com on Sun, Mar 25, 2001 at 09:01:52PM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 25, 2001 at 09:01:52PM -0600, Joe deBlaquiere wrote:

> 1. Would it be possible to lump some of the different MIPS variants
> together more closely? In my dream world I could build one kernel
> that would boot on every mips architecture. This way the work can be
> more general. As it stands now, if you want Tx39 or Vr41 variants
> you're working out of a different tree. With the number of SoC core
> products coming out at present, this predicament is only likely to
> get more serious. I know at one point in time you could boot a
> single ARM kernel on several different systems and it would adapt
> it's processor specifics at runtime. Such a design might help to
> bring the MIPS world together a bit.

I'm about 2/3 of the way through writing a patch that will bring
boot-time machine detection and parameters to mips - this is similar
to a scheme that was suggested some time ago by Jun and is also based
on a short discussion I had with Ralf about cleaning up proc.c.

This is only the first step, though, as there are a lot of ifdefs in
headers and such.  I will release this patch for review sometime in
the next week.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
