Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2R8OGG31164
	for linux-mips-outgoing; Wed, 27 Mar 2002 00:24:16 -0800
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2R8ODq31161
	for <linux-mips@oss.sgi.com>; Wed, 27 Mar 2002 00:24:14 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA27201;
	Wed, 27 Mar 2002 00:26:26 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA20681;
	Wed, 27 Mar 2002 00:26:28 -0800 (PST)
Message-ID: <002301c1d569$4af46ea0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "David Milburn" <dmilburn@redhat.com>, <linux-mips@oss.sgi.com>
References: <3CA10449.F0088B95@redhat.com>
Subject: Re: PCI ethernet cards
Date: Wed, 27 Mar 2002 09:26:50 +0100
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

> Can anyone recommend some PCI 100 Mbit ethernet cards/drivers
> that work well with the 2.4 linux-mips kernel?

At MIPS, we use AMD PCnet32 cards pretty exclusively,
and with good success under both 2.2 and 2.4.  For 2.2,
we did a pretty thorough reworking of the driver to deal with 
MIPS endianness and (especially) cache issues, but I believe
we use the 2.4 driver "out of the box".  YMMV, of course.

            Kevin K.
