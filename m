Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 17:29:23 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.203]:22414 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8226889AbVGSQ3I> convert rfc822-to-8bit;
	Tue, 19 Jul 2005 17:29:08 +0100
Received: by zproxy.gmail.com with SMTP id n1so1190583nzf
        for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 09:30:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=naMJeIiUZAmYXUd+/7mKtj1PSe5G6hAIOdZnZfKH9mFWdGDJDBTUCFMqjgQGSPHyg37jfHpjSp37lHjWQMzY+t8TnQFIf483G/nBeTtziv4c/XP6EbptP86kgsZlRc0l4So/yznhgWCXYlPjzTl6evUOF6Jnq9wN9laqhVRKlcU=
Received: by 10.36.105.13 with SMTP id d13mr1000563nzc;
        Tue, 19 Jul 2005 09:30:21 -0700 (PDT)
Received: by 10.36.47.11 with HTTP; Tue, 19 Jul 2005 09:30:20 -0700 (PDT)
Message-ID: <f07e6e05071909301c212ab4@mail.gmail.com>
Date:	Tue, 19 Jul 2005 22:00:20 +0530
From:	Kishore K <hellokishore@gmail.com>
Reply-To: Kishore K <hellokishore@gmail.com>
To:	linux-mips@linux-mips.org
Subject: bal instruction in gcc 3.x
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

We are facing a problem when U-boot is compiled with gcc 3.x

U-boot  uses the following instruction in one of the files.

bal jump_to_symbol

This code gets compiled without any problem with gcc2. However, if I
compile the code
with gcc3, it exits with the error "Cannot branch to unknown symbol".

What should we do to circumvent this problem ?

I replaced 

bal jump_to_symbol 

by

la t9, jump_to_symbol
jalr t9

Then code gets compiled properly without any problem. Please let me
know, whether this
is correct way of fixing the problem. I am newbie to MIPS assembly
language. Why this
change is required with gcc 3.x compiler ?


TIA,
--kishore
