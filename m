Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 23:03:11 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:33752 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133508AbWAIXCx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 23:02:53 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id E0FDC709A4;
	Tue, 10 Jan 2006 00:05:55 +0100 (CET)
X-Auth-Info: DoUMI+ncKDIHJ3bvPx28S3wmpFjkruShDtx+NMfL6yM=
X-Auth-Info: DoUMI+ncKDIHJ3bvPx28S3wmpFjkruShDtx+NMfL6yM=
X-Auth-Info: DoUMI+ncKDIHJ3bvPx28S3wmpFjkruShDtx+NMfL6yM=
X-Auth-Info: DoUMI+ncKDIHJ3bvPx28S3wmpFjkruShDtx+NMfL6yM=
Received: from mail.denx.de (p54966F34.dip.t-dialin.net [84.150.111.52])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id C7905B8CE8;
	Tue, 10 Jan 2006 00:05:55 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 6B62A6D00A8;
	Tue, 10 Jan 2006 00:05:55 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 5A961354115;
	Tue, 10 Jan 2006 00:05:55 +0100 (MET)
To:	"Mitchell, Earl" <earlm@mips.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>,
	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: [processor frequency] 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 09 Jan 2006 14:00:50 PST."
             <3CB54817FDF733459B230DD27C690CEC010495E3@Exchange.MIPS.COM> 
Date:	Tue, 10 Jan 2006 00:05:55 +0100
Message-Id: <20060109230555.5A961354115@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

Hello,

in message <3CB54817FDF733459B230DD27C690CEC010495E3@Exchange.MIPS.COM> you wrote:
> 
> The desktop/server guys typically use much larger caches (i.e. >= 512K)
> and most have L2, compared to embedded systems which typically use less
> without an L2. So I'd also expect embedded guys using small caches to see 
> larger decreases in performance due to more cache misses (i.e. more 
> interrupts produce more evictions). 

Corrent. FYI: the system used in my tests is a PowerPC at 50 MHz  CPU
clock with 4 kB I-Cache and 4 kB D-Cache ...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one instruction - from which, by induction, one can deduce that every
program can be reduced to one instruction which doesn't work.
