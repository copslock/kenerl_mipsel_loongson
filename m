Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NBVuw22731
	for linux-mips-outgoing; Thu, 23 Aug 2001 04:31:56 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NBVUd22717;
	Thu, 23 Aug 2001 04:31:32 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA19412;
	Thu, 23 Aug 2001 15:31:13 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA04309; Thu, 23 Aug 2001 15:08:55 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA20536; Thu, 23 Aug 2001 15:22:57 +0400 (MSD)
Message-ID: <3B84E796.EF5E5F39@niisi.msk.ru>
Date: Thu, 23 Aug 2001 15:23:02 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Harald Koerfgen <hkoerfg@web.de>,
   Keith Owens <kaos@ocs.com.au>, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Make __dbe_table available to modules
References: <Pine.GSO.3.96.1010814192820.5426B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Mon, 13 Aug 2001, Gleb O. Raiko wrote:
> 
> > DBE is treated as ACK* on write. Some HW design manuals advise to use
> > this fact even.
> 
>  And what is the use of ACK*?

Acknowledge. It's used to indicate current transaction has been
processed successfully. If you are interested in details, I would
suggest you read a MIPS hardware manual, for example, IDT's one.

The most intriguing feature is:
"Write transactions terminated by BusError* do not require the assertion
of Ack*. BusError* can be asserted at at any time the processor is
looking for Ack* to be asserted, up to and including the cycle in which
the memory system does signal Ack*."

> 
>  Note that that the state of the CPU at the moment of a write is
> completely unrelated to the action that triggered the write.  Therefore
> any reporting of a write failure is hardly useful -- possibly as a kind of
> an MCE only, i.e. report the event and kill the current process or panic
> if none.

I consider external signaling of write failures may be useful for kernel
debugging purposes. I agree it's hard (or even impossible) to achieve
proper behaviour on write failures for user space. There is a small
chance to kill another process, for example, write transactions may
delay due to write buffer. So, the kernel may only print something.

Regards,
Gleb.
