Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 22:45:36 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:63382
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225255AbTEIVpd>; Fri, 9 May 2003 22:45:33 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19EFfr-00177q-00; Fri, 09 May 2003 23:45:03 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19EFfp-0005TO-00; Fri, 09 May 2003 23:45:01 +0200
Date: Fri, 9 May 2003 23:45:01 +0200
To: menkuec@auto-intern.com
Cc: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Message-ID: <20030509214501.GA18697@rembrandt.csv.ica.uni-stuttgart.de>
References: <200305092145.43690.benmen@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305092145.43690.benmen@gmx.de>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Benjamin Menküc wrote:
> Hi,
> 
> I cross-compiled binutils 2.13 and gcc-3.2.3 successfully for mips.
> 
> [benmen@linuxpc1 mipsel-glibc] LD_LIBRARY_PATH="" CFLAGS="-O2 -g 
> -finline-limit=10000" ../glibc-2.3.2/configure --build=i686-linux 
> --host=mipsel-linux --enable-add-ons --prefix=/home/benmen/mipsel

It also needs the headers of the already correctly configured
kernel, added by --with-headers=/path/to/linux/headers.


Thiemo
