Received:  by oss.sgi.com id <S554287AbRASWfn>;
	Fri, 19 Jan 2001 14:35:43 -0800
Received: from mx.mips.com ([206.31.31.226]:61435 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554284AbRASWfe>;
	Fri, 19 Jan 2001 14:35:34 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA04487;
	Fri, 19 Jan 2001 14:35:29 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA27212;
	Fri, 19 Jan 2001 14:35:27 -0800 (PST)
Message-ID: <01c701c08268$a4965860$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     <carlson@sibyte.com>, <linux-mips@oss.sgi.com>
References: <0101191014100B.01043@plugh.sibyte.com>
Subject: Re: R[45]KC PRiD fields?
Date:   Fri, 19 Jan 2001 23:39:09 +0100
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

> Does anyone happen to know what the R4Kc anc R5KC use for the company ID
of the
> PrID register (bits 23-16)?  I'm assuming it's 1, which is reserved for
MTI,
> but bits 15-8 seem to be carefully chosen not to conflict with previous
> processors in the non-MIPS32/MIPS64 PRiD space.

The MIPS 4KC has a PrID of 0x000180xx
The MIPS 5KC has a PrID of 0x000181xx

            Kevin K.
