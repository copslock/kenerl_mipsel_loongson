Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4INg7811378
	for linux-mips-outgoing; Fri, 18 May 2001 16:42:07 -0700
Received: from smtp.psdc.com (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4INg3F11374;
	Fri, 18 May 2001 16:42:03 -0700
Received: from BANANA ([209.125.203.85])
	by smtp.psdc.com (8.8.8/8.8.8) with SMTP id QAA24939;
	Fri, 18 May 2001 16:48:02 -0700
Message-ID: <000801c0dff4$3870ba60$dde0490a@pcs.psdc.com>
From: "Steven Liu" <stevenliu@psdc.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Keith M Wesolowski" <wesolows@foobazco.org>, <linux-mips@oss.sgi.com>
References: <000801c0a572$b7471e40$dde0490a@BANANA> <20010305205516.A25870@foobazco.org> <001201c0df37$2befb920$dde0490a@pcs.psdc.com> <20010517223139.A19781@bacchus.dhis.org>
Subject: Re: mips-tfile
Date: Fri, 18 May 2001 16:42:37 -0700
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

Hi ALL:

I have a question regarding MIPS Makefile.

In the Makefile of the Linux build directory, there are two Macros of C
compiler flags: HOSTCFLAGS and CFLAGS.

What are their purpose and difference? In another words, what is host gcc?
Why do we use host gcc in building the target kernel?

If you could give me any help, I would be very pleased.

Thank you.

Steven Liu

----- Original Message -----
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "Steven Liu" <stevenliu@psdc.com>
Cc: "Keith M Wesolowski" <wesolows@foobazco.org>; <linux-mips@oss.sgi.com>
Sent: Thursday, May 17, 2001 6:31 PM
Subject: Re: mips-tfile


> On Thu, May 17, 2001 at 06:09:17PM -0700, Steven Liu wrote:
>
> > I have a question about GCC:
> >
> > How can we make gcc do not use the MIPS instructions lwl, lwr, swl, and
swr?
>
> Modify gcc.  Unless you're using a new flavour (And I'm tempted to use
some
> curseword instead ...) of a cpu core without lwl/lwr/swl/swr there should
> never be a reason to avoid those instructions.
>
>   Ralf
>
