Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 19:27:34 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:51126 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225211AbTGWS1b>;
	Wed, 23 Jul 2003 19:27:31 +0100
Received: (qmail 14554 invoked by uid 6180); 23 Jul 2003 18:27:27 -0000
Date: Wed, 23 Jul 2003 11:27:27 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Jun Sun <jsun@mvista.com>
Cc: Tiemo Krueger - mycable GmbH <tk@mycable.de>,
	saravana_kumar@naturesoft.net, linux-mips@linux-mips.org
Subject: Re: Cross Compilation
Message-ID: <20030723112727.R10468@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <1058941229.9252.13.camel@192.168.0.206> <3F1E3D27.2030501@mycable.de> <20030723100946.N3135@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030723100946.N3135@mvista.com>; from jsun@mvista.com on Wed, Jul 23, 2003 at 10:09:46AM -0700
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

I find that the uClibC tools are excellent, and have no problems generating
MIPS binaries from an i386 host ;)

-Jeff

On Wed, Jul 23, 2003 at 10:09:46AM -0700, Jun Sun wrote:
> On Wed, Jul 23, 2003 at 09:45:43AM +0200, Tiemo Krueger - mycable GmbH wrote:
> > You could even use the buildroot thing from uclibc.org:
> > 
> > http://uclibc.org/cgi-bin/cvsweb/buildroot/buildroot.tar.gz?tarball=1
> > 
> > It's one of the most simple way for cross toolchain beginners, it
> > provides you finally with a toolchain and rootfile system and more
> >
> 
> I took a look.  It looks similar to one project that I worked on
> before.   Very interesting.
> 
> Has anybody tried successfully to do a cross MIPS yet?  From a Linux/i386 host
> obviously ...
> 
> Jun
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
