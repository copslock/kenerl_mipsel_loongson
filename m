Received:  by oss.sgi.com id <S553835AbRA0W5o>;
	Sat, 27 Jan 2001 14:57:44 -0800
Received: from saturn.mikemac.com ([216.99.199.88]:62473 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S553819AbRA0W5i>;
	Sat, 27 Jan 2001 14:57:38 -0800
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id OAA05689;
	Sat, 27 Jan 2001 14:57:24 -0800
Message-Id: <200101272257.OAA05689@saturn.mikemac.com>
To:     Karel van Houten <K.H.C.vanHouten@research.kpn.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: Your message of "Sat, 27 Jan 2001 11:52:05 +0100."
             <200101271052.LAA21268@sparta.research.kpn.com> 
Date:   Sat, 27 Jan 2001 14:57:24 -0800
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>Date: Sat, 27 Jan 2001 11:52:05 +0100 (MET)
>From: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
>Subject: Re: Cross compiling RPMs
>To: mikemac@mikemac.com (Mike McDonald)
>
>Mike wrote:
>> 
>>   If one were to go the native compiling route, what would the minimum
>> set of rpms needed be? kernel, bin-utils, cc. file-utils? ???
>> 
>
>It depends on what and how you want to compile. To use rpm, you need
>quite a lot tools (db3, patch, sed, grep, find,...). Beside that
>you'll at least need glibc, binutils, gcc, and make. But you'll find
>out that you'll have to compile flex, bison, m4, automake, autoconf,
>and even perl to get rpm builds going. My mipsel native environment
>currently has the following packages:

  I was thinking of what the MINIMUM set of RPMs you needed installed
so you could bootstrap a system up from sources, not what's the
minimum needed to recompile any arbitrary RPM.

>But you surely can start with less... :-)

  With less than 150 files installed in a root file system, I can
install the bin-utils, gcc, make, and glibc RPMs. From there, I should
be able to begin cross compiling the other basic RPMs for a system.
That's my ultimate goal.

  Mike McDonald
  mikemac@mikemac.com
