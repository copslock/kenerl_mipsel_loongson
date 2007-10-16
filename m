Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 15:54:37 +0100 (BST)
Received: from spirit.analogic.com ([204.178.40.4]:23310 "EHLO
	spirit.analogic.com") by ftp.linux-mips.org with ESMTP
	id S20021629AbXJPOy3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2007 15:54:29 +0100
Received: from phoenix.analogic.com ([10.100.60.19]) by spirit.analogic.com with SMTP Service; Tue, 16 Oct 2007 10:53:57 -0400
Received:  from chaos.analogic.com ([10.112.50.11]) by phoenix.analogic.com with Microsoft SMTPSVC(6.0.3790.211); Tue, 16 Oct 2007 10:53:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received:  from chaos.analogic.com (localhost [127.0.0.1]) by chaos.analogic.com (8.12.11/8.12.11) with ESMTP id l9GErrD5011554; Tue, 16 Oct 2007 10:53:53 -0400
Received:  (from linux-os@localhost) by chaos.analogic.com (8.12.11/8.12.11/Submit) id l9GErrJm011553; Tue, 16 Oct 2007 10:53:53 -0400
X-OriginalArrivalTime: 16 Oct 2007 14:53:53.0513 (UTC) FILETIME=[5EB89D90:01C81004]
Content-class: urn:content-classes:message
Subject: Re: how to use TLB to prevent Linux accessing a particular memory region 
Date:	Tue, 16 Oct 2007 10:53:53 -0400
Message-ID: <Pine.LNX.4.61.0710161040001.11465@chaos.analogic.com>
In-reply-to: <431051.14949.qm@web8408.mail.in.yahoo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to use TLB to prevent Linux accessing a particular memory region 
Thread-Index: AcgQBF6/b08V6D2YRka+a0joDjSdKg==
References: <431051.14949.qm@web8408.mail.in.yahoo.com>
From:	"linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To:	"veerasena reddy" <veerasena_b@yahoo.co.in>
Cc:	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips" <linux-mips@linux-mips.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Return-Path: <linux-os@analogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-os@analogic.com
Precedence: bulk
X-list: linux-mips



On Tue, 16 Oct 2007, veerasena reddy wrote:

> Hi,
>
> I have a board, which has two processors ( one is MIPS
> on which Linux-2.6.18 kernel runs and another is DSP
> based processor) and 32MB DDR.
>
> Out of 32MB of DDR 8MB is reserved for use by DSP
> processor. But the MIPS processor downloads firmware
> into this reserved memory for the DSP.
>
> Now, is it possible to use the TLB to prevent Linux
> from accessing the reserved memory after the firmware
> has been downloaded?
>
> Also we'd need to remove those TLB entries if the
> firmware would ever need to be reloaded to the DSP'
> memory region.
>
> What are the APIs to be used to achieve the above?
>
>
> Thanks in advance.
>
> Regards,
> Veerasena.
>
>
>      5, 50, 500, 5000 - Store N number of mails in your inbox. Go to http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html
> -

Can't you just memory-map the area you need? That reserves it
until it's unmapped. You don't need to directly touch the TLB.
If you need a physical location, use ioremap_nocache() in your
driver. If you can't get your physical location because the
kernel already uses it, boot the kernel with mem=xxx on the
command-line to prevent the kernel from using memory you
want to reserve for your DSP. You can use num_physpages
(an integer) to find out the last page the kernel uses.

BTW, if this is a new design, most DSP devices put their
RAM on their own board so you don't have these problems.
That RAM gets mmaped to user-space as needed for access,
that address being set asside in PCI space.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.59 BogoMips).
My book : http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
