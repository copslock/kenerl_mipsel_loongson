Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 10:12:38 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225202AbTDOJMi>; Tue, 15 Apr 2003 10:12:38 +0100
Date: Tue, 15 Apr 2003 10:12:38 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Brian Murphy <brian@murphy.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rtc_[gs]et_time()
Message-ID: <20030415101238.C29593@ftp.linux-mips.org>
References: <Pine.GSO.4.21.0304151021320.26578-100000@vervain.sonytel.be> <3E9BCC57.5070809@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9BCC57.5070809@murphy.dk>; from brian@murphy.dk on Tue, Apr 15, 2003 at 11:09:43AM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 11:09:43AM +0200, Brian Murphy wrote:
> Geert Uytterhoeven wrote:
> 
> >This makes it more complex to make drivers/char/genrtc.c work on MIPS, since 
> >usually the date and time have to be converted twice: once from struct rtc_time
> >to seconds in <asm/rtc.h>, and once from seconds to struct rtc_time in each RTC
> >driver.
> >
> >Is it OK to make rtc_[gs]et_time() always use struct rtc_time?
> >
> I quite like it the way it is ;-)

While I would like to see rtc_[gs]et_time() always use struct rtc_time ;)

	ladis
