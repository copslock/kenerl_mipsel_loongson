Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2004 23:24:48 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:17595
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8226007AbUDZWYq>; Mon, 26 Apr 2004 23:24:46 +0100
Received: (qmail 13080 invoked from network); 26 Apr 2004 15:24:42 -0700
Received: from c-67-169-17-108.client.comcast.net (HELO gateway.total-knowledge.com) (67.169.17.108)
  by alpha.total-knowledge.com with SMTP; 26 Apr 2004 15:24:42 -0700
Received: (qmail 14523 invoked by uid 502); 26 Apr 2004 15:24:41 -0700
Date: Mon, 26 Apr 2004 15:24:41 -0700
From: ilya@theIlya.com
To: Damian Presswell <damian@clown-fish.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux Mips SGI O2 R5000 IP32 INSTALL
Message-ID: <20040426222441.GC1276@gateway.total-knowledge.com>
References: <408D6BFC.6030902@clown-fish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408D6BFC.6030902@clown-fish.com>
User-Agent: Mutt/1.5.6i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

Use Gentoo.
Also, Glaurung's kernels are bit out-od-date. Use self-built
kernel from recent linux-mips.org CVS. In worst case, use
one of Gentoo's kernel binaries.

	Ilya.

On Mon, Apr 26, 2004 at 09:07:24PM +0100, Damian Presswell wrote:
> My apologies if this is the wrong mailing list for this question -
> 
> I have recently aquired an SGI  O2 ip32 R5k box that I am trying to 
> install linux onto -
> 
> I have managed to get a binary 64bit kernel to boot vis nfs and bootp() 
> that I downloaded from Glaurungs website:
> 
> http://www.linux-mips.org/~glaurung/
> 
> however I am unsure as to the correct rootfs that I am suposed to use - 
> I pulled down the redhat 7.1 rootfs from somewhere but it hangs when 
> trying to start the 'local' service - and wont boot if this service is 
> switched off -
> 
> I would be grateful if you could suggest where I may download a suitable 
> rootfs and ecoff boot image that will work together on my O2 box - would 
> hate to give in at this stage - and indeed any other help you may be 
> able to give me as a linux mips O2 user - I will put together an updated 
> HOWTO once I am sure exactly what I am supposed to be doing - the 
> information and resources on this subject do seem to be a little vague -
> 
> thanks for your time
> 
> Damian
> 
> 
