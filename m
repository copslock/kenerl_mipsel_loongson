Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9ULlrQ11211
	for linux-mips-outgoing; Tue, 30 Oct 2001 13:47:53 -0800
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9ULlk011207
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 13:47:46 -0800
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id 003132B6FE; Tue, 30 Oct 2001 21:47:39 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 845A1C8CA; Tue, 30 Oct 2001 21:46:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 6EB58E826; Tue, 30 Oct 2001 21:46:19 +0000 (GMT)
Date: Tue, 30 Oct 2001 21:46:19 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>,
   <linux-vax@mithra.physics.montana.edu>
Subject: Re: [LV] FYI: Mopd ELF support
In-Reply-To: <Pine.GSO.3.96.1011029170937.3407G-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.32.0110302144340.14320-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Okay it didn't go so well.. my VAX couldn't boot the file I normally use
with this mopd (I had to rebuild it for a static libelf)...

I've put a tgz up at

http://www.skynet.ie/~airlied/vax/mopd_on_the_vax.tgz

it contains the file I was trying to boot and the tcpdumps of this mopd
and the one I normally use ...

if you need any more info give me a shout ..

Regards,
	Dave.


On Mon, 29 Oct 2001, Maciej W. Rozycki wrote:

> Hi,
>
>  I've made a preliminary version of mopd with ELF support available.  It's
> Mats O. Jansson's mopd 2.5.3 with several fixes, updates and enhancements.
> The work is definitely not finished, but basic functionality is already
> implemented.  I'm making it available due to the amount of PITA
> maintenance of traditional mopd image formats incurs, in hope someone will
> find it useful.  Libelf is required for this version of mopd.  It should
> build and run on any Linux system, regardless of endianness.  It might
> work on other systems as well.
>
>  I've made RPM packages available at the usual place (i.e.
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/').  Beside source packages there are
> i386 and mipsel binary ones available.  Grab the latest version; olders
> are for a reference only.  To aid people with no RPM support in their
> systems I've unpacked the source package into the "mopd" directory.  Still
> you need to study the .spec file to figure how to build binaries.
>
>  Any feedback will be appreciated; I'm especially interested in reports
> from VAX users, as I've only been able to verify the operation booting
> Linux on a DECstation 5000 (i.e. MIPS) system.  Note: this version of mopd
> does not require switching devices into the PROMISC or ALLMULTI modes of
> operation.
>
>   Maciej
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
