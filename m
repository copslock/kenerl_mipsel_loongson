Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f773ssP22882
	for linux-mips-outgoing; Mon, 6 Aug 2001 20:54:54 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f773soV22877
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 20:54:51 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP id D24A6590AC
	for <linux-mips@oss.sgi.com>; Mon,  6 Aug 2001 23:52:19 -0400 (EDT)
Message-ID: <074001c11ef4$fdbd7530$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <linux-mips@oss.sgi.com>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de> <997108890.1773.22.camel@ghostwheel.cygnus.com> <20010806082904.C15666@lucon.org> <997112036.2480.14.camel@ghostwheel.cygnus.com> <20010806083942.A16047@lucon.org>
Subject: cross-mipsel-linux-ld --prefix library path
Date: Mon, 6 Aug 2001 23:56:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When I build and install cross-binutils (on Debian 2.2) like this:

  tar -xzf binutils-2.11.2.tar.gz
  mkdir mipsel-binutils
  cd mipsel-binutils
  ../binutils-2.11.2/configure --target=mipsel-linux \
    --prefix=/usr/mipsel-linux
  make
  make install

it seems the resulting mipsel-linux-ld wants to look in:

    /usr/mipsel-linux/mipsel-linux/lib

for crt1.o, crti.o, libc.*, etc.

However, a cross-built glibc like:

  tar -xzf glibc-2.2.3
  cd glibc-2.2.3
  patch -p1 -i../elf32-tradlittlemips.diff
  tar -xzf ../glibc-linuxthreads-2.2.3.tar.gz
  cd ..
  mkdir mipsel-glibc
  cd mipsel-glibc
  ../glibc-2.2.3/configure --build=i686-linux \
    --host=mipsel-linux --prefix=/usr/mipsel-linux \
    --with-headers=/usr/mipsel-linux/include --enable-add-ons
  make
  make install

puts it's stuff in:

    /usr/mipsel-linux/lib/

not:

    /usr/mipsel-linux/mipsel-linux/lib/

My first suspicion is that --prefix=/usr/mipsel-linux for binutils
is naive, but --prefix=/usr looks like a disaster (would overwrite
native stuff like libbfd.la for example, whatever that is).

Another odd thing is that binutils installs:

    /usr/mipsel-linux/bin/mipsel-linux-ld

and an identical copy at:

    /usr/mipsel-linux/mipsel-linux/bin/ld

This seems like a Clue.  If fact, the whole
/usr/mipsel-linux/mipsel-linux thing seems off to me.  Only, being
only an RTN (Reluctant Toolchain Neophyte), that's about as far as
I've gotten with it.

Analysis (of the software, not me)?  :-)

Regards,
Brad
