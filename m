Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34FICH20728
	for linux-mips-outgoing; Wed, 4 Apr 2001 08:18:12 -0700
Received: from chmls05.mediaone.net (chmls05.mediaone.net [24.147.1.143])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34FIBM20725
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 08:18:11 -0700
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls05.mediaone.net (8.11.1/8.11.1) with SMTP id f34FHhx13488;
	Wed, 4 Apr 2001 11:17:47 -0400 (EDT)
From: "Jay Carlson" <nop@nop.com>
To: "Joe deBlaquiere" <jadb@redhat.com>, "Florian Lohoff" <flo@rfc822.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: RE: Dumb Question on Cross-Development
Date: Wed, 4 Apr 2001 11:17:39 -0400
Message-ID: <KEEOIBGCMINLAHMMNDJNIEHHCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3AC93C0B.5020102@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Perfect it is not, but it's not nearly _that_ bad either. I would
> say 40% of the RPMs I've tried will configure out of the box for
> a cross build. Another 40% or so require a few "export
> ac_cv_sizeof_long=4" kind of settings to configure for a cross
> build. The remaining 20% are painful.

Yeah, and it's not so bad once you start building up a config.site file you
can reuse across builds.  I got this idea from the debian dpkg-cross
package.  For people who aren't debian-y, the idea is that you set
CONFIG_SITE to point at a file like
http://www.csee.umbc.edu/~acedil1/agenda/files/agenda-config.site and run
configure as normal.  (I don't think I like that particular file but it
should give you ideas.)

BTW dpkg-cross comes with a tool that does ldd via grepping through objdump
output.

Jay
