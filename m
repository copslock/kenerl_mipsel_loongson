Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OGFl223175
	for linux-mips-outgoing; Tue, 24 Jul 2001 09:15:47 -0700
Received: from highland.isltd.insignia.com (highland.isltd.insignia.com [195.217.222.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OGFkO23171
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 09:15:46 -0700
Received: from wolf.isltd.insignia.com (wolf.isltd.insignia.com [172.16.1.3])
	by highland.isltd.insignia.com (8.11.3/8.11.3/check_local4.2) with ESMTP id f6OGFi439494;
	Tue, 24 Jul 2001 17:15:44 +0100 (BST)
Received: from snow (snow.isltd.insignia.com [172.16.17.209])
	by wolf.isltd.insignia.com (8.9.3/8.9.3) with SMTP id RAA23814;
	Tue, 24 Jul 2001 17:15:44 +0100 (BST)
Message-ID: <013f01c1145b$e41dc420$d11110ac@snow.isltd.insignia.com>
From: "Andrew Thornton" <andrew.thornton@insignia.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc: "James Simmons" <jsimmons@transvirtual.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
Date: Tue, 24 Jul 2001 17:15:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert,

>> I guess this is not surprising because the Malta firmware isn't a PC
BIOS.
>
>If the RAGE XL is the officially supported video board for the Malta, I
>wouldn't have been surprised if its firmware would have contained code to
>initialize the RAGE XL. But unfortunately this doesn't seem to be the case.

I don't know if YAMON supports anything other than a serial terminal for its
console.

>Next question: is there sample code available (e.g. with the `supported' OS
for
>the Malta) to initialize the RAGE XL?

It has been pointed out to me that there is some source code, but this
originates from a non-suitable source for use in Linux. Need I say more?

Andrew Thornton
