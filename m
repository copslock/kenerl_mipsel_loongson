Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 13:22:53 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:41394 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133541AbWFPMWj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 13:22:39 +0100
Received: by ug-out-1314.google.com with SMTP id k3so1620445ugf
        for <linux-mips@linux-mips.org>; Fri, 16 Jun 2006 05:22:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QJbi/RCrZZUtVdxi4XLqyp0UATH4qEKlA4MtWL/Rs9Lxoscl/L2LmT/a4JsAsq7d21HIcRA2lbOk3ykTU55KTvN1VlCk98WqkEVKGHeFwefpmUoSpE+p4nrFXfcIlqTyRBCTgDy8L4+YEPEkKNWb33TeDNNCKvVXFOPbyJbz5xY=
Received: by 10.67.96.14 with SMTP id y14mr2686400ugl;
        Fri, 16 Jun 2006 05:22:37 -0700 (PDT)
Received: by 10.67.86.14 with HTTP; Fri, 16 Jun 2006 05:22:37 -0700 (PDT)
Message-ID: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
Date:	Fri, 16 Jun 2006 17:22:37 +0500
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: gcc-4.1.0 cross-compile for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
   I'm trying to cross compile gcc-4.1.0 for mipsel platform.Following
is the sequence of commands which i'm using.My host system is i686.

../gcc-4.1.0/configure --target=mipsel --without-headres
--prefix=/home/shahzad/install/ --with-newlib --enable-languages=c

make

But following error is generated

/home/shahzad/mips_gcc/./gcc/xgcc -B/home/shahzad/mips_gcc/./gcc/
-B/home/shahzad/install//mipsel/bin/
-B/home/shahzad/install//mipsel/lib/ -isystem
/home/shahzad/install//mipsel/include -isystem
/home/shahzad/install//mipsel/sys-include -DHAVE_CONFIG_H -I.
-I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT ssp.lo -MD -MP
-MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c -o ssp.o
../../../gcc-4.1.0/libssp/ssp.c:46:20: error: fcntl.h: No such file or directory
../../../gcc-4.1.0/libssp/ssp.c: In function '__guard_setup':
../../../gcc-4.1.0/libssp/ssp.c:70: warning: implicit declaration of
function 'open'
../../../gcc-4.1.0/libssp/ssp.c:70: error: 'O_RDONLY' undeclared
(first use in this function)
../../../gcc-4.1.0/libssp/ssp.c:70: error: (Each undeclared identifier
is reported only once
../../../gcc-4.1.0/libssp/ssp.c:70: error: for each function it appears in.)
../../../gcc-4.1.0/libssp/ssp.c:73: error: 'ssize_t' undeclared (first
use in this function)
../../../gcc-4.1.0/libssp/ssp.c:73: error: expected ';' before 'size'
.........................................
........................................

I'm using fedora 5 as development platform and version of gcc
installed on system is 4.1.0

thanks,
shahzad
