Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jan 2004 21:46:35 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:58241 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225341AbUADVqe>;
	Sun, 4 Jan 2004 21:46:34 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id i04Le6CE001490;
	Sun, 4 Jan 2004 13:40:06 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA25605;
	Sun, 4 Jan 2004 13:46:19 -0800 (PST)
Message-ID: <001701c3d30c$4d0223c0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "karthikeyan natarajan" <karthik_96cse@yahoo.com>,
	<linux-mips@linux-mips.org>
References: <20040104090922.35955.qmail@web10102.mail.yahoo.com>
Subject: Re: Regarding the LL & SC instructions
Date: Sun, 4 Jan 2004 22:47:06 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

You can modify any, all, or none of the bytes in a word loaded/stored
with LL/SC.  What you *can't* do is independently  LL/SC individual 
bytes within the same memory word, but operationally, this is of little
consequence.  If you want to atomically modify a byte, you LL the word
containing the byte, modify the byte in question, and SC the word.
If the SC succeeds, all is as you wish.  If the SC fails, you need to
retry the whole sequence.

----- Original Message ----- 
From: "karthikeyan natarajan" <karthik_96cse@yahoo.com>
To: <linux-mips@linux-mips.org>
Sent: Sunday, January 04, 2004 10:09
Subject: Regarding the LL & SC instructions


> Hi All,
> 
>     Seems that LL & SC instrutions operate on a 'word'
> data.
>     Can we use the same instructions to do a atomic
> increment on a 'byte' data. If not, are there any
> specific instructions to operate on a byte data?
> (Like, LLD & SCD for doubleword data) or else, any 
> method to achieve this using the LL & SC instr?
> 
> Thanks much,
> -karthi
> 
> 
> =====
> The expert at anything was once a beginner
> 
> ________________________________________________________________________
> Yahoo! Messenger - Communicate instantly..."Ping" 
> your friends today! Download Messenger Now 
> http://uk.messenger.yahoo.com/download/index.html
> 
> 
