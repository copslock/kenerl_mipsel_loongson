Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77E8LC19390
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:08:21 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77E8HV19387
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:08:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA08059;
	Tue, 7 Aug 2001 16:10:11 +0200 (MET DST)
Date: Tue, 7 Aug 2001 16:10:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: linux-mips@oss.sgi.com
Subject: Re: cross-mipsel-linux-ld --prefix library path
In-Reply-To: <074001c11ef4$fdbd7530$3501010a@ltc.com>
Message-ID: <Pine.GSO.3.96.1010807160731.3289D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 6 Aug 2001, Bradley D. LaRonde wrote:

> When I build and install cross-binutils (on Debian 2.2) like this:
> 
>   tar -xzf binutils-2.11.2.tar.gz
>   mkdir mipsel-binutils
>   cd mipsel-binutils
>   ../binutils-2.11.2/configure --target=mipsel-linux \
>     --prefix=/usr/mipsel-linux
>   make
>   make install
> 
> it seems the resulting mipsel-linux-ld wants to look in:
> 
>     /usr/mipsel-linux/mipsel-linux/lib
> 
> for crt1.o, crti.o, libc.*, etc.

 You don't need to specify "--prefix=/usr/mipsel-linux" for building
cross-binutils.  The scripts will add the target alias automatically for
files that need it -- if you look at the scripts,
"${prefix}/${target_alias}" is the so called "tooldir". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
