Received:  by oss.sgi.com id <S42406AbQI2X5Y>;
	Fri, 29 Sep 2000 16:57:24 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.19.53]:13575
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42392AbQI2X5J>; Fri, 29 Sep 2000 16:57:09 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868992AbQI2X4w>;
        Sat, 30 Sep 2000 01:56:52 +0200
Date:   Sat, 30 Sep 2000 01:56:52 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, debian-glibc@lists.debian.org
Subject: Re: debian glibc 2.1.94 package on mips
Message-ID: <20000930015652.A29860@bacchus.dhis.org>
References: <20000929175046.A5972@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000929175046.A5972@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Sep 29, 2000 at 05:50:46PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 29, 2000 at 05:50:46PM +0200, Florian Lohoff wrote:

> Hi,
> i tried building the debian glibc source package for 2.1.94 and
> failed like this ...

[...]

> binutils/gcc are cvs snapshots of 20000829

You need extra patches for cvs-gcc which gets constructors wrong.

  Ralf
