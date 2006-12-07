Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 07:34:50 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:35516 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038727AbWLGHep (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 07:34:45 +0000
Received: by nf-out-0910.google.com with SMTP id l24so758955nfc
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 23:34:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lCLsEwv1uZZn+JyEmE36G1pSNHTENzaE8SaKwiwtCkgGqv8AMmtbQvRAb/Q/J3m6CiHdyBPdEwNb4RV1BEL/AkEoQaJelNtud2dn2VNhwsCBhUfABiNMAv/utLUMqqanxrqSct65INKQHnCFwXIUpOJ5AsLEpJEo/YinM59zsdc=
Received: by 10.49.7.10 with SMTP id k10mr3411715nfi.1165476883430;
        Wed, 06 Dec 2006 23:34:43 -0800 (PST)
Received: by 10.78.123.2 with HTTP; Wed, 6 Dec 2006 23:34:43 -0800 (PST)
Message-ID: <cda58cb80612062334h65d1b19di29ea71fecaf8015a@mail.gmail.com>
Date:	Thu, 7 Dec 2006 08:34:43 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] Import updates from i386's i8259.c
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20061207.121702.108739943.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205194907.GA1088@linux-mips.org>
	 <20061205195702.GA2097@linux-mips.org>
	 <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com>
	 <20061207.121702.108739943.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/7/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Wed, 6 Dec 2006 09:40:50 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > Atsushi, could you take care of removing "select
> > GENERIC_HARDIRQS_NO__DO_IRQ" in your patch where needed ? specially
> > all boards based on NEC VR41XX cpu.
>
> You mean "adding" ?  I think now we can select
> GENERIC_HARDIRQS_NO__DO_IRQ for all MACH_VR41XX boards.
>

yes sorry. I was thinking of removing all of them in
arch/mips/vr41xx/Kconfig, and add it to MACH_VR41XX config and all
others configs that were using the i8259.

-- 
               Franck
