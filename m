Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MDoGn01852
	for linux-mips-outgoing; Tue, 22 Jan 2002 05:50:16 -0800
Received: from scan2.fhg.de (scan2.fhg.de [153.96.1.37])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MDoAP01846
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 05:50:10 -0800
Received: from scan2.fhg.de (localhost [127.0.0.1])
	by scan2.fhg.de (8.11.1/8.11.1) with ESMTP id g0MArDT27611;
	Tue, 22 Jan 2002 11:53:13 +0100 (MET)
Received: from esk.esk.fhg.de (esk.esk.fhg.de [153.96.161.2])
	by scan2.fhg.de (8.11.1/8.11.1) with ESMTP id g0MArCC27602;
	Tue, 22 Jan 2002 11:53:12 +0100 (MET)
Received: from esk.fhg.de (host4-40 [192.168.4.40])
	by esk.esk.fhg.de (8.9.3/8.9.3) with ESMTP id LAA27341;
	Tue, 22 Jan 2002 11:53:10 +0100 (MET)
Message-ID: <3C4D444A.CB30AC60@esk.fhg.de>
Date: Tue, 22 Jan 2002 11:51:54 +0100
From: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Organization: FhG - ESK
X-Mailer: Mozilla 4.7 [de] (WinNT; I)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
CC: bobm@alchemysemi.com
Subject: Re: usb-problems with Au1000
References: <3B7DA3A3.8010000@pacbell.net>
		<3C3DD208.45B5BC29@esk.fhg.de>
		<m3bsft6z87.wl@l5ac152.l5.laser5.co.jp>
		<1011294123.4550.58.camel@zeus>
		<m3advc6xhx.wl@l5ac152.l5.laser5.co.jp>
		<1011383349.18177.6.camel@zeus> <m37kqa7lpq.wl@l5ac152.l5.laser5.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

(I just repeat my last message with corrected subject)

Hi Bob,

>Hi Wolfgang,
>Have you been successful in getting the latest files?
>Thanks,
>Bob

Yes, thank you very much, now I really have Beta6 and Beta5.
But USB still doesn't work, I still get the message
"usb.c: USB device not accepting new address=3 (error=-145)"
everytime I plug in a USB device in J2. The same happens with J24.

Only one thing changed (look my Email in the newsgroup from January 10):
With Beta4-Version I always was getting the message
>>>
hub.c: USB new device connect on bus1/1, assigned device number 3
usb.c: USB device not accepting new address=3 (error=-145)
<<<
already during booting of the kernel, although there were no USB 
devices connected.
But with Beta6-Version I just get it when plugging in a device after
booting:
>>>
usb.c: USB device not accepting new address=2 (error=-145)
usb.c: USB device not accepting new address=3 (error=-145)
<<<

The version of the LSP is now
hhl-cross-mips_fp_le-lsp-alchemy-pb1000-2.4.2_hhl20-mb011105.2

The Pb1000 Board Serial Number is 5070.
Maybe you can tell me that the reason is just a buggy Au1000,
and perhaps USB is going to work, when we get our own Au1000-boards
with newer versions of the Au1000.

Thanks in advance

-- 
Wolfgang
