Received:  by oss.sgi.com id <S553742AbQJUWp6>;
	Sat, 21 Oct 2000 15:45:58 -0700
Received: from mx.mips.com ([206.31.31.226]:14323 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553736AbQJUWpu>;
	Sat, 21 Oct 2000 15:45:50 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA18337;
	Sat, 21 Oct 2000 15:45:29 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA01282;
	Sat, 21 Oct 2000 15:45:42 -0700 (PDT)
Message-ID: <00f001c03bb1$189f09e0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>
Cc:     <linux-mips@oss.sgi.com>
References: <20001021212318.C3619@paradigm.rfc822.org> <00d301c03b9b$d5ce2340$0deca8c0@Ulysses> <20001021222904.C4004@paradigm.rfc822.org>
Subject: Re: oops in lance initialization / diskboot
Date:   Sun, 22 Oct 2000 00:48:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> But from the source i see that the driver assumes the Lance
> is inactive and starts with setting up DMA instead of first
> resetting the Card. 

Baaaaad idea.

>I'll try that first.

It will no doubt help, but unless you shut it down in the
bootloader, you will always have a race between the 
driver init routine and the arrival of the Packet of Death.

            Kevin K.
