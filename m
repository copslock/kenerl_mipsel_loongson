Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2003 17:43:51 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:6054 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225488AbTJNQnk>;
	Tue, 14 Oct 2003 17:43:40 +0100
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1A9SGh-0003Dl-NA; Tue, 14 Oct 2003 12:43:31 -0400
Date: Tue, 14 Oct 2003 12:43:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: 2.6 crashes testcase
Message-ID: <20031014164331.GA12254@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Hey Ralf,

Here's a tiny root filesystem and README that show the problem, on the
chance that the different glibc version or such is triggering it.  Follow
the instructions, segfaults guaranteed or no money back.  If you want to
give me a copy of all the same libraries/files from your older working 2.6
root, I'll try them.  Oh, this is mipsel, btw - I hadn't thought about that,
the Indy is big-endian isn't it?  I don't think I have BE firmware for this
board.

root filesystem:
  http://www.false.org/~drow/target-with-crashes.tar.gz
.config:
  http://www.false.org/~drow/config-mips-2.6

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
