Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f79Co1V20501
	for linux-mips-outgoing; Thu, 9 Aug 2001 05:50:01 -0700
Received: from dea.waldorf-gmbh.de (u-217-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.217])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f79Cm0V20195
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 05:48:15 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f79C80620997;
	Thu, 9 Aug 2001 14:08:00 +0200
Date: Thu, 9 Aug 2001 14:08:00 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
Message-ID: <20010809140800.A20579@bacchus.dhis.org>
References: <20010808174142.F4452@rembrandt.csv.ica.uni-stuttgart.de> <Pine.SGI.4.33.0108081550070.24737-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.33.0108081550070.24737-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Wed, Aug 08, 2001 at 04:12:39PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 04:12:39PM -0400, J. Scott Kasten wrote:

>     100012b0:   ffc20028        sd      $v0,40($s8)
>     100012b4:   dfc20028        ld      $v0,40($s8)
>     100012b8:   3c030807        lui     $v1,0x807
>     100012bc:   34630605        ori     $v1,$v1,0x605
>     100012c0:   00031c38        dsll    $v1,$v1,0x10
>     100012c4:   34630403        ori     $v1,$v1,0x403
>     100012c8:   00031c38        dsll    $v1,$v1,0x10
>     100012cc:   34630201        ori     $v1,$v1,0x201
>     100012d0:   fc430000        sd      $v1,0($v0)
>     100012d4:   dfc20020        ld      $v0,32($s8)
>     100012d8:   64430001        daddiu  $v1,$v0,1
>     100012dc:   ffc30020        sd      $v1,32($s8)
>     100012e0:   dfc20028        ld      $v0,40($s8)
> 
> Ouch that's a painfull load.  It's interesting that in both cases, it
> effectively makes the constant load a 16 bit operation, does the math 64
> bit, and stores 64 bit.

With GP optimization something like the following would have been created:

	dla	$gp, _gp + $8000

	ld	$reg1, %gprel(var)($gp)
	daddiu	$reg1, $reg1, 1
	sd	$reg1, %gprel(var)($gp)

_gp:
var:	.word	0

Gas is lame.  MIPS/ELF gas is more.

  Ralf
