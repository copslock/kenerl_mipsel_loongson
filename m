Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6H73G210676
	for linux-mips-outgoing; Tue, 17 Jul 2001 00:03:16 -0700
Received: from dea.waldorf-gmbh.de (u-83-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6H73CV10670
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 00:03:13 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6H3S9e01328;
	Tue, 17 Jul 2001 05:28:09 +0200
Date: Tue, 17 Jul 2001 05:28:09 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: SUCCESS: Booting a real 64bit Kernel on Indigo2 R10000 (IP28)
Message-ID: <20010717052809.A1319@bacchus.dhis.org>
References: <20010714193634.B24615@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010714193634.B24615@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Sat, Jul 14, 2001 at 07:36:34PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 14, 2001 at 07:36:34PM +0200, Thiemo Seufer wrote:

> - A real 64bit Kernel image without linker crashes etc.
>   No objcopy tricks, the Kernel is loaded at 0xa800000000000000.

Using the assembler in 32-bit mode results in better code also.  So
while I came up with the objcopy trick as a way to kludge around the
kernel bugs it has become the way of choice for the Origin.

  Ralf
