Received:  by oss.sgi.com id <S554268AbRBERBz>;
	Mon, 5 Feb 2001 09:01:55 -0800
Received: from mx.mips.com ([206.31.31.226]:18830 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553839AbRBERBb>;
	Mon, 5 Feb 2001 09:01:31 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA01961;
	Mon, 5 Feb 2001 09:01:28 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA06230;
	Mon, 5 Feb 2001 09:01:26 -0800 (PST)
Message-ID: <007701c08f94$7de62360$10eca8c0@grendel>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Quinn Jensen" <jensenq@lineo.com>,
        "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux-mips@oss.sgi.com>
References: <3A79C869.2040001@Lineo.COM> <20010204194451.A26868@bacchus.dhis.org> <3A7ED9EB.6080801@Lineo.COM>
Subject: Re: NFS root with cache on
Date:   Mon, 5 Feb 2001 17:55:39 +0100
Organization: MIPS Technologies, Inc.
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

> Another thing that has been haunting me is that
> in 2.3.99pre8, kmalloc() has and #ifdef __mips__ that
> flushes the cache and bumps the address up to KSEG1.

That's really hideous!  When did that happen?
It'll sure help cache coherency problems, but
the performance impact must have been monstrous.

            Kevin K.
