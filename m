Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 13:33:01 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:25337 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20051387AbYIWMc4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2008 13:32:56 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8NCWr8m027042;
	Tue, 23 Sep 2008 14:32:53 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8NCWmuS027038;
	Tue, 23 Sep 2008 13:32:53 +0100
Date:	Tue, 23 Sep 2008 13:32:47 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dinar Temirbulatov <dtemirbulatov@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
In-Reply-To: <a664af430809210355p62f6b848q87ed07f63a242c78@mail.gmail.com>
Message-ID: <Pine.LNX.4.55.0809231238390.26757@cliff.in.clinika.pl>
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com> 
 <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl> 
 <a664af430809190953k486e2012hf3a09caa50c9574a@mail.gmail.com> 
 <Pine.LNX.4.55.0809191803390.29711@cliff.in.clinika.pl>
 <a664af430809210355p62f6b848q87ed07f63a242c78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Dinar,

> I don't think it has anything to do type definition of signed or
> unsigned. I think following things happened here we called mmap() from
> n32 and as it is defined is the glibc for this abi the sixth parameter
> should be 32-bit wide integer and we transefed this 32-bit
> value(0xb6000000) in the a5(r9) register according to the mips abi,
> but we loaded this value with "lui     a5,0xb600" instruction and that
> resulted with 0xffffffffb6000000 in the 64-bit version of a5
> register(for 32-bit it is legitimate 0xb6000000). after that on the

 Which is correct, as this is how 32-bit integers are represented by
64-bit MIPS platforms.

> kernel side we have this function old_mmap() and sixth argument there
> is 64-bit wide integer (off_t type) and it does not that we called
> this function from 32-bit environment  and that is why there is
> 0xffffffffb6000000 value in the end, so 0xffffffff is trash. I think
> that we need to have a separate mmap system call handler for 32-bit
> abis, also we need to add mmap2 handler for n32 as we have it for o32.

 The problem is you cannot represent the file offset of 3053453312 or
0x00000000b6000000 using the 32-bit interface.  What you can represent is
-1241513984 or 0xffffffffb6000000 and that is a valid offset for calls
like lseek(), but not necessarily mmap() (though arguably we have a
bug/feature in Linux where negative offsets are not explicitly checked for
in mmap()).  To represent 3053453312 or 0x00000000b6000000 correctly you
need to use the 64-bit interface LFS calls provide.  In this case that
would be mmap64() or use _FILE_OFFSET_BITS as appropriate.

  Maciej
