Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2QHnGI28853
	for linux-mips-outgoing; Mon, 26 Mar 2001 09:49:16 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2QHnFM28850
	for <linux-mips@oss.sgi.com>; Mon, 26 Mar 2001 09:49:15 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 546CF7F3; Mon, 26 Mar 2001 19:49:13 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0C120F014; Mon, 26 Mar 2001 19:25:59 +0200 (CEST)
Date: Mon, 26 Mar 2001 19:25:59 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Joe deBlaquiere <jadb@redhat.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs
Message-ID: <20010326192559.A8385@paradigm.rfc822.org>
References: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses> <3ABEB120.8020609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABEB120.8020609@redhat.com>; from jadb@redhat.com on Sun, Mar 25, 2001 at 09:01:52PM -0600
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 25, 2001 at 09:01:52PM -0600, Joe deBlaquiere wrote:
> Just some unsorted random ideas:
> 
> 1. Would it be possible to lump some of the different MIPS variants
> together more closely? In my dream world I could build one kernel that
> would boot on every mips architecture. This way the work can be more
> general. As it stands now, if you want Tx39 or Vr41 variants you're
> working out of a different tree. With the number of SoC core products
> coming out at present, this predicament is only likely to get more
> serious. I know at one point in time you could boot a single ARM kernel on
> several different systems and it would adapt it's processor specifics at
> runtime. Such a design might help to bring the MIPS world together a bit.

There is at least a problem with endianess - I dont think there can be
a little and big endian kernel coexist in the same object or at least
not with major rework.

Why would you suggest having vr41 and TX39 in a seperat tree ? I had a
look in the linux-vr tree and i dont like some of their #ifdef spaghetti
stuff so i am currently working on TX39 stuff on top of the oss tree
which could be made cleanly. (Dont integrate all TX39 archs into one
subarch *grrr*)

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
