Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 18:10:02 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:13559 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225193AbTGWRKA>;
	Wed, 23 Jul 2003 18:10:00 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6NH9k706963;
	Wed, 23 Jul 2003 10:09:46 -0700
Date: Wed, 23 Jul 2003 10:09:46 -0700
From: Jun Sun <jsun@mvista.com>
To: Tiemo Krueger - mycable GmbH <tk@mycable.de>
Cc: saravana_kumar@naturesoft.net, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: Cross Compilation
Message-ID: <20030723100946.N3135@mvista.com>
References: <1058941229.9252.13.camel@192.168.0.206> <3F1E3D27.2030501@mycable.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F1E3D27.2030501@mycable.de>; from tk@mycable.de on Wed, Jul 23, 2003 at 09:45:43AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 23, 2003 at 09:45:43AM +0200, Tiemo Krueger - mycable GmbH wrote:
> You could even use the buildroot thing from uclibc.org:
> 
> http://uclibc.org/cgi-bin/cvsweb/buildroot/buildroot.tar.gz?tarball=1
> 
> It's one of the most simple way for cross toolchain beginners, it
> provides you finally with a toolchain and rootfile system and more
>

I took a look.  It looks similar to one project that I worked on
before.   Very interesting.

Has anybody tried successfully to do a cross MIPS yet?  From a Linux/i386 host
obviously ...

Jun
