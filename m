Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2004 07:15:03 +0100 (BST)
Received: from futarque.com ([IPv6:::ffff:212.242.80.58]:41631 "HELO
	mail.futarque.com") by linux-mips.org with SMTP id <S8224838AbUI2GO6>;
	Wed, 29 Sep 2004 07:14:58 +0100
Received: (qmail 8986 invoked by uid 64014); 29 Sep 2004 06:14:50 -0000
Received: from smm@futarque.com by mail by uid 64011 with qmail-scanner-1.16 
 (uvscan: v4.1.60/v4278. spamassassin: 2.63.   Clear:. 
 Processed in 0.245475 secs); 29 Sep 2004 06:14:50 -0000
Received: from excalibur.futarque.com (192.168.2.15)
  by mail.futarque.com with SMTP; 29 Sep 2004 06:14:50 -0000
Subject: Re: Problem debugging multi-threaded app
From: Steffen Malmgaard Mortensen <smm@futarque.com>
To: linux-mips@linux-mips.org
In-Reply-To: <1096362700.5227.19.camel@localhost>
References: <1096362700.5227.19.camel@localhost>
Content-Type: multipart/alternative; boundary="=-gh6R7eefsOFBcBFX4ZAh"
Message-Id: <1096438490.5227.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 08:14:50 +0200
Return-Path: <smm@futarque.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smm@futarque.com
Precedence: bulk
X-list: linux-mips


--=-gh6R7eefsOFBcBFX4ZAh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi again,
Sorry - I know I shouldn't even be allowed to ask questions...... It was
another old, known bug - I was running with stripped libpthread......
/Steffen


On Tue, 2004-09-28 at 11:11, Steffen Malmgaard Mortensen wrote:

> Hi all,
> 
> I'm trying to debug a multi-threaded app using gdbserver/gdb. I see the
> same problems as described in
> http://www.linux-mips.org/archives/linux-mips/2002-09/msg00155.html -
> the program receives SIG32, but gdb doesn't associate that with thread
> creation. The solution back in 2002 was to upgrade the tool-chain, but
> I'm not sure what versions I should use today (and what patches). I'm
> currently using:
> 
> CPU: Ati X225 (mips4kc - little endian)
> kernel: linux 2.4.18 + vendor patches
> 
> glibc: 2.3.2
> gcc: 3.3.2
> binutils: 2.14
> (the three above from crosstool 0.27)
> 
> gdb/gdbserver: 6.2
> 
> According to strace gdbserver loads libthread_db as it should, but gdb
> on my host doesn't load libthread_db.
> 
> Any help/suggestions will be greatly appriciated...
> 
> Best regards,
> Steffen
> 
> 
> 

--=-gh6R7eefsOFBcBFX4ZAh
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Hi again,<BR>
Sorry - I know I shouldn't even be allowed to ask questions...... It was another old, known bug - I was running with stripped libpthread......<BR>
/Steffen<BR>
<BR>
<BR>
On Tue, 2004-09-28 at 11:11, Steffen Malmgaard Mortensen wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Hi all,

I'm trying to debug a multi-threaded app using gdbserver/gdb. I see the
same problems as described in</FONT>
<A HREF="http://www.linux-mips.org/archives/linux-mips/2002-09/msg00155.html"><U>http://www.linux-mips.org/archives/linux-mips/2002-09/msg00155.html</U></A><FONT COLOR="#737373"> -
the program receives SIG32, but gdb doesn't associate that with thread
creation. The solution back in 2002 was to upgrade the tool-chain, but
I'm not sure what versions I should use today (and what patches). I'm
currently using:

CPU: Ati X225 (mips4kc - little endian)
kernel: linux 2.4.18 + vendor patches

glibc: 2.3.2
gcc: 3.3.2
binutils: 2.14
(the three above from crosstool 0.27)

gdb/gdbserver: 6.2

According to strace gdbserver loads libthread_db as it should, but gdb
on my host doesn't load libthread_db.

Any help/suggestions will be greatly appriciated...

Best regards,
Steffen


</I></FONT></PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-gh6R7eefsOFBcBFX4ZAh--
