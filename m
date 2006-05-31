Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 11:36:05 +0200 (CEST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:10739 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133496AbWEaJf6
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 11:35:58 +0200
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k4V9ZiIb010439;
	Wed, 31 May 2006 02:35:49 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k4V9Zhku008907;
	Wed, 31 May 2006 02:35:43 -0700 (PDT)
Message-ID: <002501c68496$2e7f8df0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"zhuzhenhua" <zzh.hust@gmail.com>
Cc:	"Bin Chen" <binary.chen@gmail.com>,
	"linux-mips" <linux-mips@linux-mips.org>
References: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com> <5800c1cc0605302311p2d1f024bm96ac6e08cda1bc2f@mail.gmail.com> <002a01c6847f$98409480$0602a8c0@Ulysses> <50c9a2250605310037n42dd6ddct2238cf9c56eac40d@mail.gmail.com>
Subject: Re: how to disable interrupt in application?
Date:	Wed, 31 May 2006 11:39:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> actually i don't want the pipelining be interrupted while run our user
> defined instructions.

If you want to guarantee that, you need to put that code into a kernel
module that turns off interrupts during processing - and you need to
accept responsibility for the fact that a problem in your code may be
irrecoverably fatal to the system, and that errors in system timing may
accumulate due to clock interrupts not being serviced.

            Regards,

            Kevin K.
