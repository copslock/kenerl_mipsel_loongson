Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 17:20:02 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:28895 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8225594AbUBWRT7>;
	Mon, 23 Feb 2004 17:19:59 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i1NHBfh3015344;
	Mon, 23 Feb 2004 09:11:41 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i1NHJmuk014205;
	Mon, 23 Feb 2004 09:19:49 -0800 (PST)
Message-ID: <006001c3fa31$74c07fa0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Mark and Janice Juszczec" <juszczec@hotmail.com>,
	<linux-mips@linux-mips.org>
Cc:	<uhler@mips.com>, <dom@mips.com>, <echristo@redhat.com>
References: <Law10-F123ODt9Cz93M0000b89a@hotmail.com>
Subject: Re: r3000 instruction set
Date:	Mon, 23 Feb 2004 18:21:19 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Someone suggested posting the message I get.  Here it is:
> 
> >./kaffe-bin FirstClass
> [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0, 
> P0_STATUS=0000500
> pid 6: killed (signal 4)
> >Reading command line: Try again
> Kernel panic: Attmpted to kill int!

Let me guess.  You are running little-endian.  The instruction word
in memory would be 0x6a697406.  Do you think it's a coincidence
that 0x6a6974 spells "jit" in ASCII?  ;o)

The reported address range looks like that where kaffe builds its
JITted instruciton buffers in MIPS/Linux.  And, like I say, JIT is
somewhat broken for MIPS in Kaffe.  Which version of the kaffe sources 
are you building, and have you tried configuring with --with-engine=intrp
as I suggested?

            Regards,

            Kevin K.
