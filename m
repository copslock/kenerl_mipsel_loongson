Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LK5Tf20660
	for linux-mips-outgoing; Thu, 21 Mar 2002 12:05:29 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LK5Mq20652
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 12:05:23 -0800
Received: from prefect (prefect.local [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 02026590B2; Thu, 21 Mar 2002 15:02:05 -0500 (EST)
Message-ID: <017701c1d114$2a1bca60$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <Andre.Messerschmidt@infineon.com>, <linux-mips@oss.sgi.com>
References: <86048F07C015D311864100902760F1DD01B5E828@dlfw003a.dus.infineon.com>
Subject: Re: Kernel compile with -O0
Date: Thu, 21 Mar 2002 15:06:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

That turns off inlining, which the kernel *requires*.

Regards,
Brad

----- Original Message -----
From: <Andre.Messerschmidt@infineon.com>
To: <linux-mips@oss.sgi.com>
Sent: Thursday, March 21, 2002 1:36 PM
Subject: Kernel compile with -O0


> Hi.
>
> When I try to compile my 2.4.3 Kernel with -O0 I get a lot of undefined
> references to functions like __cli, clear_bit etc. during linking.
With -O1
> it works.
>
> Do I have to provide some special compile option to make this work?
>
> best regards
> --
> Andre Messerschmidt
>
> Application Engineer
> Infineon Technologies AG
>
