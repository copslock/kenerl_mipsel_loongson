Received:  by oss.sgi.com id <S42258AbQGSQ3N>;
	Wed, 19 Jul 2000 09:29:13 -0700
Received: from brainguy.tc.mtu.edu ([141.219.5.85]:43474 "HELO
        brainguy.tc.mtu.edu") by oss.sgi.com with SMTP id <S42257AbQGSQ2q>;
	Wed, 19 Jul 2000 09:28:46 -0700
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (Postfix) with ESMTP
	id C5D231A196; Wed, 19 Jul 2000 12:28:21 -0400 (EDT)
Received: by crow.mr-happy.com (Postfix, from userid 22448)
	id 61A328D58; Wed, 19 Jul 2000 12:28:11 -0400 (EDT)
Date:   Wed, 19 Jul 2000 11:28:11 -0500
From:   Andy Isaacson <adi@mr-happy.com>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
        linuxce-devel@linuxce.org
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000719112811.A23225@mr-happy.com>
References: <Pine.GSO.3.96.1000719160110.21239D-100000@delta.ds2.pg.gda.pl> <Pine.SGI.4.10.10007191041270.6330-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SGI.4.10.10007191041270.6330-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Wed, Jul 19, 2000 at 11:54:59AM -0300
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adi/pgp.txt
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 19, 2000 at 11:54:59AM -0300, J. Scott Kasten wrote:
> try the debian distro, but cannot find a big endian root image to install
> with, the site with the eb pacakages seems to be down, and cannot find the
> userland utility to unpack the .deb files, so this one is out completely
> at the moment.

A .deb file is just an ar(1) archive.  Use "ar xv foo.deb" to unpack.

-andy
-- 
Andy Isaacson <adi@mr-happy.com> http://web.mr-happy.com/~adi/
