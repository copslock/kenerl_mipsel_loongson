Received:  by oss.sgi.com id <S305167AbQBSD6g>;
	Fri, 18 Feb 2000 19:58:36 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29818 "EHLO convert rfc822-to-8bit
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQBSD6P>; Fri, 18 Feb 2000 19:58:15 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA02771; Fri, 18 Feb 2000 20:01:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA74221
	for linux-list;
	Fri, 18 Feb 2000 19:44:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA22751;
	Fri, 18 Feb 2000 19:42:56 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id TAA03086;
	Fri, 18 Feb 2000 19:42:50 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <14510.4410.177164.703052@liveoak.engr.sgi.com>
Date:   Fri, 18 Feb 2000 19:42:50 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     brett <brett@madhouse.org>,
        Bruce Leggett <bleggett@sofamordanek.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux on O2?
In-Reply-To: <20000219010331.B19004@uni-koblenz.de>
References: <BDDC26ED91ACD1118D4E00805F9FDAC3B027F2@broomfield01.sofamordanek.com>
	<Pine.LNX.3.96.1000217171401.908G-100000@caligula.madhouse.org>
	<20000218035335.F5234@uni-koblenz.de>
	<14509.54953.882688.741736@liveoak.engr.sgi.com>
	<20000219010331.B19004@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
...
 > How about if myself and possibly others who currently are under NDA for SGI
 > would support such projects by describing things via email where
 > neither docs nor uncontaminated source is available and possibly some
 > source where it's (C)-clean and managment aproved.  Could something like
 > that be made working?  It's a shame that still nobody so far has had an
 > actual chance to start working on an O2 port or something like that.

       That should be ok; we have approval to do so (and I have
sometimes supplied information on that basis), at least for Indigo, Indigo2,
Indy, and Origin.  (There was some question about Octane and Onyx, especially
in regard to graphics.)  

       If someone is seriously interested in doing an O2 port, I will help
with explanations of the major issues, and we can make documentation available
under the same restrictions as Indy documentation (no redistribution, no
warranty, documentation is known to be inaccurate in various details).  
As I have described earlier, however, an O2 port is a major undertaking.
(It would be quite an interesting and challenging project, but it is
not simple.)

       Again, Indigo documentation, except via the method Ralf suggests,
is going to be hard to come by.  The O2 documentation, albeit somewhat
inaccurate, is on the other hand readily available.
