Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id GAA22851
	for linuxmips-outgoing; Thu, 28 Oct 1999 06:56:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id GAA22848
	for <linuxmips@oss.sgi.com>; Thu, 28 Oct 1999 06:56:43 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA03104
	for <linuxmips@oss.sgi.com>; Thu, 28 Oct 1999 07:01:35 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA33926
	for linux-list;
	Thu, 28 Oct 1999 06:44:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA26084
	for <linux@engr.sgi.com>;
	Thu, 28 Oct 1999 06:44:54 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA5376191
	for <linux@engr.sgi.com>; Thu, 28 Oct 1999 06:44:46 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A2E1E7FE; Thu, 28 Oct 1999 15:44:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 24FFF902A; Thu, 28 Oct 1999 15:43:32 +0200 (CEST)
Date: Thu, 28 Oct 1999 15:43:32 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Cc: debian-mips@lists.debian.org, aj@suse.de
Subject: glibc build problems, mipsel glibc 2.0.7-981211
Message-ID: <19991028154332.A1971@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Hi,
i discover the following problems while trying to build the debian
glibc package from slink (2.0.7.981211 + mips patches)



/data/glibc/glibc-2.0.7.19981211/build-mipsel/time/zic -d
	/data/glibc/glibc-2.0.7.19981211/debian/install/usr/share/zoneinfo -L
	/dev/null -y ./yearistype africa

/data/glibc/glibc-2.0.7.19981211/build-mipsel/time/zic: error in loading
	shared libraries: undefined symbol: __deregister_frame_info

make[3]: *** [/data/glibc/glibc-2.0.7.19981211/debian/install/usr/share/zoneinfo/Africa/Algiers] Error 127
make[3]: Leaving directory `/data/glibc/glibc-2.0.7.19981211/time'
make[2]: *** [time/subdir_install] Error 2
make[2]: Leaving directory `/data/glibc/glibc-2.0.7.19981211'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/data/glibc/glibc-2.0.7.19981211/build-mipsel'
make: *** [stamp-build] Error 2


(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time# objdump --syms zic | grep dereg
0040d300       F *UND*  000000c4 __deregister_frame_info
(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time# objdump --syms ../libc.so | grep dereg
6009c96c g     F *ABS*  000000c4 __deregister_frame_info
6009ca30 g     F *ABS*  00000060 __deregister_frame

(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time# export
	LD_PRELOAD=/data/glibc/glibc-2.0.7.19981211/build-mipsel/libc.so

(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time#
	/data/glibc/glibc-2.0.7.19981211/build-mipsel/time/zic -d
	/data/glibc/glibc-2.0.7.19981211/debian/install/usr/share/zoneinfo -L
	/dev/null -y ./yearistype africa

/data/glibc/glibc-2.0.7.19981211/build-mipsel/time/zic: error in loading
							shared libraries

/data/glibc/glibc-2.0.7.19981211/build-mipsel/libc.so: undefined symbol:
							_dl_unload_cache

(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time# objdump
	--syms /data/glibc/glibc-2.0.7.19981211/build-mipsel/elf/ld.so.1 |
	grep dl_unload

0fb6977c g     F *ABS*  00000084 _dl_unload_cache


Ok - I found the symbol ... But .. LD_PRELOAD doesnt seem to help ...


(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time# objdump
	--syms /data/glibc/glibc-2.0.7.19981211/build-mipsel/elf/ld.so.1 |
	grep dl_unload

(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time# export
	LD_PRELOAD="/data/glibc/glibc-2.0.7.19981211/build-mipsel/elf/ld.so.1
	/data/glibc/glibc-2.0.7.19981211/build-mipsel/libc.so"

(root@repeat)/data/glibc/glibc-2.0.7.19981211/build-mipsel/time#
	/data/glibc/glibc-2.0.7.19981211/build-mipsel/time/zic -d
	/data/glibc/glibc-2.0.7.19981211/debian/install/usr/share/zoneinfo -L
	/dev/null -y ./yearistype africa

Segmentation fault


I am not sure if i am able to preload ld.so.1 - I suspect not ....

What do i do now ? Compile a "zic" whithout the dependency, 
build the package and replace the libc/ld.so ? This seems to be a little
risky.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
