Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PB4snC007948
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 04:04:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PB4sW9007947
	for linux-mips-outgoing; Tue, 25 Jun 2002 04:04:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtwse201.detewe.de ([195.50.171.201])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PB3mnC007942
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 04:03:59 -0700
Received: from zinse043.detewe.de (unverified) by dtwse201.detewe.de
 (Content Technologies SMTPRS 4.2.5) with ESMTP id <T5bb3cce505c332abc90df@dtwse201.detewe.de> for <linux-mips@oss.sgi.com>;
 Tue, 25 Jun 2002 13:09:33 +0200
Received: from detewe.de ([172.30.201.153]) by zinse043.detewe.de
          (Netscape Messaging Server 3.6)  with ESMTP id AAA1348;
          Tue, 25 Jun 2002 13:05:36 +0200
Message-ID: <3D184EAC.D8C8CBA6@detewe.de>
Date: Tue, 25 Jun 2002 13:06:20 +0200
From: Carsten Lange <Carsten.Lange@detewe.de>
X-Mailer: Mozilla 4.5 [en] (X11; I; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Daniel Jacobowitz <dan@debian.org>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str 
 section
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org> <20020624081221.C30482@lucon.org>
Content-Type: multipart/mixed; boundary="------------4E8576234784E74CD2CBC2A8"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------4E8576234784E74CD2CBC2A8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

when I use binutils 2.12.90.0.12 gcc 3.1 will not compile anymore.

The error is:

...
mkdir libgcc
if [ -f stmp-dirs ]; then true; else touch stmp-dirs; fi
/opt/cross/production/build/gcc/gcc/xgcc -B/opt/cross/production/build/gcc/gcc/
-B/opt/cross/mipsel-linux/mipsel-linux/bin/ -B/opt/cross/mipsel-linux/mipsel-linux/lib/ -isystem
/opt/cross/mipsel-linux/mipsel-linux/include -O2  -DIN_GCC -DCROSS_COMPILE   -W -Wall -Wwrite-strings
-Wstrict-prototypes -Wmissing-prototypes -isystem ./include  -fPIC -g  -DIN_LIBGCC2
-D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc -I. -I. -I/opt/cross/production/src/gcc-3.1/gcc
-I/opt/cross/production/src/gcc-3.1/gcc/. -I/opt/cross/production/src/gcc-3.1/gcc/config
-I/opt/cross/production/src/gcc-3.1/gcc/../include  -DL_muldi3 -c
/opt/cross/production/src/gcc-3.1/gcc/libgcc2.c -o libgcc/./_muldi3.o
/tmp/ccPEIznf.s: Assembler messages:
/tmp/ccPEIznf.s:5: Error: file number 1 already allocated
make[2]: *** [libgcc/./_muldi3.o] Error 1
make[2]: Leaving directory `/opt/cross/production/build/gcc/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory `/opt/cross/production/build/gcc/gcc'
make: *** [all-gcc] Error 2                                  
...

Building the toolchain works fine with binutils-2.12.1.

I attach 2 files (the build_mips_toolchain and mipsel-linux.source) which I use to build the tools
from scratch on my linux i586 box.
Any program build with this toolchain cannot be opened with gdb. 

What are the recommended versions of gcc, glibc and gdb?

Many thanks 
	Carsten



"H. J. Lu" wrote:
> 
> On Mon, Jun 24, 2002 at 11:00:01AM -0400, Daniel Jacobowitz wrote:
> > On Mon, Jun 24, 2002 at 03:29:47PM +0200, Carsten Lange wrote:
> > > Hi,
> > >
> > > I get the above error from gdb 5.2 when using the <file> command.
> > > ...
> > > (gdb) file iprbs
> > > file iprbs
> > > Reading symbols from iprbs...DW_FORM_strp pointing outside of .debug_str section
> > > (gdb)
> > > ...
> > >
> > > My mipsel-linux- toolchain consist of the following packages:
> > >     binutils-2.12.1
> > >     gcc-3.1
> > >     glibc-2.2.5
> > >     gdb-5.2
> > >
> > > I have no idea what the problem might be.
> > >
> > > Any hints (solutions/workaround) are welcome.
> >
> > Can you produce a testcase?  These versions of the tools should not
> > show the problem, assuming you rebuilt everything using them.
> >
> 
> Please get the Linux binutils 2.12.90.0.12. You need that for gcc 3.1
> on Linux/mips.
> 
> H.J.
--------------4E8576234784E74CD2CBC2A8
Content-Type: text/plain; charset=us-ascii;
 name="build_mips_toolschain"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build_mips_toolschain"

#!/bin/sh

if [ "x$1" == "x" ]
then
echo "usage: $0 <file_to_get_config_from>"
exit 1
fi
 
if [ -f ${1}.source ]
then
. ${1}.source
else
echo "usage: $0 <file_to_get_config_from>"
exit 1
fi           


execute()
{
        echo "+++++++++++++++++++++++++++ $@ "
        echo "+++++++++++++++++++++++++++ $@ " >> $LOGFILE 2>&1
        $@ >> $LOGFILE 2>&1
        if [ ! $? = 0 ]
        then
                echo "$@ FAILED!"
                exit 1
	fi
}

execute_patch()
{
        echo "+ patch $1 -s < $2"
        if [ -f $2 ]
        then
                pkgpatch $1 -s < $2
                if [ ! $? = 0 ]
                then
                        echo "patch $1 -s < $2 FAILED!"
                        exit 1
                fi
        else
                echo "Patchfile $2 not found!"
                exit 1
        fi
}

#cleanup
execute rm -rf $BUILD
execute mkdir -p $BUILD
execute rm -rf $SRC
execute mkdir -p $SRC


#
#
# BINUTILS

if [ ! -f ${PREFIX}/binutils-${BINUTILS_V} ] ; then
execute cd $SRC
#execute tar xzf $PKG/binutils-${BINUTILS_V}.tar.gz
execute tar xjf $PKG/binutils-${BINUTILS_V}.tar.bz2
execute cd $BUILD
execute mkdir binutils
execute cd binutils
execute $SRC/binutils-${BINUTILS_V}/configure \
			--target=${TARGET} \
			--prefix=${PREFIX}
execute make
execute make install
execute rm -rf $SRC/binutils-${BINUTILS_V}
execute rm -rf $BUILD/binutils
execute touch ${PREFIX}/binutils-${BINUTILS_V}
fi
#
#
# INCLUDE FILES
#execute rm -rf ${PREFIX}/target
#execute mkdir -p ${PREFIX}/target/include

#execute cd /opt/cross/devel/ip_rbs/linux/include
#execute tar cf /tmp/${TARGET}_include . 
#execute cd ${PREFIX}/target/usr/include
#execute tar xf /tmp/${TARGET}_include

#execute ln -sf /opt/cross/devel/ip_rbs/linux/include/asm ${PREFIX}/target/include/asm
#execute ln -sf /opt/cross/devel/ip_rbs/linux/include/linux ${PREFIX}/target/include/linux

# GCC
if [ ! -f ${PREFIX}/gcc-${GCC_V}_step1 ]  ; then
execute cd $SRC
execute tar xzf $PKG/gcc-${GCC_V}.tar.gz
execute cd $BUILD
execute mkdir gcc
execute cd gcc
execute $SRC/gcc-${GCC_V}/configure \
			--target=${TARGET} \
			--prefix=${PREFIX} \
			--enable-languages=c \
			--disable-shared \
			--with-newlib \
			--with-headers=${HEADERS}
execute make
execute make install
execute touch ${PREFIX}/gcc-${GCC_V}_step1
fi
#
#
# GLIBC
if [ ! -f ${PREFIX}/glibc-${GLIBC_V} ]  ; then
execute cd $SRC
execute tar xzf $PKG/glibc-${GLIBC_V}.tar.gz
execute cd glibc-${GLIBC_V}
execute tar xzf $PKG/glibc-linuxthreads-${GLIBC_V}.tar.gz
execute cd $BUILD
execute mkdir glibc
execute cd glibc
execute $SRC/glibc-${GLIBC_V}/configure  \
			--build=i686-linux \
			--host=${TARGET} \
			--enable-add-ons \
			--disable-sanity-checks \
			--prefix=${PREFIX}/${TARGTET}
execute make
execute make install
execute touch ${PREFIX}/glibc-${GLIBC_V}
fi

#
#
# GCC again
if [ ! -f ${PREFIX}/gcc-${GCC_V} ] ; then
execute cd $BUILD
execute cd gcc
execute $SRC/gcc-${GCC_V}/configure \
			--target=${TARGET} \
			--prefix=${PREFIX} \
			--enable-languages=c,c++ \
			--with-libs=${PREFIX}/${TARGTET}/lib \
			--with-headers=${HEADERS}
execute make
execute make install
execute touch ${PREFIX}/gcc-${GCC_V}
fi




#
#
# GDB
if [ ! -f ${PREFIX}/gdb-${GDB_V} ] ; then
execute cd $SRC
execute execute tar xzf $PKG/gdb-${GDB_V}.tar.gz 
execute cd $BUILD
execute mkdir -p gdb
execute cd gdb
execute $SRC/gdb-${GDB_V}/configure \
                        --target=${TARGET} \
                        --prefix=${PREFIX}
execute make
execute make install 
execute touch ${PREFIX}/gdb-${GDB_V}
fi



#
#
# GDB SERVER
if [ ! -f ${PREFIX}/gdbserver-${GDB_V} ] ; then
execute mkdir -p $BUILD/gdbserver
execute cd $BUILD
execute cd gdbserver
execute chmod u+x $SRC/gdb-${GDB_V}/gdb/gdbserver/configure
export CC=mipsel-linux-gcc
execute $SRC/gdb-${GDB_V}/gdb/gdbserver/configure \
                        --target=${TARGET} \
                        --prefix=${PREFIX}
execute make
execute make install 
execute touch ${PREFIX}/gdbserver-${GDB_V}
fi



execute echo "############ DONE ############"

--------------4E8576234784E74CD2CBC2A8
Content-Type: text/plain; charset=us-ascii;
 name="mipsel-linux.source"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mipsel-linux.source"


# TARGET
TARGET=mipsel-linux
HEADERS=/opt/cross/devel/ip_rbs/linux/include

# VERSIONS

#BINUTILS_V="2.12.90.0.12"
BINUTILS_V="2.12.1"
GCC_V="3.1"
GLIBC_V="2.2.5"

INSIGHT_V="5.1.1"
GDB_V="5.2"

DDD_V="3.3.1"

# CONFIGURATION

CROSSROOT=/opt/cross
BASEDIR=$CROSSROOT/production

PREFIX=$CROSSROOT/${TARGET}

BUILD=$BASEDIR/build
SRC=$BASEDIR/src
PKG=$BASEDIR/pkg
LOGDIR=$BASEDIR/log
LOGFILE=$LOGDIR/${0}_`date +%d%m%Y`_`date +%H%M`.log

# PATH
PATH="$PREFIX/bin:$HOSTPREFIX/bin:$PATH"
export PATH    


echo "LOGFILE is ${LOGFILE}"

--------------4E8576234784E74CD2CBC2A8
Content-Type: text/x-vcard; charset=us-ascii;
 name="Carsten.Lange.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Carsten Lange
Content-Disposition: attachment;
 filename="Carsten.Lange.vcf"

begin:vcard 
n:Lange;Carsten
tel;fax:+49 6104 4234
tel;work:+49 30 6104 4228
x-mozilla-html:FALSE
url:http://www.detewe.de
org:Cordless Technology A/S Berlin
adr:;;Koepenicker Str. 180;10997 Berlin;;;
version:2.1
email;internet:Carsten.Lange@detewe.de
x-mozilla-cpt:;0
fn:Carsten Lange
end:vcard

--------------4E8576234784E74CD2CBC2A8--
