Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6H5jlp09251
	for linux-mips-outgoing; Mon, 16 Jul 2001 22:45:47 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6H5jfV09248;
	Mon, 16 Jul 2001 22:45:42 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id WAA05814;
	Mon, 16 Jul 2001 22:45:33 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id WAA22530;
	Mon, 16 Jul 2001 22:45:32 -0700 (PDT)
Message-ID: <001301c10e84$570805a0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>,
   "Greg Johnson" <gjohnson@superweasel.com>
Cc: <linux-mips@oss.sgi.com>
References: <20010716163712.B12104@superweasel.com> <20010717032055.A1236@bacchus.dhis.org> <20010716223902.A16351@superweasel.com> <20010717050050.A1737@bacchus.dhis.org>
Subject: Re: Linux on a 100MHz r4000 indy?
Date: Tue, 17 Jul 2001 07:50:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I don't have access to old R4000 revision data, and I'll take your
word for the errata applicable to rev 0422.  A am a *little* surprised
that such early parts found their way into Indys, since the Indy was
not the first R4000 platform (I believe that honor belongs to the
"Crimson" graphics workstations), but it's certainly possible.

            Regards,

            Kevin K.

----- Original Message -----
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "Greg Johnson" <gjohnson@superweasel.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Tuesday, July 17, 2001 5:00 AM
Subject: Re: Linux on a 100MHz r4000 indy?


> On Mon, Jul 16, 2001 at 10:39:02PM -0400, Greg Johnson wrote:
>
> > CPU revision is: 00000422
>
> That's a really old and buggy CPU.  Kevin Kissel may correct me but I
think
> it's the first series shipped to customers.  Among the fun bugs:
>
> --------------------------------------------------------------------------
---
>
> 4. R4000PC, R4000SC: An instruction sequence which contains a load which
causes
>    a data cache miss and a jump, where the jump instruction is that last
>    instruction in the page and the delay slot of the jump is not currently
>    mapped, causes the exception vector to be overwritten by the jump
address.
>    The R4000 will use the jump address as the exception vector.
>
>    Example: lw <---- data cache miss
> noop <---- one or two Noops
> jr <---- last instruction in the page (jump or branch in-
>       struction)
> --------------<---- page boundary
> noop
>
>    Workaround: Jump and branch instructions should never be in the last
loca-
>                tion of a page.
> 11. R4000PC, R4000SC: In the case:
>
> lw rA, (rn)
> noop (or any non-conflicting instruction)
> lw rn, (rA) (where the address in rA causes a TLB refill)
> --------------------> end of page
> page not mapped
>
>    where rn and RA are general purpose registers r0 through r31
>
>    This code sequence causes the second load instruction to slip due to a
>    load use interlock. When the R4000 crosses the page boundary after the
>    lw, it vectors to 0x8000 0000 and later causes an instruction cache
miss.
>    After the instruction cache miss is complete the LW causes another TLB
>    refill. This should vector to 0x8000 0000 but instead goes to 0x8000
0180.
>
> 14 (Just an update of erratum 4)
>
> --------------------------------------------------------------------------
---
>
> There's more but I don't want to paste the whole errata document in here
> and above bugs alone without the respective workarounds in kernel and
tools
> are grave bugs.
>
>   Ralf
