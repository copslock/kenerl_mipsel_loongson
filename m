Received:  by oss.sgi.com id <S553740AbQK2ODa>;
	Wed, 29 Nov 2000 06:03:30 -0800
Received: from adsl-61-8-131.mia.bellsouth.net ([208.61.8.131]:50961 "EHLO
        spawn.hockeyfiend.com") by oss.sgi.com with ESMTP
	id <S553736AbQK2ODF>; Wed, 29 Nov 2000 06:03:05 -0800
Received: from localhost ([127.0.0.1] ident=chris)
	by spawn.hockeyfiend.com with esmtp (Exim 3.16 #1 (Debian))
	id 1417nu-0005zO-00; Wed, 29 Nov 2000 09:01:46 -0500
Date:   Wed, 29 Nov 2000 09:01:40 -0500 (EST)
From:   "Christopher C. Chimelis" <chris@debian.org>
X-Sender: chris@spawn.hockeyfiend.com
To:     Jamie Fifield <fifield@amirix.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: cross-compile tools made easy ...
In-Reply-To: <00Nov29.094316ast.7303@dragon.appliedmicro.ns.ca>
Message-ID: <Pine.LNX.4.21.0011290900450.22938-100000@spawn.hockeyfiend.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Wed, 29 Nov 2000, Jamie Fifield wrote:

> On that vein.  I've got a trvial patch against the binutils in Debian (woody)
> for a cross binutils for big endian mips.
> 
> jamie:~$ dpkg -s binutils-mips
> Package: binutils-mips
> Status: install ok installed
> Priority: extra
> Section: devel
> Installed-Size: 6364
> Maintainer: Christopher C. Chimelis <chris@debian.org>
> Source: binutils
> Version: 2.10.1.0.2-1
> Suggests: binutils (= 2.10.1.0.2-1)
> Description: Binary utilities that support MIPS (Big Endian) targets.
>  The programs in this package are used to manipulate binary and object
>  files that may have been created on the MIPS (Big Endian) architecture.
>  This package is primarily for MIPS developers and cross-compilers and is
>  not needed by normal users or developers.
> 
> 
> My version is compiled against glibc 2.1.3, so YMMV against 2.2.
> 
> Chris: Any chance I could persuade you to upload a binutils-mips to Woody? :)

Ok...I'll consider it more when I return (getting on a plane in an
hour).  Sorry for the brevity, but I'm in travel mode already :-P

C
