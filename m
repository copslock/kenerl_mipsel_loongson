Received:  by oss.sgi.com id <S553699AbRADULG>;
	Thu, 4 Jan 2001 12:11:06 -0800
Received: from mail.cosinecom.com ([63.88.104.16]:36869 "EHLO
        exchsrv1.cosinecom.com") by oss.sgi.com with ESMTP
	id <S553688AbRADUKg>; Thu, 4 Jan 2001 12:10:36 -0800
Received: by exchsrv1.cosinecom.com with Internet Mail Service (5.5.2650.21)
	id <Y4YLX5MZ>; Thu, 4 Jan 2001 12:08:26 -0800
Message-ID: <7EB7C6B62C4FD41196A80090279A29113D7356@exchsrv1.cosinecom.com>
From:   John Van Horne <JohnVan.Horne@cosinecom.com>
To:     "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: objcopy error -- was RE: your mail
Date:   Thu, 4 Jan 2001 12:08:25 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C0768A.18471550"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C0768A.18471550
Content-Type: text/plain;
	charset="iso-8859-1"

Is there anyway to get more information out of objcopy?  When I run it,
I get the warnings I mentioned before, but no errors, however the target
file is empty.  Here is an abridged copy of what I get:

[jvhorne@guava-lx linux]$ make orionboot
make -C arch/mips/orion orionboot
make[1]: Entering directory
`/dvlp/jvhorne/jvh_21_lx_mips_cross_test_sv/vobs/gpl/linux/arch/mips/orion'
mips-linux-objcopy -Obinary --verbose ../../../vmlinux orion.nosym
copy from ../../../vmlinux(elf32-bigmips) to orion.nosym(binary)
BFD: Warning: Writing section `.app_header' to huge (ie negative) file
offset 0x800fec30.
BFD: Warning: Writing section `.text' to huge (ie negative) file offset
0x80100c30.
BFD: Warning: Writing section `.fixup' to huge (ie negative) file offset
0x80236930.
BFD: Warning: Writing section `.text.exit' to huge (ie negative) file offset
0x80237830.
.
.
.
mips-linux-objcopy: orion.nosym: File truncated


Do you think that the reason objcopy fails is because it isn't treating
the addresses as 32 bit addresses, or could it be something else?

Thanks,
-John


-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
Sent: Thursday, January 04, 2001 8:23 AM
To: Ralf Baechle
Cc: John Van Horne; 'linux-mips@oss.sgi.com'; 'wesolows@foobazco.org'
Subject: Re: your mail


On Thu, 4 Jan 2001, Ralf Baechle wrote:

> > I see that our start address of 0x80102584 has been turned into
> > 0xffffffff80102584. I'm thinking that
> > I need to tell ld something to stop it from doing this. Any ideas?
> 
> That's be ok.  32-bit MIPS addresses are sign-extended into 64-bit
addresses.
> Older binutils used to zero-extend addresses which was broken.  So what
> you observe is actually the sympthom of a bug that got fixed.

 I'm not sure that's the best solution, I'm afraid.  For elf32-mips
addresses should be 32-bit and not 64-bit.  It would be consistent with
other 32-bit platforms, it would make interoperability easier (ksymoops
cannot make use of System.map to grok kernel oopses which provide 32-bit
addresses) and it would make objdump outputs more readable.

 Fixing this problem with BFD is on my to do list (but has a low priority
assigned). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

------_=_NextPart_001_01C0768A.18471550
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2652.35">
<TITLE>objcopy error -- was RE: your mail</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>Is there anyway to get more information out of objcopy?&nbsp; When I run it,</FONT>
<BR><FONT SIZE=2>I get the warnings I mentioned before, but no errors, however the target</FONT>
<BR><FONT SIZE=2>file is empty.&nbsp; Here is an abridged copy of what I get:</FONT>
</P>

<P><FONT SIZE=2>[jvhorne@guava-lx linux]$ make orionboot</FONT>
<BR><FONT SIZE=2>make -C arch/mips/orion orionboot</FONT>
<BR><FONT SIZE=2>make[1]: Entering directory `/dvlp/jvhorne/jvh_21_lx_mips_cross_test_sv/vobs/gpl/linux/arch/mips/orion'</FONT>
<BR><FONT SIZE=2>mips-linux-objcopy -Obinary --verbose ../../../vmlinux orion.nosym</FONT>
<BR><FONT SIZE=2>copy from ../../../vmlinux(elf32-bigmips) to orion.nosym(binary)</FONT>
<BR><FONT SIZE=2>BFD: Warning: Writing section `.app_header' to huge (ie negative) file offset 0x800fec30.</FONT>
<BR><FONT SIZE=2>BFD: Warning: Writing section `.text' to huge (ie negative) file offset 0x80100c30.</FONT>
<BR><FONT SIZE=2>BFD: Warning: Writing section `.fixup' to huge (ie negative) file offset 0x80236930.</FONT>
<BR><FONT SIZE=2>BFD: Warning: Writing section `.text.exit' to huge (ie negative) file offset 0x80237830.</FONT>
<BR><FONT SIZE=2>.</FONT>
<BR><FONT SIZE=2>.</FONT>
<BR><FONT SIZE=2>.</FONT>
<BR><FONT SIZE=2>mips-linux-objcopy: orion.nosym: File truncated</FONT>
</P>
<BR>

<P><FONT SIZE=2>Do you think that the reason objcopy fails is because it isn't treating</FONT>
<BR><FONT SIZE=2>the addresses as 32 bit addresses, or could it be something else?</FONT>
</P>

<P><FONT SIZE=2>Thanks,</FONT>
<BR><FONT SIZE=2>-John</FONT>
</P>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Maciej W. Rozycki [<A HREF="mailto:macro@ds2.pg.gda.pl">mailto:macro@ds2.pg.gda.pl</A>]</FONT>
<BR><FONT SIZE=2>Sent: Thursday, January 04, 2001 8:23 AM</FONT>
<BR><FONT SIZE=2>To: Ralf Baechle</FONT>
<BR><FONT SIZE=2>Cc: John Van Horne; 'linux-mips@oss.sgi.com'; 'wesolows@foobazco.org'</FONT>
<BR><FONT SIZE=2>Subject: Re: your mail</FONT>
</P>
<BR>

<P><FONT SIZE=2>On Thu, 4 Jan 2001, Ralf Baechle wrote:</FONT>
</P>

<P><FONT SIZE=2>&gt; &gt; I see that our start address of 0x80102584 has been turned into</FONT>
<BR><FONT SIZE=2>&gt; &gt; 0xffffffff80102584. I'm thinking that</FONT>
<BR><FONT SIZE=2>&gt; &gt; I need to tell ld something to stop it from doing this. Any ideas?</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; That's be ok.&nbsp; 32-bit MIPS addresses are sign-extended into 64-bit addresses.</FONT>
<BR><FONT SIZE=2>&gt; Older binutils used to zero-extend addresses which was broken.&nbsp; So what</FONT>
<BR><FONT SIZE=2>&gt; you observe is actually the sympthom of a bug that got fixed.</FONT>
</P>

<P><FONT SIZE=2>&nbsp;I'm not sure that's the best solution, I'm afraid.&nbsp; For elf32-mips</FONT>
<BR><FONT SIZE=2>addresses should be 32-bit and not 64-bit.&nbsp; It would be consistent with</FONT>
<BR><FONT SIZE=2>other 32-bit platforms, it would make interoperability easier (ksymoops</FONT>
<BR><FONT SIZE=2>cannot make use of System.map to grok kernel oopses which provide 32-bit</FONT>
<BR><FONT SIZE=2>addresses) and it would make objdump outputs more readable.</FONT>
</P>

<P><FONT SIZE=2>&nbsp;Fixing this problem with BFD is on my to do list (but has a low priority</FONT>
<BR><FONT SIZE=2>assigned). </FONT>
</P>

<P><FONT SIZE=2>-- </FONT>
<BR><FONT SIZE=2>+&nbsp; Maciej W. Rozycki, Technical University of Gdansk, Poland&nbsp;&nbsp; +</FONT>
<BR><FONT SIZE=2>+--------------------------------------------------------------+</FONT>
<BR><FONT SIZE=2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-mail: macro@ds2.pg.gda.pl, PGP key available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C0768A.18471550--
