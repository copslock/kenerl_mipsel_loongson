Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7L15ac03684
	for linux-mips-outgoing; Mon, 20 Aug 2001 18:05:36 -0700
Received: from smtp.huawei.com (61.144.GD.CN [61.144.161.21] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7L15V903681;
	Mon, 20 Aug 2001 18:05:31 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GIE89N00.C2E; Tue, 21 Aug 2001 09:03:23 +0800 
Message-ID: <001501c129dd$8acebb80$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net>
Subject: Re: questions about eret....
Date: Tue, 21 Aug 2001 09:06:43 +0800
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


----- Original Message -----
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "machael thailer" <dony.he@huawei.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Tuesday, August 21, 2001 5:07 AM
Subject: Re: questions about eret....


> On Mon, Aug 20, 2001 at 05:54:09PM +0800, machael thailer wrote:
>
> >     I have a question to ask about eret.
> >
> >     In RC4xxx/RC32334, after eret finished, does it automatically enable
IE
> > bit of STATUS register?
>
> ERET does not influence the state of the IE bit.

I agree with you, but the RC32334 User manual (14-13 section) say  it does
and say we must run a "CLI" just before eret to disable IE bit in Status
register .

machael thailer
