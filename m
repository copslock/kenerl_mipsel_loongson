Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7VK2hL27966
	for linux-mips-outgoing; Fri, 31 Aug 2001 13:02:43 -0700
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7VK2fd27963
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 13:02:41 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Fri, 31 Aug 2001 13:02:35 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from pc-ir003385 ([10.3.102.7]) by mon-irva-11.broadcom.com (
 8.9.1/8.9.1) with SMTP id NAA22386; Fri, 31 Aug 2001 13:02:39 -0700 (
 PDT)
From: "Ton Truong" <ttruong@broadcom.com>
To: "H . J . Lu" <hjl@lucon.org>, linux-gcc@vger.kernel.org,
   "Kenneth Albanowski" <kjahds@kjahds.com>, "Mat Hostetter" <mat@lcs.mit.edu>,
   "Andy Dougherty" <doughera@lafcol.lafayette.edu>,
   "Warner Losh" <imp@village.org>, linux-mips@oss.sgi.com,
   "Ron Guilmette" <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   "Ralf Baechle" <ralf@mailhost.uni-koblenz.de>,
   "Linas Vepstas" <linas@linas.org>,
   "Feher Janos" <aries@hal2000.terra.vein.hu>,
   "Leonard Zubkoff" <lnz@dandelion.com>, "Steven J. Hill" <sjhill@cotw.com>,
   "GNU C Library" <libc-alpha@sourceware.cygnus.com>, gcc@gcc.gnu.org
Subject: RE: The Linux binutils 2.11.90.0.31 is released.
Date: Fri, 31 Aug 2001 13:02:13 -0700
Message-ID: <003501c13257$d34e1d60$0766030a@pc-ir003385.broadcom.com>
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <20010831102248.A417@lucon.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
X-WSS-ID: 179132D1728752-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H.J.

Does this version of binutils support gprof?

Thanks In Advance

Ton Truong

> 
> This is the beta release of binutils 2.11.90.0.31 for Linux, which is
> based on binutils 2001 0830 in CVS on sourecware.cygnus.com plus
> various changes. It is purely for Linux.
> 
> The Linux/mips support is added. You have to use
> 
> # rpm --target=[mips|mipsel] -ta binutils-xx.xx.xx.xx.xx.tar.gz
> 
> to build it. Or you can read mips/README in the source tree to apply
> the mips patches and build it by hand.
> 
> FYI, the binutils man pages now are generated from the texinfo files
> during the build. As the result, those man pages may be changed for
> each build even if you only have done
> 
> # ..../configure ...
> # make
> 
> 
