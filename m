Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Nov 2004 01:49:42 +0000 (GMT)
Received: from foothill.iad.idealab.com ([IPv6:::ffff:64.208.8.35]:30347 "EHLO
	foothill.iad.idealab.com") by linux-mips.org with ESMTP
	id <S8225255AbUKEBth> convert rfc822-to-8bit; Fri, 5 Nov 2004 01:49:37 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Compile Mips-Architecture on an i386?
Date: Thu, 4 Nov 2004 17:49:27 -0800
Message-ID: <BBB228F72FF00E4390479AC295FF4B350DE691@FOOTHILL.iad.idealab.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compile Mips-Architecture on an i386?
Thread-Index: AcTCtuG5MXT9SbvFRkiGyR5n6+BMlAAItowQ
From: "Joseph Chiu" <joseph@omnilux.net>
To: "Bruno Randolf" <bruno.randolf@4g-systems.biz>,
	<linux-mips@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

If you're doing it to get stuff done, a pre-built package (commercial or opensource) is the way to go.  But I also rebuilt my toolchain from scratch and learned immensely from it...

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Bruno Randolf
> Sent: Thursday, November 04, 2004 1:33 PM
> To: linux-mips@linux-mips.org
> Subject: Re: Compile Mips-Architecture on an i386?
> 
> 
> hi!
> 
> another option is to use the openembedded build system:
> 
> http://openembedded.org/oe_wiki/
> 
> it includes the cross-toolchain and has lots of packages 
> which you can 
> compile.
> 
> bruno
> 
> On Thursday 04 November 2004 14:19, Thomas Petazzoni wrote:
> > Hello,
> >
> > Hannes Bischof a écrit :
> > > What do I need to compile the software so that it runs 
> under the linux
> > > system of the router??
> >
> > You need a cross-compilation toolchain (that is a gcc, 
> binutils and libc
> > that runs on your i386, but that generates binaries for MIPS).
> >
> > Different tools are available to do that :
> >
> >   * Toolchain  : http://www.uclibc.org/toolchains.html
> >   * Crosstool  : http://kegel.com/crosstool/
> >   * Debian way : http://skaya.enix.org/wiki/ToolChain
> >
> > Thomas
> 
