Received:  by oss.sgi.com id <S554080AbRA1RqB>;
	Sun, 28 Jan 2001 09:46:01 -0800
Received: from saturn.mikemac.com ([216.99.199.88]:44810 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S554078AbRA1Rpk>;
	Sun, 28 Jan 2001 09:45:40 -0800
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id JAA25600;
	Sun, 28 Jan 2001 09:45:39 -0800
Message-Id: <200101281745.JAA25600@saturn.mikemac.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: Your message of "Sun, 28 Jan 2001 04:10:26 PST."
             <20010128041025.C4287@bacchus.dhis.org> 
Date:   Sun, 28 Jan 2001 09:45:39 -0800
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>Date: 	Sun, 28 Jan 2001 04:10:26 -0800
>From: Ralf Baechle <ralf@oss.sgi.com>
>To: Mike McDonald <mikemac@mikemac.com>
>Subject: Re: Cross compiling RPMs
>
>On Sat, Jan 27, 2001 at 02:57:24PM -0800, Mike McDonald wrote:
>
>>   I was thinking of what the MINIMUM set of RPMs you needed installed
>> so you could bootstrap a system up from sources, not what's the
>> minimum needed to recompile any arbitrary RPM.
>
>Really depends on what you want to do.  Many packages detect other packages
>or features of other packages.  This builds a big evil network of
>dependencies which make bootstrapping somewhat hard.  It's a good idea to
>start with an as complete installation as possible.

  I want to do just the opposite. I want to start with the minimum set
of installed binaries and build a complete binary distribution from
its sources. (That means finding the root of the dependency graph and
starting there, assuming there actually is one. It isn't necessarily a
single rpm. People like to make circular dependancies!)

  Mike McDonald
  mikemac@mikemac.com
