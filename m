Received:  by oss.sgi.com id <S553887AbRBTU46>;
	Tue, 20 Feb 2001 12:56:58 -0800
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:1007
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553873AbRBTU4t>; Tue, 20 Feb 2001 12:56:49 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1KKuG504374;
	Tue, 20 Feb 2001 21:56:16 +0100
Date:   Tue, 20 Feb 2001 21:56:16 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     David Jez <dave.jez@seznam.cz>
Cc:     ppopov@pacbell.net, linux-mips@oss.sgi.com
Subject: Re: redhat 7.0
Message-ID: <20010220215616.F2086@bacchus.dhis.org>
References: <3A901B3F.ADADC601@pacbell.net> <20010220074903.A68652@stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220074903.A68652@stud.fee.vutbr.cz>; from dave.jez@seznam.cz on Tue, Feb 20, 2001 at 07:49:04AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 20, 2001 at 07:49:04AM +0100, David Jez wrote:

> > Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
> > running into is that after I netboot and mount simple-0.2b as the root
> > fs, and install the rpm-4.0 tarball, rpm doesn't work with the
> > libraries, or lack of, of that root fs.  It looks like I need an fs with
> > a working rpm-4.0, so that I can mount my second disk somewhere and
> > install the 7.0 packages.  Any suggestions?
> Yes,
> If you download rpm-3.0 (I'm not sure, try get newer version) you'll should
> be able to work with rpm 4 packages.

Oss has a tarball with statically linked rpm 4 binaries.  Use that to
convert your rpm database and then install the rpm 4 rpm package for real.

  Ralf
