Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA70sE218744
	for linux-mips-outgoing; Tue, 6 Nov 2001 16:54:14 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA70s9018740;
	Tue, 6 Nov 2001 16:54:09 -0800
Received: from hcdong11752a ([10.105.28.74]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GMENBT00.B7E; Wed,
          7 Nov 2001 08:43:05 +0800 
Message-ID: <001101c16725$c0a6eae0$4a1c690a@huawei.com>
From: "machael" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <013301c165cc$5d030fa0$4a1c690a@huawei.com> <20011106130839.B30219@dea.linux-mips.net>
Subject: Re: vmalloc bugs in 2.4.5???
Date: Wed, 7 Nov 2001 08:47:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >     I use linux-2.4.5 and I think VMALLOC may have some bugs which i
don't
> > know how to fixup.
>
> Vmalloc is probably innocent I'd rather guess cache flushing is broken on
> your platform.

Yes, It is possible. But I don't know how to fixup this broken cache
flushing?
And when and where should I flush cache (icache and dcache) manually?I am
really know little things about cache.

Can you help me?
Thank you very much.

machael
