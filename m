Received:  by oss.sgi.com id <S42206AbQJKWaC>;
	Wed, 11 Oct 2000 15:30:02 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:32273 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42193AbQJKW3a>;
	Wed, 11 Oct 2000 15:29:30 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 930B87D9; Thu, 12 Oct 2000 00:28:46 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7BA169014; Thu, 12 Oct 2000 00:24:21 +0200 (CEST)
Date:   Thu, 12 Oct 2000 00:24:21 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, debian-mips@lists.debian.org
Subject: Re: glibc on MIPS ...
Message-ID: <20001012002421.A678@paradigm.rfc822.org>
References: <39E3D0B8.7F221344@mvista.com> <20001011041244.C7458@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001011041244.C7458@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Oct 11, 2000 at 04:12:44AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 11, 2000 at 04:12:44AM +0200, Ralf Baechle wrote:
> On Tue, Oct 10, 2000 at 07:30:16PM -0700, Jun Sun wrote:
> > I also heard about the debian-mips project.  What glibc is used here?
> 
> A pre-2.2 snapshot.  Not yet stable and requires a binutils snapshot to
> build which also isn't yet stable.  But we're getting closer and things
> are beginning to look promising.

We are trying :) I am currently basing all my Debian-mips(el) things
on glibc 2.0.6. It is the only stable solution right now. I am experimenting
with the glibc 2.1.94-3 debian source package which i managed to get
compiled with unmodified cvs binutils and gcc + the gcse patch.

Ralf reported bugs in the ld where he send me a patch. With that patch
i get a "Bus Error" from the ld.so within the glibc build.

So currently - No real work on glibc 2.2 based debian but that will
change soon i guess ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
