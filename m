Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2002 18:24:34 +0100 (CET)
Received: from p508B7C3B.dip.t-dialin.net ([80.139.124.59]:40883 "EHLO
	p508B7C3B.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKDRYe>; Mon, 4 Nov 2002 18:24:34 +0100
Received: from rwcrmhc51.attbi.com ([IPv6:::ffff:204.127.198.38]:42675 "EHLO
	rwcrmhc51.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSKDRYT>; Mon, 4 Nov 2002 18:24:19 +0100
Received: from lucon.org ([12.234.88.146]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021104172413.UVSK14374.rwcrmhc51.attbi.com@lucon.org>;
          Mon, 4 Nov 2002 17:24:13 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 24EEB2C4EC; Mon,  4 Nov 2002 09:24:13 -0800 (PST)
Date: Mon, 4 Nov 2002 09:24:13 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021104092413.C10646@lucon.org>
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <20021104070233.C8860@lucon.org> <3DC6A6E7.6000107@realitydiluted.com> <20021104091119.A10646@lucon.org> <3DC6AB62.7000603@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC6AB62.7000603@realitydiluted.com>; from sjhill@realitydiluted.com on Mon, Nov 04, 2002 at 11:16:18AM -0600
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 04, 2002 at 11:16:18AM -0600, Steven J. Hill wrote:
> H. J. Lu wrote:
> >>
> >>Fine. Still, that doesn't solve the problem, or what I perceive to
> >>be a problem. I'll submit my patch and watch it be ignored or for
> >>someone to say something.
> > 
> > 
> > The Linux binutils works fine for me.
> > 
> Really? Good. Go get this tarball:
> 
>      ftp://ftp.realitydiluted.com/Linux/MIPS/zlib-1.1.4-mips-prob.tar.bz2
> 
> make sure your tools are in your path and just do 'make' and see
> what ISA your 'libz.so.1.1.4' is. Thanks.
> 

# readelf -h libz.so.1.1.4
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x14d0
  Start of program headers:          52 (bytes into file)
  Start of section headers:          66196 (bytes into file)
  Flags:                             0x10000003, noreorder, pic, mips2
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         4
  Size of section headers:           40 (bytes)
  Number of section headers:         25
  Section header string table index: 22

H.J.
