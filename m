Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78Fjkp17983
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:45:46 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78FjjV17976
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:45:45 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 46EE3125C3; Wed,  8 Aug 2001 08:45:44 -0700 (PDT)
Date: Wed, 8 Aug 2001 08:45:44 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Mark Mitchell <mark@codesourcery.com>
Cc: Eric Christopher <echristo@redhat.com>,
   "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <20010808084544.A28287@lucon.org>
References: <20010808080859.D26983@lucon.org> <17100000.997285199@gandalf.codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17100000.997285199@gandalf.codesourcery.com>; from mark@codesourcery.com on Wed, Aug 08, 2001 at 08:39:59AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 08:39:59AM -0700, Mark Mitchell wrote:
> > Have you seen reports on any Linux/mips targets at
> 
> Sorry, that didn't answer my question.

I am trying to get gcc 3.x to work correctly on Linux/mips. I believe
very very few people have done

# ./configure
# make bootstrap
# make check

successfully on linux/mips. In fact, I may be the only one.


H.J.
