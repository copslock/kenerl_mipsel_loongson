Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 17:40:29 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:19973 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225239AbTEHQk1>; Thu, 8 May 2003 17:40:27 +0100
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id DBEC11BD8F; Thu,  8 May 2003 09:40:22 -0700 (PDT)
Date: Thu, 8 May 2003 09:40:22 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org,
	Ladislav Michl <ladis@linux-mips.org>
Subject: Re: xdm oopses
Message-ID: <20030508164022.GA8956@foobazco.org>
References: <20030428071639.GA7578@simek> <20030508061117.GA30191@foobazco.org> <20030508073200.GA837@kopretinka> <20030508085814.GJ13672@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508085814.GJ13672@bogon.ms20.nix>
User-Agent: Mutt/1.5.3i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2003 at 10:58:15AM +0200, Guido Guenther wrote:

> On Wed, May 07, 2003 at 11:11:17PM -0700, Keith M Wesolowski wrote:
> > Other than that, your patch works fine for me; my Indy has 192MB
> > memory and it's detected properly.  I do get an oops in do_be from
> > xdm, but I get that without the patch also.

> That's xdm reading heaps of data from /dev/mem blindly (touching regions
> it better shouldn't read from) for prng purposes. We had a fix in
> Debian's xdm, hope the problem didn't creep back in. What X are you
> running?

This is from Debian - 4.1.0-16.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
