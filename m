Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 21:36:27 +0100 (BST)
Received: from ispmxmta06-srv.alltel.net ([IPv6:::ffff:166.102.165.167]:901
	"EHLO ispmxmta06-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225745AbUEJUgZ>; Mon, 10 May 2004 21:36:25 +0100
Received: from lahoo.priv ([69.40.149.10]) by ispmxmta06-srv.alltel.net
          with ESMTP
          id <20040510203614.FFKH5465.ispmxmta06-srv.alltel.net@lahoo.priv>;
          Mon, 10 May 2004 15:36:14 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BNHRz-0001IY-00; Mon, 10 May 2004 16:32:35 -0400
Message-ID: <01a901c436ce$7029d890$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: "Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
References: <045b01c43155$1e06cd80$8d01010a@prefect><874qqpg2ti.fsf@redhat.com> <012701c43607$83aa65f0$8d01010a@prefect><87pt9cwwzu.fsf@redhat.com> <00e201c436b9$5fa0f450$8d01010a@prefect> <878yg0m9db.fsf@redhat.com>
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol table entry st_value
Date: Mon, 10 May 2004 16:36:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips


----- Original Message ----- 
From: "Richard Sandiford" <rsandifo@redhat.com>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: <uclibc@uclibc.org>; <linux-mips@linux-mips.org>
Sent: Monday, May 10, 2004 2:21 PM
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
table entry st_value


> "Bradley D. LaRonde" <brad@laronde.org> writes:
> > Even though it is pointing libdl to the libpthread stub for malloc,
should
> > it crash?
>
> Yeah.  When you call a stub, $gp must already be set to the owning
> object's _gp.  That's how the dynamic loader knows which GOT to change.
>
> In your case, libdl will be calling libpthread's stub with $gp set to
> libdl's _gp.  The dynamic loader will therefore end up trying to change
> libdl's GOT, not libpthread's.

I read this in the spec:

    All externally visible symbols, both defined and undefined,
    must be hashed into the hash table.

Should libpthread's malloc stub be added to the hash table?  I guess not,
but I think that might be happening (haven't verified), and libdl finding it
in there and thinking it is the real deal, not realizing it is just a stub.


Regards,
Brad
