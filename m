Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 09:58:21 +0000 (GMT)
Received: from apollo.ext.eurgw.xerox.com ([IPv6:::ffff:13.16.138.21]:7834
	"EHLO apollo.eurgw.xerox.com") by linux-mips.org with ESMTP
	id <S8224985AbUCEJ6U>; Fri, 5 Mar 2004 09:58:20 +0000
Received: from eurodns2.eur.xerox.com (eurodns2.eur.xerox.com [13.202.66.10])
	by apollo.eurgw.xerox.com (8.12.9-20030917/8.12.9) with ESMTP id i259wDIj018018
	for <linux-mips@linux-mips.org>; Fri, 5 Mar 2004 09:58:13 GMT
Received: from eurdubmg02.eur.xerox.com (eurdubmg02.eur.xerox.com [13.202.65.254])
	by eurodns2.eur.xerox.com (8.12.9/8.12.9) with ESMTP id i259wC0a023143
	for <linux-mips@linux-mips.org>; Fri, 5 Mar 2004 09:58:12 GMT
Received: from eurgbrbh02.emeacinops.xerox.com (unverified) by eurdubmg02.eur.xerox.com
 (Content Technologies SMTPRS 4.2.10) with ESMTP id <T6826de21600dca41feba0@eurdubmg02.eur.xerox.com>;
 Fri, 5 Mar 2004 09:58:10 +0000
Received: from gbrwgcbh01.wgc.gbr.xerox.com ([13.200.2.175]) by eurgbrbh02.emeacinops.xerox.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id GJQQ9WA6; Fri, 5 Mar 2004 09:58:10 -0000
Received: by gbrwgcbh01.wgc.gbr.xerox.com with Internet Mail Service (5.5.2657.72)
	id <FW23J7HG>; Fri, 5 Mar 2004 10:00:05 -0000
Message-ID: <8EAC52A94CD8D411A01000805FBB37760615AFA0@gbrwgcms02.wgc.gbr.xerox.com>
From: "Hamilton, Ian" <Ian.Hamilton@gbr.xerox.com>
To: "'gcc-help@gcc.gnu.org'" <gcc-help@gcc.gnu.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: Problems with MIPS cross compiler/linker
Date: Fri, 5 Mar 2004 09:59:58 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Ian.Hamilton@gbr.xerox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Hamilton@gbr.xerox.com
Precedence: bulk
X-list: linux-mips

Here are some details that I missed off my original post:

The GCC version is 3.3.2, and is hosted on Sun/Solaris (version 5.8).

My linker script is like this:


/*========================================================================
  |                    armada linker command file                 
  ========================================================================
  |                                                                    
  | Description:                                                        
  |   This is the linker command file for armada                      
  |                                                                     
  | Revisions:               
  |   10/10'03  ICH initial armada setups                             
  |                                                                     
  ========================================================================*/

/* OUTPUT_FORMAT("elf32-bigmips", "elf-bigmips", "elf-littlemips") */

OUTPUT_ARCH(mips)

/**** Start point ****/
ENTRY(start)

SECTIONS
{
  .text 0xA0100000 :
  {
    *(.text)
    *(.gnu.linkonce.t*)
    _ecode = ABSOLUTE(.) ;	/* End of code 			    */
    *(.rodata) 
    *(.gnu.linkonce.r*)

    . = ALIGN(8);
    _etext = ABSOLUTE(.);	/* End of code and read-only data   */
  }

  /**** Initialised data ****/
  .data :
  {
    _fdata = ABSOLUTE(.);	/* Start of initialised data	    */
    *(.data)
   
    . = ALIGN(8);

    _gp = ABSOLUTE(. + 0x7ff0); /* point at middle (32Kbytes) of 64Kbyte
initialized data		    */

    *(.lit8) 
    *(.lit4) 
    *(.ctors)
    *(.dtors)
    *(.got.plt)
    *(.got)
    *(.dynamic)
    *(.sdata) 
    *(.gnu.linkonce.s*)
    
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
  PROVIDE (__stacktop = 0xa02fff00);
}
