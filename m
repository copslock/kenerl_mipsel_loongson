Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g093hG913500
	for linux-mips-outgoing; Tue, 8 Jan 2002 19:43:16 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g093hEg13497
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 19:43:14 -0800
Received: from h11752a ([172.17.254.1]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GPNGSO00.44Y; Wed,
          9 Jan 2002 10:41:12 +0800 
Message-ID: <000f01c198b6$d627ffe0$9b6e0b0a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
Cc: <linux-mips@oss.sgi.com>
References: <003301c198af$1c0d0a80$9b6e0b0a@huawei.com> <20020109015128.GB23506@conectiva.com.br>
Subject: Re: limited Memory question...
Date: Wed, 9 Jan 2002 10:39:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g093hFg13498
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > I have a question to need you help. Our MIPS-based custom board has only
> > 8M memory.When I want to insmod a 24M module, it often panics and says
> > "out of memory...".
> 
> a kernel module? 24MiB? ouch, if that is the case, the only way is to get
> more memory for your board, as kernel memory is not swappable...

Yes, it is a kernel module.  
But unfortunately, the memory is fixed on our board and we cannot add more memory.
Any other ideas?
