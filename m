Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2013 16:13:41 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:35399 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823083Ab3KEPNhdi8bV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Nov 2013 16:13:37 +0100
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1VdiJr-0002aG-Am from joseph_myers@mentor.com ; Tue, 05 Nov 2013 07:13:27 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Nov 2013 07:13:27 -0800
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.2.247.3; Tue, 5 Nov 2013 15:13:24 +0000
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.76)        (envelope-from <joseph@codesourcery.com>)       id
 1VdiJn-0006Z8-KA; Tue, 05 Nov 2013 15:13:23 +0000
Date:   Tue, 5 Nov 2013 15:13:23 +0000
From:   "Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Rich Felker <dalias@aerifal.cx>
CC:     David Miller <davem@davemloft.net>, <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>
Subject: Re: prlimit64: inconsistencies between kernel and userland
In-Reply-To: <20131105012203.GA24286@brightrain.aerifal.cx>
Message-ID: <Pine.LNX.4.64.1311051510010.23472@digraph.polyomino.org.uk>
References: <20130628133835.GA21839@hall.aurel32.net> <20131104213756.GD18700@hall.aurel32.net>
 <20131104.194519.1657797548878784116.davem@davemloft.net>
 <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
 <20131105012203.GA24286@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 05 Nov 2013 15:13:27.0090 (UTC) FILETIME=[93F94120:01CEDA39]
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 4 Nov 2013, Rich Felker wrote:

> > Surely you can create new symbol versions for getrlimit64 and setrlimit64, 
> > with the old versions just using the 32-bit syscalls (or otherwise 
> > translating between conventions, but using the 32-bit syscalls is the 
> > simplest approach)?  I see no need to break compatibility with existing 
> > binaries.
> > 
> > As I noted in 
> > <https://sourceware.org/ml/libc-ports/2006-05/msg00020.html>, at that time 
> > the value of RLIM64_INFINITY for o32/n32 was purely a glibc convention the 
> > kernel didn't see at all.  It's only with the use of newer syscalls that 
> > this glibc convention is any sort of problem.
> 
> Why not just make them convert any value >= 0x7fffffffffffffff to
> infinity before making the syscall? There's certainly no meaningful
> use for finite values in that range...

It might be possible to do such a conversion in setrlimit64 - I'm not sure 
offhand if such a conversion for large finite values is valid, and a new 
symbol version is certainly the more conservative option - but getrlimit64 
in existing binaries should return results using the existing 
RLIM64_INFINITY, in case binaries compare against that, so if you change 
the header value to match the kernel I don't think you can avoid the new 
symbol version for getrlimit64, and versioning both together seems safer.

-- 
Joseph S. Myers
joseph@codesourcery.com
