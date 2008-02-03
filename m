Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 17:11:37 +0000 (GMT)
Received: from dns0.mips.com ([63.167.95.198]:2487 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20026652AbYBCRL3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2008 17:11:29 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m13HAQpa026668;
	Sun, 3 Feb 2008 09:10:27 -0800 (PST)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m13HB6BW001490;
	Sun, 3 Feb 2008 09:11:07 -0800 (PST)
Message-ID: <47A5F580.8080300@mips.com>
Date:	Sun, 03 Feb 2008 18:10:24 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
CC:	linux-mips@linux-mips.org
Subject: Re: new type of crash report?
References: <1202050578.7035.11.camel@scarafaggio>	 <5BFC57F9-7E81-4667-9D15-72F5F20FA4DD@27m.se> <1202054465.7035.20.camel@scarafaggio>
In-Reply-To: <1202054465.7035.20.camel@scarafaggio>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Giuseppe Sacco wrote:
<blockquote cite="mid:1202054465.7035.20.camel@scarafaggio" type="cite">
  <pre wrap="">Hi Markus,

Il giorno dom, 03/02/2008 alle 16.52 +0100, Markus Gothe ha scritto:
  </pre>
  <blockquote type="cite">
    <pre wrap="">You can always start with running run gdb at the read address
(ra: 0x2ac2bfdc), I'd also try listing 0x2ac2bffc.
    </pre>
  </blockquote>
  <pre wrap=""><!---->[...]

Thanks for your reply. I will try to understand how to use gdb on this
context. (Any URI would be really appreciated.)
Anyway I now understood that a dbe is a data bus error, so probably this
is an error on the physical address, i.e. a kernel problem related to
the mapping between vertical and physical addresses. Is this correct?
  </pre>
</blockquote>
That's correct.&nbsp; You didn't say what processor you were running on, so
it's hard to be more specific - there are some which have a bus error
input pin that can be asserted by the system for other reasons - but in
general it means that there's a data reference at 0x2ac2bffc whose
valid translation goes to a bad address.&nbsp; Generally, that address range
is where shared libraries are mapped, so to find the instruction you
want to run the program that caused the crash under gdb, set a
breakpoint very early (e.g. main), run to the breakpoint, and
disassemble the virtual address.&nbsp; I find it interesting that the
register value reported for register $10 is a reasonable data address
shifted up by 32 bits.&nbsp; It's possible that code would have a real
reason to do that, but I can't help wonder if that isn't part of the
problem. We may be looking at a 2-level bug here:&nbsp; User(?) code
screwing up a base register used for a load or store, and the OS
failing to handle the upper reaches of the 64-bit address space
correctly.<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Regards,<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Kevin K.<br>
</body>
</html>
