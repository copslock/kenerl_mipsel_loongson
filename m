Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1K3iwu02059
	for linux-mips-outgoing; Tue, 19 Feb 2002 19:44:58 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1K3ik902055
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 19:44:52 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 6110B590A9; Tue, 19 Feb 2002 21:35:04 -0500 (EST)
Message-ID: <002501c1b9b8$a87addb0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Robert Rusek" <robru@teknuts.com>, <linux-mips@oss.sgi.com>
References: <000901c1b9b0$51cdd0b0$0f1610ac@delllaptop>
Subject: Re: Error Compiling 2.4.3 kernel on SGI IP22...
Date: Tue, 19 Feb 2002 21:45:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Check your arch/mips/ld.script file.  I think you need to remove the
OUTPUT_FORMAT line in there.  This was fixed in CVS on May 10, 2001; your
snapshot might be right before that.

Regards,
Brad

----- Original Message -----
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Sent: Tuesday, February 19, 2002 8:45 PM
Subject: Error Compiling 2.4.3 kernel on SGI IP22...


> make[1]: Entering directory `/usr/src/linux-2.4.3/arch/mips/kernel'
<snip>
> mips-linux-ld: target elf32-bigmips not found
> make: *** [vmlinux] Error 1
