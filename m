Received:  by oss.sgi.com id <S553865AbRADVRp>;
	Thu, 4 Jan 2001 13:17:45 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:23218 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553716AbRADVR3>;
	Thu, 4 Jan 2001 13:17:29 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA22435;
	Thu, 4 Jan 2001 22:17:33 +0100 (MET)
Date:   Thu, 4 Jan 2001 22:17:33 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     John Van Horne <JohnVan.Horne@cosinecom.com>
cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: objcopy error -- was RE: your mail
In-Reply-To: <7EB7C6B62C4FD41196A80090279A29113D7356@exchsrv1.cosinecom.com>
Message-ID: <Pine.GSO.3.96.1010104220653.17873B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001, John Van Horne wrote:

> [jvhorne@guava-lx linux]$ make orionboot
> make -C arch/mips/orion orionboot
> make[1]: Entering directory
> `/dvlp/jvhorne/jvh_21_lx_mips_cross_test_sv/vobs/gpl/linux/arch/mips/orion'
> mips-linux-objcopy -Obinary --verbose ../../../vmlinux orion.nosym
> copy from ../../../vmlinux(elf32-bigmips) to orion.nosym(binary)
> BFD: Warning: Writing section `.app_header' to huge (ie negative) file
> offset 0x800fec30.
> BFD: Warning: Writing section `.text' to huge (ie negative) file offset
> 0x80100c30.
> BFD: Warning: Writing section `.fixup' to huge (ie negative) file offset
> 0x80236930.
> BFD: Warning: Writing section `.text.exit' to huge (ie negative) file offset
> 0x80237830.
> .
> .
> .
> mips-linux-objcopy: orion.nosym: File truncated
> 
> 
> Do you think that the reason objcopy fails is because it isn't treating
> the addresses as 32 bit addresses, or could it be something else?

 Note that the binary BFD target fills all "holes" with zeroes.  I suspect
one or more sections are placed at an offset lower than 0x80000000. 
Objcopy would have to make a huge file in this case and it gives up.  You
probably need to fix your linker script.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
