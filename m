Received:  by oss.sgi.com id <S554011AbQLER54>;
	Tue, 5 Dec 2000 09:57:56 -0800
Received: from mx.mips.com ([206.31.31.226]:12482 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554004AbQLER5s>;
	Tue, 5 Dec 2000 09:57:48 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA20445;
	Tue, 5 Dec 2000 09:57:43 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA26082;
	Tue, 5 Dec 2000 09:57:40 -0800 (PST)
Message-ID: <01c701c05ee5$587a36a0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Nicu Popovici" <octavp@isratech.ro>, <linux-mips@oss.sgi.com>
References: <3A2D60BB.311D4ECA@isratech.ro>
Subject: Re: MIPS ext2fs problem.
Date:   Tue, 5 Dec 2000 19:00:58 +0100
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

> I did port the ATLAS support from linux-2.2.12 kernel into linux-2.2.14
> . I saw that there is a problem, if I reset the computer in an unusual
> way  then at restart it tries to do e2fsck on the hdd. My problem is
> that when I run linux 2.2.14 ( for ATLAS , that we ported ) it get
> stucked in running e2fsck. Do you have any ideea of what is happening ?

Are you using SCSI disks, and if so, did you merge the
SCSI driver from the MIPS 2.2.12 kernel into your 2.2.14
base?  The standard distribution of that driver wasn't 100%
cache safe for MIPS, and probably still isn't.

            Regards,

            Kevin K.
