Received:  by oss.sgi.com id <S553952AbRAZJ7X>;
	Fri, 26 Jan 2001 01:59:23 -0800
Received: from mx.mips.com ([206.31.31.226]:61411 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553939AbRAZJ6y>;
	Fri, 26 Jan 2001 01:58:54 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA04550;
	Fri, 26 Jan 2001 01:58:50 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA06445;
	Fri, 26 Jan 2001 01:58:46 -0800 (PST)
Message-ID: <00e201c0877f$1acfdb80$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jun Sun" <jsun@mvista.com>
Cc:     "Pete Popov" <ppopov@mvista.com>,
        "Quinn Jensen" <jensenq@lineo.com>, <linux-mips@oss.sgi.com>
References: <3A6E132B.9000103@Lineo.COM> <3A6E1977.2B18484D@mvista.com> <3A6F36B8.4F10759B@mvista.com> <20010124163101.F863@bacchus.dhis.org>
Subject: Re: CONFIG_MIPS_UNCACHED
Date:   Fri, 26 Jan 2001 11:02:24 +0100
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

>
> > It is really surprising to know this.  It sounds like a CPU bug to me.
Can
> > some MIPS "gods" clarify if such a behaviour is a bug or allowed?
> >
> > BTW, the CPU in EV96100 is QED RM7000, I believe.
>
> If you want to be strictly correct you have to execute the code that
> disables caching of KSEG0 in uncached space like KSEG1, then flush the
> caches before you can resume execution in KSEG0.  Otherwise you might
> end up with dirty d-caches which when flushed will overwrite more
> uptodate data in memory.  The window is very small but yet exists if
> things are just right.

That's one possible failure mode.   The other is that there
are dirty lines (those that were brought into the cache and
modified by stores, but never written back to memory) that
are rendered invisible by forcing KSEG0 to go uncached.
This will cause failure of any code that is expecting to see
the results of those stores if said code executes before
some other event causes the write-back - and if the
machine is running with cacheing completely disabled,
as it would be in the case under discussion, such an
event may never occur!

            Regards,

            Kevin K.
