Received:  by oss.sgi.com id <S42292AbQGaOYZ>;
	Mon, 31 Jul 2000 07:24:25 -0700
Received: from [207.81.221.34] ([207.81.221.34]:24384 "EHLO relay")
	by oss.sgi.com with ESMTP id <S42233AbQGaOYM>;
	Mon, 31 Jul 2000 07:24:12 -0700
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id KAA20901
	for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 10:42:54 -0400
Message-ID: <39859107.195824A0@vcubed.com>
Date:   Mon, 31 Jul 2000 10:45:27 -0400
From:   Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Binutils-2.10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I have tried to compile binutils-2.10 with the patches from
http://www.ds2.pg.gda.pl/~macro/ but it fails because
BFD_RELOC_MIPS_HIGHER and BFD_RELOC_MIPS_HIGHEST are not
defined.  I believe that they should be defined in bfd-in2.h
but they are not there.  At the top of the file it says that
it is a generated file so how do I generate it?  I am also
wondering if changes to this file are missing from the patch
file.

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.
