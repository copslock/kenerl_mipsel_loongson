Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAJDVMM25683
	for linux-mips-outgoing; Mon, 19 Nov 2001 05:31:22 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAJDVEW25675;
	Mon, 19 Nov 2001 05:31:14 -0800
Received: from wine.digital-digital.com ([210.122.73.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00373; Mon, 19 Nov 2001 04:31:12 -0800 (PST)
	mail_from (khs@digital-digital.com)
Received: from khs ([210.122.73.37])
	by wine.digital-digital.com (8.11.0/8.11.0) with SMTP id fAJCB9Q16460;
	Mon, 19 Nov 2001 21:11:09 +0900
Reply-To: <khs@digital-digital.com>
From: "Han-Seong Kim" <khs@digital-digital.com>
To: "'Ralf Baechle'" <ralf@oss.sgi.com>
Cc: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: RE: Power MGMT on mips
Date: Mon, 19 Nov 2001 21:13:08 +0900
Message-ID: <000001c170f3$8d784d80$cbadfea9@khs>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <20011112233031.A6493@dea.linux-mips.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id fAJDVFW25676
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Ralf,

I reviewed the data sheet of Mips CPU - QED RM5231.
There is a wait instruction.
But when the SysAD bus goes to idle, the wait instruction is valid.
How can I SysAD bus make idle state?

Han-Seong

-----Original Message-----
From: Ralf Baechle [mailto:ralf@oss.sgi.com]
Sent: Monday, November 12, 2001 9:31 PM
To: Han-Seong Kim
Cc: linux-mips@fnet.fr; linux-mips@oss.sgi.com
Subject: Re: Power MGMT on mips


On Mon, Nov 12, 2001 at 05:13:40PM +0900, Han-Seong Kim wrote:

> I want to ask about Power-Mnagement on mips.
> 1. Is it possible to use power mgnt (ex. apm,acpi) features of linux kernel?

Both are PC stuff, so no.

> 2.If no, how can manage CPU and Bidge chips for power mgnt ?

Right now Linux/MIPS will only use the CPU's power managment features, that
is the wait instruction or similar.

  Ralf
