Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NFrAZ30260
	for linux-mips-outgoing; Thu, 23 Aug 2001 08:53:10 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NFr4d30255
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 08:53:04 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01506
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 08:53:01 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA22772;
	Thu, 23 Aug 2001 17:46:57 +0200 (MET DST)
Date: Thu, 23 Aug 2001 17:46:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Make __dbe_table available to modules
In-Reply-To: <3B84E796.EF5E5F39@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010823172522.21718E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 23 Aug 2001, Gleb O. Raiko wrote:

> Acknowledge. It's used to indicate current transaction has been
> processed successfully. If you are interested in details, I would
> suggest you read a MIPS hardware manual, for example, IDT's one.

 I see if I can find a suitable onein my archive.  I have an IDT CD-ROM,
but it's quite new -- dated 1997 -- and it lacks a lot of earlier stuff.
There is an R5k hw manual there, though, I think.  Too bad they got rid of
end of line stuff -- there is only ~140MB of space consumed on the CD so
there would be much room for reference docs for older parts...

> The most intriguing feature is:
> "Write transactions terminated by BusError* do not require the assertion
> of Ack*. BusError* can be asserted at at any time the processor is
> looking for Ack* to be asserted, up to and including the cycle in which
> the memory system does signal Ack*."

 Interesting.  So bus errors on write transactions seem to be somehow
supported from the hardware's point of view.  But software can't determine
the type of a bus cycle that triggered an error.  E.g. if you expect a
load instruction to trigger a bus error in some cases and you indeed get
one, you can't tell if the error was due to this instruction or due to a
write cycle triggered by some antecedent code.  I think that's the reason
of the suggestion of not using this kind of reporting -- if you limit bus
errors to read/fetch transactions in the ISA definition, you get rid of
this ambiguity. 

> I consider external signaling of write failures may be useful for kernel
> debugging purposes. I agree it's hard (or even impossible) to achieve
> proper behaviour on write failures for user space. There is a small
> chance to kill another process, for example, write transactions may
> delay due to write buffer. So, the kernel may only print something.

 Or, more severly and importantly, a write-back cache.  We provide such
diagnostics but it's dubious for writes.  You are right, it might be
useful for debugging in some cases, though.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
