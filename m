Received:  by oss.sgi.com id <S42259AbQIZRyQ>;
	Tue, 26 Sep 2000 10:54:16 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:38415 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42229AbQIZRxz>;
	Tue, 26 Sep 2000 10:53:55 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA16855;
	Tue, 26 Sep 2000 10:48:05 -0700
Date:   Tue, 26 Sep 2000 10:48:05 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000926104805.C15401@chem.unr.edu>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org> <20000926010416.B3761@paradigm.rfc822.org> <39D06065.FC00C7A0@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39D06065.FC00C7A0@niisi.msk.ru>; from raiko@niisi.msk.ru on Tue, Sep 26, 2000 at 12:37:57PM +0400
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 12:37:57PM +0400, Gleb O. Raiko wrote:

> Well, another question. Ralf uploaded cross tools rpms year ago. Does
> anybody have native rmps for big endian ? Also, does anybody have cross
> tools for sparc glibc 2.1 (RH6.x sparc distribution) ? I can't compile
> cross gcc on my Ultra, it seems like a bug in the sparc compiler, the
> process fails in parsing an enum decl in a header.

Native rpms, no. Native tarballs that "work," yes. I do have cross
tools (again, not RPMs) for sparc glibc 2.1 - it's my main devel
environment. I also have a script that builds an entire cross
toolchain and kernel for any versions of gcc/binutils/glibc/kernel
that you supply, and it's tested mainly on sparc glibc 2.1. I have not
yet had any problems building such a cross toolchain, with a mainly
stock RH6.2 system (make has to be upgraded to build recent
glibc). Information on how I'm doing this is at
http://foobazco.org/~wesolows/mips-cross.html. I recommend using the
make-cross tools, however, located at
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/. HTH.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
