Received:  by oss.sgi.com id <S553696AbQLUCmx>;
	Wed, 20 Dec 2000 18:42:53 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:22029 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553653AbQLUCm0>;
	Wed, 20 Dec 2000 18:42:26 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id SAA20912;
	Wed, 20 Dec 2000 18:39:38 -0800
Date:   Wed, 20 Dec 2000 18:39:38 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     kjlin <kj.lin@viditec-netmedia.com.tw>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Run the cross-compiled program.
Message-ID: <20001220183938.A20077@chem.unr.edu>
References: <053601c06a6c$ee66ca60$056aaac0@kjlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <053601c06a6c$ee66ca60$056aaac0@kjlin>; from kj.lin@viditec-netmedia.com.tw on Wed, Dec 20, 2000 at 06:09:25PM +0800
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Dec 20, 2000 at 06:09:25PM +0800, kjlin wrote:

> Can anyone point out which step i done wrong in the process of
> cross-compiling an program with the -static option?  I made the
> cross-compile toolkit by myself.

Be aware of an unrelated problem: statically linked binaries that
attempt to access functions in the nss libraries will crash.

> FATAL: kernel too old
> My target system is an embedded mips board running linux-2.2.14 and

One possibility is that you do not have the proc filesystem available
when running the program.  Certain older libc has issues with
detecting version when /proc was not available.

Another possibility is that you somehow got hold of the glibc that I
built, from the same toolkit.  That glibc will not run on kernel <
2.3.99.

I guess I don't quite understand why you would want to use kernel 2.2
with glibc 2.2.  For embedded purposes, glibc 2.0 will save you a lot
of space; if you just want the newest stuff unconditionally, use
kernel 2.4.  The specific libc you are using is rather dated anyway.
While it worked for most purposes it is hardly bug-free.  Consider
using CVS glibc, or the glibc from Florian's Debian build environment.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
