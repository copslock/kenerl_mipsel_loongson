Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 10:38:48 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:38068
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225236AbTEHJiZ>; Thu, 8 May 2003 10:38:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 34A842BC3A; Thu,  8 May 2003 11:38:22 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09113-08;
 Thu,  8 May 2003 11:38:20 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id D4D502BC31; Thu,  8 May 2003 11:38:15 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id A72B51739C; Thu,  8 May 2003 10:58:15 +0200 (CEST)
Date: Thu, 8 May 2003 10:58:15 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@linux-mips.org, Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] Highmem detection for Indigo2
Message-ID: <20030508085814.GJ13672@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Keith M Wesolowski <wesolows@foobazco.org>,
	linux-mips@linux-mips.org, Ladislav Michl <ladis@linux-mips.org>
References: <20030428071639.GA7578@simek> <20030508061117.GA30191@foobazco.org> <20030508073200.GA837@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508073200.GA837@kopretinka>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, May 07, 2003 at 11:11:17PM -0700, Keith M Wesolowski wrote:
> Other than that, your patch works fine for me; my Indy has 192MB
> memory and it's detected properly.  I do get an oops in do_be from
> xdm, but I get that without the patch also.
That's xdm reading heaps of data from /dev/mem blindly (touching regions
it better shouldn't read from) for prng purposes. We had a fix in
Debian's xdm, hope the problem didn't creep back in. What X are you
running?
 -- Guido
