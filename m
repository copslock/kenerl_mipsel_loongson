Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 18:04:46 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:54455
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225239AbTEHREn>; Thu, 8 May 2003 18:04:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 6EDD32BC32; Thu,  8 May 2003 19:04:34 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 11758-07;
 Thu,  8 May 2003 19:04:33 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 6BE672BC31; Thu,  8 May 2003 19:04:28 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id E17491735D; Thu,  8 May 2003 19:00:51 +0200 (CEST)
Date: Thu, 8 May 2003 19:00:51 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	Ladislav Michl <ladis@linux-mips.org>
Subject: Re: xdm oopses
Message-ID: <20030508170051.GD29550@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org,
	Keith M Wesolowski <wesolows@foobazco.org>,
	Ladislav Michl <ladis@linux-mips.org>
References: <20030428071639.GA7578@simek> <20030508061117.GA30191@foobazco.org> <20030508073200.GA837@kopretinka> <20030508085814.GJ13672@bogon.ms20.nix> <20030508164022.GA8956@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508164022.GA8956@foobazco.org>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2003 at 09:40:22AM -0700, Keith M Wesolowski wrote:
> > That's xdm reading heaps of data from /dev/mem blindly (touching regions
> > it better shouldn't read from) for prng purposes. We had a fix in
> > Debian's xdm, hope the problem didn't creep back in. What X are you
> > running?
> 
> This is from Debian - 4.1.0-16.
The changes went into 4.2.1-4 at 18 Nov 2002.
 -- Guido
