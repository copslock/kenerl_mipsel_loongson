Received:  by oss.sgi.com id <S553912AbRCHQu7>;
	Thu, 8 Mar 2001 08:50:59 -0800
Received: from mx.mips.com ([206.31.31.226]:43233 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553845AbRCHQus>;
	Thu, 8 Mar 2001 08:50:48 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA05178;
	Thu, 8 Mar 2001 08:50:47 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA29098;
	Thu, 8 Mar 2001 08:50:44 -0800 (PST)
Message-ID: <01b701c0a7f0$79260ba0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, <heinold@physik.tu-cottbus.de>,
        <linux-mips@oss.sgi.com>
References: <3AA7B13F.F918E1F8@ti.com> <20010308173003.A17217@physik.tu-cottbus.de> <20010308174044.B11107@bacchus.dhis.org>
Subject: Re: Question concerning Assembler error
Date:   Thu, 8 Mar 2001 17:54:29 +0100
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

> > Hm sorry cant help with the assembler problem, but which machine
> > has a 4600 Prozessor and run mipsel on it?
> 
> RM200C.

Actually, It's far more likely that Jeff is working with a
MIPS 4KC or 5KC CPU core.  -mcpu=r4600 ends up
being the closest fit to the MIPS32 ISA and pipeline
among the options available for the Linux-capable
gcc compilers.

            Kevin K.
