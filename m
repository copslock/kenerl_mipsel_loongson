Received:  by oss.sgi.com id <S553825AbQKBRkw>;
	Thu, 2 Nov 2000 09:40:52 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:64011 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553647AbQKBRkt>;
	Thu, 2 Nov 2000 09:40:49 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id JAA25909;
	Thu, 2 Nov 2000 09:39:52 -0800
Date:   Thu, 2 Nov 2000 09:39:52 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Soon I will give up on MIPS kernel!
Message-ID: <20001102093952.A25612@chem.unr.edu>
References: <3A018098.ECB9E20C@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A018098.ECB9E20C@isratech.ro>; from octavp@isratech.ro on Thu, Nov 02, 2000 at 09:56:24AM -0500
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Nov 02, 2000 at 09:56:24AM -0500, Nicu Popovici wrote:

> The steps that I did are :
> 1. made a linux symlink to linux_2_2_CVS

There is absolutely no reason to do this. In fact, it's death. Put the
kernel sources in your home directory or a scratch area. Leave
everything in /usr/src as it was when you installed your system.

> I want to manage to crosscompile this kernel on a i686 machine for a
> mips machine. So I saw there that it says something  about
> /usr/include/asm  which is for my i686 machine. I guess that the errors
> come from here. Can you tell me what I have to do. I have to mention

Yep. Just...don't do that. /usr/src/linux is for your native sources
and headers. Do not cross-build kernels in /usr/src, ever.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
