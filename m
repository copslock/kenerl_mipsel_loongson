Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IMBhnC002288
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 15:11:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IMBhtD002287
	for linux-mips-outgoing; Tue, 18 Jun 2002 15:11:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-59.ka.dial.de.ignite.net [62.180.196.59])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IMBbnC002284
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 15:11:39 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5IMCI604644
	for linux-mips@oss.sgi.com; Wed, 19 Jun 2002 00:12:18 +0200
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IGBqnC022306
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 09:11:52 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5IGE9r01526;
	Tue, 18 Jun 2002 09:14:09 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: Code error - why?
From: Justin Carlson <justin@cs.cmu.edu>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: Balakrishnan Ananthanarayanan <balakris_ananth@email.com>,
   linux-mips@oss.sgi.com
In-Reply-To: <00bd01c21618$4e714ef0$4c00a8c0@prefect>
References: <20020617094851.30730.qmail@email.com> 
	<00bd01c21618$4e714ef0$4c00a8c0@prefect>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 09:14:09 -0700
Message-Id: <1024416849.1182.10.camel@xyzzy.rlson.org>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

After preprocessing, the assembler needs to see $<number> as 
register specifiers, so typically your choices are to do either:

#define a0 $4  // See include/asm-mips/regdef.h for these
#define v0 $2

...

	la a0, quest
	li v0, 4



Or to just use the register numbers, e.g.

	la $4, quest
	li $2, 4


-Justin


> ----- Original Message -----
> From: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>
> To: <linux-mips@oss.sgi.com>; <linux-kernel@vger.kernel.org>;
> <redhat-list@redhat.com>
> Sent: Monday, June 17, 2002 5:48 AM
> Subject: Code error - why?
> 
> 
> > I wrote a SAMPLE CODE - Hello.S to work for a cross-assembler
> mips-linux-as - but this is giving me an error message:
> >    ".data
> >          quest: .asciiz "Hello World!"
> >     .text
> >     _start:
> >          la $a0, quest
> >          li $v0, 4
> >          syscall   "
> >
> > The error messages are:
> >   " Hello.S line 5: illegal operands 'la'
> >     Hello.S line 6: illegal operands 'li'"
> >
> > Can anyone help? What is wrong?
