Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LA8FG15766
	for linux-mips-outgoing; Tue, 21 Aug 2001 03:08:15 -0700
Received: from smtp.huawei.com (61.144.GD.CN [61.144.161.21] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LA8B915763;
	Tue, 21 Aug 2001 03:08:11 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GIEXE100.2CK; Tue, 21 Aug 2001 18:06:01 +0800 
Message-ID: <001201c12a29$57f3b660$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net>
Subject: Re: questions about eret....
Date: Tue, 21 Aug 2001 18:09:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>
> > > >     I have a question to ask about eret.
> > > >
> > > >     In RC4xxx/RC32334, after eret finished, does it automatically
enable
> > IE
> > > > bit of STATUS register?
> > >
> > > ERET does not influence the state of the IE bit.
> >
> > I agree with you, but the RC32334 User manual (14-13 section) say  it
does
> > and say we must run a "CLI" just before eret to disable IE bit in Status
> > register .
>
> That has a different reason.  Eret takes the return address from the
> EPC register and if you'd take an exception between restoring that and the
> eret you'd loose it's content - crash boom bang.

Yes.
But in the sourece codes, when we finish the exception handlers , we will
run "ret_from_irq" (ret_from_sys_call) in the entry.S and then run macro
"RESTORE_ALL_AND_RET".  The macro does restore all registers and then ERET.
But there is not a "CLI" just before ERET as the user manual suggested. Why?
so when we handle a syscall exception, we do "STI" in the handle_sys(). and
when ret_from_sys_call and we will run this macro "RESTORE_ALL_AND_RET".
because there is not a "CLI" just before ERET , is it possible to have some
problems?

machael thailer
