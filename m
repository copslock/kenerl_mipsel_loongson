Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 16:00:46 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:2023 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225366AbTJVPAO>; Wed, 22 Oct 2003 16:00:14 +0100
Received: from lucon.org ([12.234.88.5])
          by comcast.net (sccrmhc13) with ESMTP
          id <2003102214595701600k9a72e>; Wed, 22 Oct 2003 14:59:57 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id E7E3F2C828; Wed, 22 Oct 2003 07:59:56 -0700 (PDT)
Date: Wed, 22 Oct 2003 07:59:56 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: Packages for RH 7.3/mips
Message-ID: <20031022145956.GA16117@lucon.org>
References: <3F964D7E.DF3EB883@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F964D7E.DF3EB883@niisi.msk.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

I no longer work on MIPS. I forward your email to the Linux mips
mailing list.


H.J.
---
On Wed, Oct 22, 2003 at 01:27:26PM +0400, Gleb O. Raiko wrote:
> Hello!
> 
> My team is extended your RedHat 7.3 distribution for big-endian mips.
> The work is done for our customer, but I, of course, would like to put
> them for the public access. The best way in my opinion is to merge those
> packages into your disribution for mips. Are you interesting?
> 
> Our goal was to get all packages cross compiled, so we have to patch
> several packages from your disribution. Also, we had to fix a few minor
> bugs.
> 
> We removed python and perl from package dependencies. (I personally hate
> both.) Our pam doesn't require cracklib.
> 
> The list of packages with some comments is below.
> 
> NEW PACKAGES
> 
> bind 9.2.0-8
> 	-Add Patch1000 to compiling gen.c by HOST_CC
> 	-Replace gcc by %{__cc} for compiling dns-keygen (%install section)
> chkfontpath 1.9.5-2
> 	- Add Patch (Makefile patch) to call install without -s option
> 	- Define CC=%{__cc} for cross compiling
> dev 3.3.1-4.1
> 	(SRPM is missed in your distribution. We just rebuild it form 7.3/ix86)
> dhcp 2.0pl5
> 	-Replace gcc by %{__cc} in %build section
> 	-Replace strip by %{__strip} in %install section
> kdebase 1.1.2-36
> 	- Fixed  g++-2.96 SIGSEGV on kdebase/kfm/kiojob.cpp:551 (enum type)
> 	- Fixed some headers problems
> 	- Fixed kdebase/po/ja/kcontrol.po unknown multibyte problem
> kdelibs 1.1.2-15.1
> 	- Removed overlaping msgid (for May ) in zh_CN.GB2312.po.
> 	- Fixed using /usr/bin/kdoc instead $SRC/kdoc/kdoc
> kdesupport 1.1.2-12.1
> 	-Replace strip by %{_strip}
> krb5 1.2.4-2
> 	-Tcl disabled. MIPS specific variables for crosscompiling added.
> lesstif 0.93.18-2
> 	-%define openmotif 0
> 	-Add Patch1000(configure patch) and Patch2000 (mwm/ Makefile.in)
> 	-Replace ./configure by %configure in SPEC file
> 	-Edit %install section to install files from mwm package properly
> libungif 4.1.0-10.2
> 	-Add strings in %build section for cross compiling:  
> 		  export ac_cv_func_setvbuf_reversed=no
> 		  export cross_compiling=yes
> 		  export ac_cv_prog_cc_cross=yes
> 		  export LIBS="-L/export/tools/mips-linux/lib $LIBS"
> openldap 2.0.23-5
> 	-cross compiling for mips added
> 	-removed requiring cyrus-sasl, cyrus-sasl-md5
> qt1x 1.45-3.3
> 	-Change moc architecture in producing rpm package
> qt 2.3.0-3
> 	-Add configuration files as sources and main Makefile for cross
> compiling
> 	-Compile moc for host system to  call it properly during build
> 	-Compile moc for mips architecture too to include in rpm package
> 	-Designer can't be compiled in cross
> 	-Replace strip by %{_strip}
> qt 3.0.3-12
> 	-Add patches for mips-linux cross platform to set correct parameters of
> compiling
> sendmail 8.11.6-15
> 	-Add Patch20000(redhat.config.m4) and Patch30000(header.m4) for cross
> compiling
> 	-Edit SPEC file for using  system makemap
> 	-Replace strip by %{__strip} in SPEC file
> wu-ftpd 2.6.2-5
> 	-Add Patch10 to set result of snprintf() checking to yes if cross
> compiling
> 	-Replace strip by %{__strip} in SPEC file
> X11R6-contrib 3.3.2-11
> 	Add patches (alloc patch and Imakefile patch) for mips cross compiling
> 
> ==============================================================================================
> FIXED PACKAGES
> (The packages below is from your distribution. We had to fix them.)
> 
> at-3.1.8-23.3.niisi.mips.rpm
> 	-Add patch to call install with no -s option in Makefile.in
> bash-2.05a-13.1.niisi.mips.rpm
> 	-Replace strip by %{__strip} in SPEC file
> 	-Add export ac_cv_func_setvbuf_reversed=yes in SPEC file because of
> ./configure call, not %configure
> bdflush-1.5-17.1.niisi.mips.rpm
> 	-Remove -s option in install call for bdflush
> binutils-2.13.90.0.16-1.niisi.mips.rpm
> 	-Replace strip by %{__strip} in SPEC file
> console-tools-19990829-40.1.niisi. mips.rpm
> 	-Replace strip by %{__strip} in SPEC file
> db3-3.3.11-6.2.niisi.mips.rpm
> 	-Rebuild with define '_without_tcl 1'
> 	-Add Patch to call autoheader without -all option in s_config script
> ftp-0.17-13.1.niisi.mips.rpm
> 	- Add patch for calling install with no -s option in ftp/Makefile
> gcc-2.96-113.2.niisi.mips.rpm
> libstdc++-2.96-113.2.niisi.mips.rpm
> cpp-2.96-113.2.niisi.mips.rpm
> 	-Replace %{_target_platform} by %{_target_alias} in SPEC file
> gdb-5.2.90-0.2.mips.rpm
> 	-Rebuild with "--define='_with_cross_compile 1'"
> hdparm-4.6-1.1.niisi.mips.rpm
> 	-Edit SPEC file for call install without -s option
> iproute-2.4.7-1.1.niisi.mips.rpm
> 	-Edit SPEC file for install call with no -s option
> 	-Add Patches to replace ar by mips-linux-ar in files lib/Makefile and
> tc/Makefile
> less-358-24.1.niisi.mips.rpm
> 	-Replace strip by %{__strip}
> libjpeg-6b-19.2.niisi.mips.rpm
> 	-Reconfigure in install section for correct /usr/lib path
> 	-Replace strip by %{__strip}
> libpng-1.0.14-0.7x.3.1.niisi.mips.rpm
> 	-Replace strip by %{__strip}
> libuser-0.50.2-1.1.mips.rpm
> 	-Rebuild with _without_python 1, _without_ldap 1 definitions.
> logrotate-3.6.4-1.1.niisi.mips.rpm
> 	-Add Patch1000 for install without -s option
> man-1.5j-6.1.niisi.mips.rpm
> 	-Replace in spec file strip by %{__strip}  
> mktemp-1.5-14.1.niisi.mips.rpm
> 	-Add Patch to call install without - s option
> modutils-2.4.18-3.7x.1.niisi.mips.rpm
> 	-Add option --disable-strip to all target %configure
> ncurses-5.2-26.1.niisi.mips.rpm
> 	-Replace strip by %{__strip} in SPEC file
> newt-0.50.35-1.1.niisi.mips.rpm
> 	-Edit spec for rebuilding without python
> 	-Add patch for using install without -s option
> pam-0.75-32.3.niisi.mips.rpm
> 	-Add new definiton: %define with_cracklib 0
> 	-Add 3 patches to build pam without cracklib:
> 		pam-configure-cross-mips-niisi.patch
> 		pam-configure-cross-sparc-niisi.patch
> 		pam-0.75-system-auth.patch
> passwd-0.67-1.1.niisi.mips.rpm
> 	- Replace strip by %{__strip}
> portmap-4.0-41.2.niisi.mips.rpm
> 	-Edit SPEC file for call install without -s option
> procps-2.0.7-12.1.niisi.mips.rpm
> 	-Add patches (Patch20000, Patch30000, Patch40000) for using install
> without --script option
> 	- Change some definition about python to rebuild without python
> psmisc-20.2-3.73.1.niisi.mips.rpm
> 	-Comment strings regarding to Patch10000 (gensig.sh-patch)
> rpm-4.0.4-7x.18.3.niisi.mips.rpm
> popt-1.6.4-7x.18.3.niisi.mips.rpm
> 	- Add export db_cv_mutex="Sparc/gcc-assembly" for sparc architecture
> 	-Add Patch20000 to call autoheader without -all option in s_config
> script
> 	- Change some definition about python to build without python
> sh-utils-2.0.11-14.1.mips.rpm
> 	-Replace strip by %{__strip}
> sysklogd-1.4.1-8.1.niisi.mips.rpm
> 	- Add patch (sysklogd-Makefile-cross-niisi.patch) for using install
> without -s option
> tar-1.13.25-4.7.1.niisi.mips.rpm
> 	- Replace strip by %{__strip} in SPEC file
> telnet-0.17-20.1.niisi.mips.rpm
> telnet-server-0.17-20.1.niisi.mips.rpm
> 	-Add Patches for using install without -s option:
> 	telnet-Makefile1-cross-niisi.patch
> 	telnet-Makefile2-cross-niisi.patch
> 	telnet-Makefile3-cross-niisi.patch
> 	telnet-GNUMakefile-cross-niisi.patch
> texinfo-4.1-1.1.niisi.mips.rpm
> info-4.1-1.1.niisi.mips.rpm
> 	-Replace strip by %{__strip}
> 	-Replace /usr/lib/rpm/brp-strip by /usr/lib/rpm/brp-strip-cross
> 	-Replace /usr/lib/rpm/brp-strip-comment-note by
> /usr/lib/rpm/brp-strip-comment-note-cross
> usermode-1.53-2.1.niisi.mips.rpm
> 	-Replace strip by %{__strip}
> XFree86 4.2.0-72.2.niisi
> 	-Replase XFree86-4.2.0-cross-niisi.patch by two patches for mips and
> sparc architectures
> 	-Add patches do define Sparcarchitecture in host.def file like
> XFree86-4.2.0-cross-mips.patch
> 	-Add patches (mips,sparc) for cross-compiling ttmkfdir
> ==============================================================================================
> 
> Also, we created packages for locales and timezones. The only packages
> we have to build on a native mips box.
> 
> Finally, we implement a script that generates packages required for
> cross compilation. It takes .mips.rpm and generates
> mips-linux-.noarch.rpm. For exmaple, zlib-1.1.3-25.7.1.mips.rpm and
> zlib-devel-1.1.3-25.7.1.mips.rpm are repackaged to
> mips-linux-zlib-1.1.3-25.7.1.noarch.rpm. All dependencies are kept.
> 
> Regards,
> Gleb.
