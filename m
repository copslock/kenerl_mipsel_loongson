Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Feb 2003 11:50:44 +0000 (GMT)
Received: from webmail15.rediffmail.com ([IPv6:::ffff:203.199.83.25]:35544
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8224851AbTBZLun>; Wed, 26 Feb 2003 11:50:43 +0000
Received: (qmail 19906 invoked by uid 510); 26 Feb 2003 11:49:44 -0000
Date: 26 Feb 2003 11:49:44 -0000
Message-ID: <20030226114944.19905.qmail@webmail15.rediffmail.com>
Received: from unknown (203.196.179.98) by rediffmail.com via HTTP; 26 feb 2003 11:49:44 -0000
MIME-Version: 1.0
From: "Yogish  Patil" <yogishpatila@rediffmail.com>
Reply-To: "Yogish  Patil" <yogishpatila@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: problematic big endian ramdisk...
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <yogishpatila@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yogishpatila@rediffmail.com
Precedence: bulk
X-list: linux-mips

I am unable to make a working big endian ramdisk.

I have tried big endian ramdisk from
ftp://ftp.ltc.com/pub/linux/mips/ramdisk/ramdisk
and sorry to say this is simply not big endian ramdisk.
i find in mailing list other people also complaining about 
this...

when trying to execve it gives me ENOEXEC error that is because
first few bytes of elf header are swapped.

specific problem is in identifying the e_type and e_machine 
fields
in elf header of executables.
expected value of e_type is 0x2(ET_EXEC) amd e_machine is
0x8(EM_MIPS)
but those are read as 0x200 and 0x800 respectivly ..this is
obviously the endianness problem.

but if i try the big endian ramdisk from debian it just goes 
fine.
but this is precompiled busybox hence i can't add my stuff 
there.

can anybody point to a link for downloading a correct big endian
ramdisk..

with regards,
--yogi
