Received:  by oss.sgi.com id <S554106AbRA2AJe>;
	Sun, 28 Jan 2001 16:09:34 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:52570 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S554102AbRA2AJP>;
	Sun, 28 Jan 2001 16:09:15 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com (dhcp-163-154-5-240.engr.sgi.com [163.154.5.240]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA16856
	for <linux-mips@oss.sgi.com>; Sun, 28 Jan 2001 16:08:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869667AbRA2AFS>; Sun, 28 Jan 2001 16:05:18 -0800
Date: 	Sun, 28 Jan 2001 16:05:18 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Mike McDonald <mikemac@mikemac.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
Message-ID: <20010128160518.E4287@bacchus.dhis.org>
References: <20010128041025.C4287@bacchus.dhis.org> <200101281745.JAA25600@saturn.mikemac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101281745.JAA25600@saturn.mikemac.com>; from mikemac@mikemac.com on Sun, Jan 28, 2001 at 09:45:39AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Jan 28, 2001 at 09:45:39AM -0800, Mike McDonald wrote:

> >>   I was thinking of what the MINIMUM set of RPMs you needed installed
> >> so you could bootstrap a system up from sources, not what's the
> >> minimum needed to recompile any arbitrary RPM.
> >
> >Really depends on what you want to do.  Many packages detect other packages
> >or features of other packages.  This builds a big evil network of
> >dependencies which make bootstrapping somewhat hard.  It's a good idea to
> >start with an as complete installation as possible.
> 
>   I want to do just the opposite. I want to start with the minimum set
> of installed binaries and build a complete binary distribution from
> its sources. (That means finding the root of the dependency graph and
> starting there, assuming there actually is one. It isn't necessarily a
> single rpm. People like to make circular dependancies!)

Rpm is a particularly sucky self dependency.  One generation of rpm
inherits certain settings from it's ancestor so bootstrapping only from
sources is a royally sucky.

  Ralf
