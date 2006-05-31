Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 09:04:51 +0200 (CEST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:49137 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133463AbWEaHEm
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 09:04:42 +0200
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k4V74S8u010188;
	Wed, 31 May 2006 00:04:29 -0700 (PDT)
Received: from Ulysses ([192.168.2.6])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k4V74RtR005734;
	Wed, 31 May 2006 00:04:28 -0700 (PDT)
Message-ID: <002a01c6847f$98409480$0602a8c0@Ulysses>
From:	"Kevin D. Kissell" <KevinK@mips.com>
To:	"Bin Chen" <binary.chen@gmail.com>,
	"zhuzhenhua" <zzh.hust@gmail.com>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
References: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com> <5800c1cc0605302311p2d1f024bm96ac6e08cda1bc2f@mail.gmail.com>
Subject: Re: how to disable interrupt in application?
Date:	Wed, 31 May 2006 08:58:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

sigprocmask manages signals, which are user-mode abstractions
of exceptions.  It does not affect hardware interrupt behavior.
If by "uninterruptable", ZhuZhenHua means that the decoder
process will not get switched out in favor of another user-mode
process, then getpriority()/setpriority() provide some control
that may be sufficient.  If what is desired is that hardware interrupts
are actually masked during some critical sequence, the critical
sequence must be executed with kenel privilege - you need to
look at putting the critical sequence into a driver or other loadable
kernel module that can be invoked by the application code.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Bin Chen" <binary.chen@gmail.com>
To: "zhuzhenhua" <zzh.hust@gmail.com>
Cc: "linux-mips" <linux-mips@linux-mips.org>
Sent: Wednesday, May 31, 2006 8:11 AM
Subject: Re: how to disable interrupt in application?


> man sigprocmask
> 
> On 5/31/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> > our project have a video decoder code run as application. there is
> > some short code want to be run uninterruptable. is there anyway to do
> > it?
> > thanks for any hints
> > Best Regards
> >
> >
> > zhuzhenhua
> >
> >
> 
> 
