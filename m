Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 10:09:56 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:9256
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225202AbTDOJJz>; Tue, 15 Apr 2003 10:09:55 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h3F99har010521;
	Tue, 15 Apr 2003 11:09:43 +0200
Message-ID: <3E9BCC57.5070809@murphy.dk>
Date: Tue, 15 Apr 2003 11:09:43 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: rtc_[gs]et_time()
References: <Pine.GSO.4.21.0304151021320.26578-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:

>This makes it more complex to make drivers/char/genrtc.c work on MIPS, since 
>usually the date and time have to be converted twice: once from struct rtc_time
>to seconds in <asm/rtc.h>, and once from seconds to struct rtc_time in each RTC
>driver.
>
>Is it OK to make rtc_[gs]et_time() always use struct rtc_time?
>
>  
>
I quite like it the way it is ;-).

/Brian

LASAT port maintainer.
