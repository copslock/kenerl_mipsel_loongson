Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 18:27:46 +0100 (BST)
Received: from web11901.mail.yahoo.com ([IPv6:::ffff:216.136.172.185]:57992
	"HELO web11901.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225765AbUCaR1p>; Wed, 31 Mar 2004 18:27:45 +0100
Message-ID: <20040331172720.46759.qmail@web11901.mail.yahoo.com>
Received: from [65.204.143.3] by web11901.mail.yahoo.com via HTTP; Wed, 31 Mar 2004 09:27:20 PST
Date: Wed, 31 Mar 2004 09:27:20 -0800 (PST)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: madwifi driver
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to get the madwifi driver to work with
mips. Madwifi seems to have support for mips through
the file " mipsisa32-le-elf.hal.o.uu " , but when you
uudecode this file, "file" reports it as mips3. And so
you can not link this with the other driver modules
which are being compiled at mips ( 1 ). Can't link the
files so the whole module build fails.

I believe I am correct in thinking that the linux-mips
kernel, compiles at a max mips isa of 2. If that is
so, can anyone think why anyone would make a kernel
module with mips3 code in it ? Other Operating systems
allow higher ISA values ? I believe madwifi is based
on FreeBSD, so maybe that allows mips3 ???

I have already posted to the madwifi list about this,
but as yet have had no reply. So I was wondering if
anyone on this list had ever tried to compile madwifi,
and if you succeeded, I would very much appreciate it
if you could explain how.

Alternatively, does anyone know how I can force link
the mips object files with the mips3 object file, on
the off chance that thinks might just work ?

Any help appreciated.

TIA

__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
