Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78F91k12357
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:09:01 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78F90V12349
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:09:00 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id C209A125C3; Wed,  8 Aug 2001 08:08:59 -0700 (PDT)
Date: Wed, 8 Aug 2001 08:08:59 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Mark Mitchell <mark@codesourcery.com>
Cc: Eric Christopher <echristo@redhat.com>,
   "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <20010808080859.D26983@lucon.org>
References: <997281490.1290.49.camel@ghostwheel.cygnus.com> <11900000.997283081@gandalf.codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <11900000.997283081@gandalf.codesourcery.com>; from mark@codesourcery.com on Wed, Aug 08, 2001 at 08:04:41AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 08:04:41AM -0700, Mark Mitchell wrote:
> 
> 
> --On Wednesday, August 08, 2001 03:38:08 PM +0100 Eric Christopher 
> <echristo@redhat.com> wrote:
> 
> > Quick question:  You said you tested, but I wanted to verify that you
> > were able to bootstrap with no regressions?  If so, then it is approved
> > for the trunk.  Mark will need to approve for the branch.
> 
> What incredibly critical problem does this solve?  Recall that 3.0.1
> is currently frozen, waiting only for some breakage in V3-land to get
> fixed, before we produce a release candidate.

Have you seen reports on any Linux/mips targets at

http://gcc.gnu.org/ml/gcc-testresults/

My goal is to make it appear one day. I'd like to see gcc 3.0.1 is
at least partially supported on Linux/mips.



H.J.
