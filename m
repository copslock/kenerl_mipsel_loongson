Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2011 21:29:32 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:3896 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab1BNU33 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Feb 2011 21:29:29 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5990ad0000>; Mon, 14 Feb 2011 15:29:34 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 14 Feb 2011 12:29:25 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 14 Feb 2011 12:29:25 -0800
Message-ID: <4D5990A4.2050308@caviumnetworks.com>
Date:   Mon, 14 Feb 2011 12:29:24 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Subject: RFC: A new MIPS64 ABI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2011 20:29:25.0308 (UTC) FILETIME=[DEEE7FC0:01CBCC85]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Background:

Current MIPS 32-bit ABIs (both o32 and n32) are restricted to 2GB of
user virtual memory space.  This is due the way MIPS32 memory space is
segmented.  Only the range from 0..2^31-1 is available.  Pointer
values are always sign extended.

Because there are not already enough MIPS ABIs, I present the ...

Proposal: A new ABI to support 4GB of address space with 32-bit
pointers.

The proposed new ABI would only be available on MIPS64 platforms.  It
would be identical to the current MIPS n32 ABI *except* that pointers
would be zero-extended rather than sign-extended when resident in
registers.  In the remainder of this document I will call it
'n32-big'.  As a result, applications would have access to a full 4GB
of virtual address space.  The operating environment would be
configured such that the entire lower 4GB of the virtual address space
was available to the program.


At a low level here is how it would work:

1) Load a pointer to a register from memory:

n32:
	LW $reg, offset($reg)

n32-big:
	LWU $reg, offset($reg)

2) Load an address constant into a register:

n32:
	LUI $reg, high_part
	ORI $reg, low_part

n32-big:
	ORI $reg, high_part
	DSLL $reg, $reg, 16
	ORI $reg, low_part


Q: What would have to change to make this work?

o A new ELF header flag to denote the ABI.

o Linker support to use proper library search paths, and linker scrips
   to set the INTERP program header, etc.

o GCC has to emit code for the new ABI.

o Could all existing n32 relocation types be used?  I think so.

o Runtime libraries would have to be placed in a new location
   (/lib32big, /usr/lib32big ...)

o The C library's ld.so would have to use a distinct LD_LIBRARY_PATH
   for n32-big code.

o What would the Linux system call interface be?  I would propose
   using the existing Linux n32 system call interface.  Most system
   calls would just work.  Some, that pass pointers in in-memory
   structures, might require kernel modifications (sigaction() for
   example).
