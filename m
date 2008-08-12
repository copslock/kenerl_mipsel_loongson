Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 14:46:49 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:24020 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20031612AbYHLNqk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 14:46:40 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KStqv-00050O-SP
	for linux-mips@linux-mips.org; Tue, 12 Aug 2008 06:23:57 -0700
Message-ID: <18944199.post@talk.nabble.com>
Date:	Tue, 12 Aug 2008 06:23:57 -0700 (PDT)
From:	TriKri <kristoferkrus@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Debugging the MIPS processor using GDB
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: kristoferkrus@hotmail.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kristoferkrus@hotmail.com
Precedence: bulk
X-list: linux-mips


The questions are many, and I don't really know where to begin, but I shall
make a try.

I am developing software to debug a MIPS processor in an embedded system
using an EJTAG probe. Currently I have software to tell the processor to
perform certain instructions, and read/write from/to certain register
addresses. Now, I don't really know how to continue from here; I'm trying to
find out how to make GDB benefit from these functions in order to be able to
debug the processor.

I know that GDB needs a gdb-stub, but I don't really know what it is and
what it does, or why GDB needs it. The GDB manual suggests taking a look at
sparc-stub.c coming along with GDB, since it's the best organized. Not
finding any main function in it, I'm having a hard time figuring out to what
it does. How should this stub be implemented and how do I know what to write
in the stub file I'm going to write?

There is also something called gdb-hook, which I don't really know what it
is either. Do I need it?

Finally, there's a program called gdbserver, which comes with GDB. If I
write a remote stub, do I need this program? Where should it be run? Where
should my program be run? Since the stub is a c file, but lacks of a main
function, how do I compile it?

There are just so many unanswered questions, I don't know where to start
working or where to start looking for information. I haven't used GDB before
either, possibly contributing to some of the confusion; I hope I'll get this
straight soon, though.

/Kristofer
-- 
View this message in context: http://www.nabble.com/Debugging-the-MIPS-processor-using-GDB-tp18944199p18944199.html
Sent from the linux-mips main mailing list archive at Nabble.com.
