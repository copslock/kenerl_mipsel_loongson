Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id HAA04279
	for <pstadt@stud.fh-heilbronn.de>; Fri, 30 Jul 1999 07:38:42 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id WAA28336; Thu, 29 Jul 1999 22:34:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA05851
	for linux-list;
	Thu, 29 Jul 1999 22:30:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA43274
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Jul 1999 22:30:33 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA06383
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jul 1999 22:30:33 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.3/8.9.3) with ESMTP id VAA07521;
	Thu, 29 Jul 1999 21:18:03 -0700
Message-ID: <37A137F7.91B5AC4A@cobaltnet.com>
Date: Thu, 29 Jul 1999 22:28:23 -0700
From: Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>, linux@cthulhu.engr.sgi.com
Subject: Re: an ld problem? - possibly fixed..
References: <379FBBFE.FB8C1734@cobaltnet.com> <19990729153427.E4730@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> just in case if you manage to fix this one please drop me a note.

I'm calling in for help on the solution now.

The problem occurs when a segment is found that is not a known name, libbfd
abort()s in mips_elf_relocate_section().  In the case of the egcs libstdc++
link the segments in question are : ".dtors" and ".gcc_except_table".  I assume
since .dtors is trouble, so will .ctors be.

If I add .dtors and .gcc_except_table to mips_elf_dynsym_sec_names[] in
${binutils_src_path}/bfd/elf32-mips.c and rebuild libbfd - ld no longer gets an
abort() when compiling the file in question.  I'm pretty sure this is NOT the
right solution.  There is also a table of sections in
${binutils_src_path}/bfd/syms.c.  What is the "right" solution, and what other
sections can exist that bfd doesn't know about?

Someone with a bit more experience inside libbfd - please help? :)

Tim
