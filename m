Received:  by oss.sgi.com id <S42195AbQJLCGW>;
	Wed, 11 Oct 2000 19:06:22 -0700
Received: from u-252.karlsruhe.ipdial.viaginterkom.de ([62.180.18.252]:24327
        "EHLO u-252.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42180AbQJLCF5>; Wed, 11 Oct 2000 19:05:57 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870102AbQJLCEo>;
        Thu, 12 Oct 2000 04:04:44 +0200
Date:   Thu, 12 Oct 2000 04:04:44 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, debian-mips@lists.debian.org
Subject: Re: glibc on MIPS ...
Message-ID: <20001012040444.J22141@bacchus.dhis.org>
References: <39E3D0B8.7F221344@mvista.com> <20001011041244.C7458@bacchus.dhis.org> <20001012002421.A678@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001012002421.A678@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Oct 12, 2000 at 12:24:21AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 12, 2000 at 12:24:21AM +0200, Florian Lohoff wrote:

> We are trying :) I am currently basing all my Debian-mips(el) things
> on glibc 2.0.6. It is the only stable solution right now. I am experimenting
> with the glibc 2.1.94-3 debian source package which i managed to get
> compiled with unmodified cvs binutils and gcc + the gcse patch.
> 
> Ralf reported bugs in the ld where he send me a patch. With that patch
> i get a "Bus Error" from the ld.so within the glibc build.

There patch is ok; you get those bus errors because there are bugs in
both ld and binutils that in most cases compensate each other.  If you
fix only one of them you get all sorts of funnies ...

Even with the fixes ld is not yet perfect - for example emacs and X still
fail.

  Ralf
