Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7HGMmRw026558
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 17 Aug 2002 09:22:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7HGMmuS026557
	for linux-mips-outgoing; Sat, 17 Aug 2002 09:22:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-43.ka.dial.de.ignite.net [62.180.196.43])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7HGMfRw026548
	for <linux-mips@oss.sgi.com>; Sat, 17 Aug 2002 09:22:43 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7HGPCU24881;
	Sat, 17 Aug 2002 18:25:12 +0200
Date: Sat, 17 Aug 2002 18:25:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: =?iso-8859-1?Q?=B1=CF=D1=A7=D2=A2?= <bxy@mail.ihep.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: irq handle of sb1250
Message-ID: <20020817182512.A24834@linux-mips.org>
References: <200208160756.g7G7uvR08742@mail.ihep.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208160756.g7G7uvR08742@mail.ihep.ac.cn>; from bxy@mail.ihep.ac.cn on Fri, Aug 16, 2002 at 04:01:48PM +0800
X-MIME-Autoconverted: from 8bit to quoted-printable by dea.linux-mips.net id g7HGPCU24881
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g7HGMiRw026549
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 16, 2002 at 04:01:48PM +0800, ±ÏÑ§Ò¢ wrote:

> hi, who is using sb1250/swarm board? i have mapped all the interrupts of
> second cpu to IP7(default IP2). after changing irq.c and irq_handler.S,
> second cpu can't get any interrupt. I don't know why it is. 

Did you enable IP7 on the second CPU?  I think it's off by default.

  Ralf
