Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2003 10:31:47 +0000 (GMT)
Received: from tolkor.SGI.COM ([IPv6:::ffff:198.149.18.6]:24499 "EHLO
	tolkor.sgi.com") by linux-mips.org with ESMTP id <S8225229AbTAVKbq>;
	Wed, 22 Jan 2003 10:31:46 +0000
Received: from ledzep.americas.sgi.com (ledzep.americas.sgi.com [192.48.203.134])
	by tolkor.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with ESMTP id h0MAdZkq025158
	for <linux-mips@linux-mips.org>; Wed, 22 Jan 2003 04:39:36 -0600
Received: from daisy-e236.americas.sgi.com (daisy-e236.americas.sgi.com [128.162.236.214]) by ledzep.americas.sgi.com (SGI-8.9.3/americas-smart-nospam1.1) with ESMTP id EAA17725; Wed, 22 Jan 2003 04:31:33 -0600 (CST)
Received: from taclab54.munich.sgi.com (taclab54.munich.sgi.com [144.253.195.54]) by daisy-e236.americas.sgi.com (SGI-8.9.3/SGI-server-1.8) with ESMTP id EAA48958; Wed, 22 Jan 2003 04:31:32 -0600 (CST)
Received: (from hch@localhost)
	by taclab54.munich.sgi.com (8.11.6/8.11.6) id h0MHjed31508;
	Wed, 22 Jan 2003 12:45:40 -0500
Date: Wed, 22 Jan 2003 12:45:40 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: linux-mips@linux-mips.org, gnb@melbourne.sgi.com
Subject: Re: debian's mips userland on mips64
Message-ID: <20030122124540.A31505@sgi.com>
References: <20030122073006.GF6262@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030122073006.GF6262@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Wed, Jan 22, 2003 at 06:30:06PM +1100
Return-Path: <hch@taclab54.munich.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 22, 2003 at 06:30:06PM +1100, Andrew Clausen wrote:
> Hi all,
> 
> I'm playing with Debian on an Origin 200 (aka ip27 - 64-bit mips).
> The current setup in the mips64-linux world is 64bit kernel +
> 32bit userland.  So, a mips64-linux kernel can be mostly run a
> mips32-linux userland out of the box.
> 
> Unfortunately, this doesn't apply to strace, as this play with
> the 64bit kernel's stack (eg: struct pt_regs), which is different in
> mips32 and mips64.
> 
> So, I guess the solution is to hack (it's ugly as hell already...)
> strace to detect and understand the 64 bit stack from a 32 bit
> userland?

I don't think so.  You should rather implement a sys32_ptrace and
reference it in the 32bit syscall vector.  Look at the version in
arch/ia64/ia32/sys_ia32.c for an example.
