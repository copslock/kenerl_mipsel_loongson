Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f333qWF18760
	for linux-mips-outgoing; Mon, 2 Apr 2001 20:52:32 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f333qVM18757
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 20:52:31 -0700
Received: from redhat.com (dhcp-253.hsv.redhat.com [172.16.17.253] (may be forged))
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id UAA08630;
	Mon, 2 Apr 2001 20:52:06 -0700 (PDT)
Message-ID: <3AC93C0B.5020102@redhat.com>
Date: Mon, 02 Apr 2001 21:57:15 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses> <20010403003059.E25228@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Florian Lohoff wrote:

> On Tue, Apr 03, 2001 at 12:22:48AM +0200, Kevin D. Kissell wrote:
> 
>> I'm not sure exactly what you mean here.  That no one would
>> consider using your Debian cross environment?  That no one
> 
> 
> I am not building cross, i am not building the debian cross
> toolchain. Just for completeness.
> 
> 
>> would consider doing cross-development?   What part of it 
>> seems to you to be a show-stopper?
> 
> 
> A major problem get the thing in which the configure try to 
> begin to build executables and guess on the behaviour of the
> OS to run on. This ends to be a hack and reminds me on
> "pre gnu configure" times where one had to deal
> with hundrets of "config.h" or "os.h" files. 
> 

Perfect it is not, but it's not nearly _that_ bad either. I would say 40% of the RPMs I've tried will configure out of the box for a cross build. Another 40% or so require a few "export ac_cv_sizeof_long=4" kind of settings to configure for a cross build. The remaining 20% are painful.

Most of the package maintainers have been very receptive to configuration help for cross build environments. Of course some seem to have died or gone to work for Microsoft (is there a measurable difference?). 

> If you are going to use anything like a package format
> might it be "rpm" or "deb" the dependencies tend to be
> utterly broken as the dependcies are guessed by stuff like
> "ldd" output and friends.
> 

You can of course specify the target to rpm when unpacking the source... 

> If you have a 90Meg source tarball and build a 4Meg Ramdisk
> for a Nino out of it. Fine. 
> 

Of course you could compile the packages natively on the Nino on a NFS mount over serial-ppp... ;)

-- 
Joe
