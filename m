Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4RE1nnC006671
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 07:01:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4RE1nsa006670
	for linux-mips-outgoing; Mon, 27 May 2002 07:01:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4RE1lnC006667
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 07:01:47 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id HAA03804;
	Mon, 27 May 2002 07:02:54 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA20057;
	Mon, 27 May 2002 07:02:54 -0700 (PDT)
Message-ID: <029b01c20588$16335830$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
   "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: "Linux/MIPS Development" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0205271534430.15706-100000@vervain.sonytel.be>
Subject: Re: PCI Graphics/Video Card for Malta Board?
Date: Mon, 27 May 2002 16:09:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> One of the exceptions is matroxfb, which is able to initialize older Matrox
> cards. This should cover all their PCI cards (Matrox didn't release any new PCI
> cards during the last few years).

They still sell/support the G450PCI, which has TV output support,
and a flat-panel transmitter, and which might do the job for me.
Can anyone confirm that the matroxfb support works for it?

            Kevin K.
