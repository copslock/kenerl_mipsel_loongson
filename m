Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 21:47:15 +0200 (CEST)
Received: from real.realitydiluted.com ([208.242.241.164]:37355 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1122987AbSIQTrO>; Tue, 17 Sep 2002 21:47:14 +0200
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17rJcU-00045r-00; Tue, 17 Sep 2002 09:46:30 -0500
Message-ID: <3D878695.3040101@realitydiluted.com>
Date: Tue, 17 Sep 2002 14:46:29 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Stuart Hughes <seh@zee2.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
References: <3D876053.C2CD1D8C@zee2.com> <3D87653E.9030702@realitydiluted.com> <20020917182536.GA25012@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> On Tue, Sep 17, 2002 at 12:24:14PM -0500, Steven J. Hill wrote:
> 
> Steve, have you started memorizing my responses again? :)
> 
*gurgle* Yeah, I have. I apologize if it seemed I was taking
credit for anything.

>>>cross-gdb configured using: 
>>>
>>>configure --prefix=/usr --target=mipsel-linux --disable-sim
>>>--disable-tcl --enable-threads --enable-shared
>>>
>>
>>Use '--target=mips-linux' and you'll be better off. Don't worry, it
>>will support both endians.
> 
> 
> Except for this one - where'd that come from?  It should make no
> functional difference either way, at least assuming you always give GDB
> a binary.
>
I got some weird errors (unfortunately I can't remember) if I tried
using 'mipsel-linux' as the target. So you're saying that a gdb
configured for 'mipsel-linux' or 'mips-linux' should work the same?
Thanks Daniel.

-Steve
