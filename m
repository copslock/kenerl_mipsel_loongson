Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 00:40:04 +0200 (CEST)
Received: from mail.esstech.com ([64.152.86.3]:17325 "HELO [64.152.86.3]")
	by linux-mips.org with SMTP id <S1122961AbSILWkE>;
	Fri, 13 Sep 2002 00:40:04 +0200
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; Thu, 12 Sep 2002 15:40:03 -0700
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.12.2/8.12.2) with SMTP id g8CMer0A007049
	for <linux-mips@linux-mips.org>; Thu, 12 Sep 2002 15:40:53 -0700 (PDT)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id PAA24880; Thu, 12 Sep 2002 15:39:04 -0700
Received: from [193.5.206.150] by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id RAA17206; Thu, 12 Sep 2002 17:31:08 -0500
Subject: tools for modifying dwarf symbols
From: Gerald Champagne <gerald.champagne@esstech.com>
To: Linux Mips Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Sep 2002 17:30:59 -0500
Message-Id: <1031869864.7173.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
Return-Path: <gerald.champagne@esstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerald.champagne@esstech.com
Precedence: bulk
X-list: linux-mips

Is there a tool that will allow me to modify the path of filenames in
dwarf symbols in an elf file?  I've looked at everything in binutils,
but these tools only manipulate the binary portion of elf files.  I
don't see any similar tools for modifying dwarf debug symbols in an elf
file.

My problem is that my debugger can't read the source files when absolute
paths are used in filenames.  In my environment, I have to compile on
one system using one path to the files, then later I have to access the
same data from the debugger using a different path.  This works when the
filenames are embedded using relative paths.  Larger systems like the
linux kernel or the pmon boot loader use absolute path names everywhere
in the makefiles.  These absolute paths are embedded in the elf file and
my debugger gets confused.

Is there a tool or library that will simplify manipulating the dwarf
data in the elf files?

Thanks,

Gerald
