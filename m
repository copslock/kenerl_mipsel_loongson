Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 10:45:57 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:49676 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021356AbXGFJpx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 10:45:53 +0100
Received: (qmail 28516 invoked by uid 1000); 6 Jul 2007 11:44:51 +0200
Date:	Fri, 6 Jul 2007 11:44:51 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	saravanan <sar_van81@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
Subject: Re: error in crosscompiling autoboot for MIPS
Message-ID: <20070706094451.GB27044@roarinelk.homelinux.net>
References: <357682.93280.qm@web94306.mail.in2.yahoo.com> <20070706092718.GA27044@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070706092718.GA27044@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri, Jul 06, 2007 at 11:27:18AM +0200, Manuel Lauss wrote:
> On Fri, Jul 06, 2007 at 10:05:41AM +0100, saravanan wrote:
> > hi,
> >  
> >  i download(au1xxx-booter-src-1.0-r000007.tar.gz ) an tried to cross compile for MIPS DBAU1200 board, but was nto succesfull. i used to toolchain created using buildroot. the following is the error message i got:
> >  
> >  Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/sd.o
> >       Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/booter.o
> >       Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec
> >  /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: section .data [000000009fd08778 -> 000000009fd08807] overlaps section .MIPS.stubs [000000009fd08778 -> 000000009fd08787]
> >  /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec.elf: The first section in the PT_DYNAMIC segment is not the .dynamic section
> >  /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: final link failed: Bad value
> >  make[3]: *** [/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec] Error 1
> >  rm /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/fat.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/flash.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/booter.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/partition.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/filesystem.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/sd.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/srec.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/bin.o
> >  /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/elf.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/util.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/functions.o
> >  make[3]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter'
> >  make[2]: *** [all] Error 2
> >  make[2]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications'
> >  make[1]: *** [apps] Error 2
> >  make[1]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07'
> >  make: *** [all] Error 2
> >  linux:/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07 # ..
> >  linux:/home/LINUXAU1200/autobootloader #
> >  
> >  
> >  i think there is memory range overlapping between the two sections.
> >  
> >  can anyone suggest me any solution or suggestion for this ?
> 
> That codebase can _only_ be compiled with AMD's gcc-3.4.3 for cygwin (can be
> found on the CD you get with the DB1200 board). It does not work with any
> other toolchain, unfortunately (yes, I tried a few, from 3.3.0 to 4.1.2
> with binutils from 2.15 to 2.17)

Please disregard the above and try this updated linkscript
(applications/booter/booter.ld). With this the booter source
builds fine here:

<<< -- snip -- >>>

INPUT(-lau1x00)

OUTPUT_ARCH(mips)

ENTRY(start)

/**** Start point ****/

SECTIONS
{
  .text 0x9FD00000 :
  {
  	*(.init)
    *(.text)
    _ecode = ABSOLUTE(.) ;	/* End of code 			    */
	
	*(.rodata)
	*(.rodata.str1.4)
	*(.rodata.cst8)
	*(.rodata.cst4)

     . = ALIGN(8);
    _etext = ABSOLUTE(.);	/* End of code and read-only data   */
  }

  /**** Initialised data ****/
  .data 0x81000000 :
	 AT ( ADDR(.text) + SIZEOF(.text) )
  {
    _data = ABSOLUTE(.);	/* Start of initialised data	    */
    _data_actual = ADDR(.text) + SIZEOF(.text);	/* Actual location of data segment */

    *(.data)
	*(.data.rel.local)
	*(.data.rel.ro.local)
	*(.data.rel)
	
	. = ALIGN(8);

    _gp = ABSOLUTE(. + 0x7ff0); /* point at middle (32Kbytes) of 64Kbyte initialized data		    */

    *(.lit8)
    *(.lit4)
    *(.sdata)

    . = ALIGN(8);

    _edata  = ABSOLUTE(.);	/* End of initialised data	    */
  }

  /**** Uninitialised data ****/

  _fbss = .;			/* Start of unitialised data	    */

  .sbss :
  {
    *(.sbss)
    *(.scommon)
  }
  .bss :
  {
    *(.bss)
    *(COMMON)
  }

  _end = . ;		/* End of unitialised data	    */

  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }

  /DISCARD/ :
  {
    *(.reginfo)
  }

  PROVIDE(etext = _etext);
  PROVIDE (edata = .);
  PROVIDE (end = .);
/*  PROVIDE (__stacktop = 0x80100000);*/
  PROVIDE (__stacktop = _end + 0x010000);
}
