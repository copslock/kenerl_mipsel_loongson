Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 22:18:06 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.235]:46401 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022046AbYEGVSD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 22:18:03 +0100
Received: by wx-out-0506.google.com with SMTP id s13so471779wxc.21
        for <linux-mips@linux-mips.org>; Wed, 07 May 2008 14:18:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=vYUxK9X2VZYS2ZwSs+l6TPTDDkrGQ6bbLsBl/iyXVIM=;
        b=ffFR2fD9Q4qjfkuznU11MlLAiDtzvaE7PIlyaMSK1YWulGwqZNDE9XcB2EmZg+Z5TBB7TeXvwvPiGDneNa74OkOBUgkk2ZQr5UGgjrj6pLmoflebNHsK5xw+y5O2tO3vKiU0UlUoEUcESwbuseYqlfXw+aHqFVJgFPGjvTSbeaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ttJn/Jx5mARiaEaz6swkHzKI/iD15Bf53CCBNt6wOARWvvaL2ThvMS4ra1OAGI44S6oLNwjclwT8WT8rzFDlDj5xNxmUQCDDCUg4KDCF3kl47JTZuRf0NoE9sUHEmAoyd6fMe68elmitdU05Y6bUghKk29esmUf1FdhirEy8cfQ=
Received: by 10.90.31.8 with SMTP id e8mr3584641age.22.1210195081778;
        Wed, 07 May 2008 14:18:01 -0700 (PDT)
Received: by 10.90.92.13 with HTTP; Wed, 7 May 2008 14:18:01 -0700 (PDT)
Message-ID: <1f1b08da0805071418q365680bexafb1996dcc77ebb0@mail.gmail.com>
Date:	Wed, 7 May 2008 14:18:01 -0700
From:	"john stultz" <johnstul@us.ibm.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC][PATCH 1/4] RTC: Class device support for persistent clock
Cc:	"Alessandro Zummo" <a.zummo@towertech.it>,
	"Jean Delvare" <khali@linux-fr.org>,
	"Ralf Baechle" <ralf@linux-mips.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
X-Google-Sender-Auth: 590bf975fa113a09
Return-Path: <johnstul.lkml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips

On Tue, May 6, 2008 at 5:40 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>  This is a generic implementation of rtc_read_persistent_clock() and
>  rtc_update_persistent_clock() suitable for platforms to be used for
>  read_persistent_clock() and update_persistent_clock() calls.  An RTC
>  device selected by the user with the RTC_HCTOSYS_DEVICE option is used.
>
>   As rtc_read_persistent_clock() is not available at the time
>  timekeeping_init() is called, it will now be disabled if the class device
>  is to be used as a reference.  In this case rtc_hctosys(), already
>  present, will be used to set up the system time at the late initcall time.
>  This call has now been rewritten to make use of
>  rtc_read_persistent_clock().

Hrmm. So how is this going to work with suspend and resume?

Ideally, on resume we want to update the clock before interrupts are
reenabled so we don't get stale time values post-resume.  For systems
that sleep on reading the persistent clock, I'm open to having them
fix it up as best they can later (partly why the code can handle
read_persistent_clock() not returning anything), but unless I'm
misreading this, it seems you're proposing to make systems that do
have a safe persistent clock have to have the window where code may
see the pre-suspend time after resume.

Am I missing something here?

thanks
-john

Maciej: Sorry for the dup, I forgot to reply to all on my first mail.
