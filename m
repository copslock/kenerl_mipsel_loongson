Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g094HLM16600
	for linux-mips-outgoing; Tue, 8 Jan 2002 20:17:21 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g094HIg16596
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 20:17:18 -0800
Received: from h11752a ([172.17.254.1]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GPNIDG00.O7K; Wed,
          9 Jan 2002 11:15:16 +0800 
Message-ID: <004101c198bb$988a6ec0$9b6e0b0a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-mips@oss.sgi.com>,
   "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
References: <E16O9BM-0008W9-00@the-village.bc.nu>
Subject: Re: limited Memory question...
Date: Wed, 9 Jan 2002 11:13:22 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g094HJg16597
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >     I have a question to need you help. Our MIPS-based custom board has only
> > 8M memory.When I want to insmod a 24M module, it often panics and says "out 
> > of memory...".
> > How can I solve this?
> 
> Stop the module using 24Mb of unpageable memory ?

Sorry , I think I didn't describe my questions clearly before.

"24M" contains some debugging information. I compile it using "-g".
code+data sections is only about 7.4M.

Can you describe your solutions in more details?

machael.
