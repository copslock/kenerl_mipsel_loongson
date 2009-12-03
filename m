Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 18:11:22 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40452 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493569AbZLCRLQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Dec 2009 18:11:16 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB3HBD6o006228;
        Thu, 3 Dec 2009 17:11:13 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB3HBCIo006226;
        Thu, 3 Dec 2009 17:11:12 GMT
Date:   Thu, 3 Dec 2009 17:11:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>
Cc:     rtc-linux@googlegroups.com, wuzhangjin@gmail.com,
        Arnaud Patard <apatard@mandriva.com>,
        linux-mips@linux-mips.org, Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [rtc-linux] [PATCH v1 3/3] [loongson] RTC: Registration of
 Loongson RTC platform device
Message-ID: <20091203171112.GA24493@linux-mips.org>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
 <a597312c16b5cf32621a25e8444d15d23726727f.1257383766.git.wuzhangjin@gmail.com>
 <20091203172110.30fb0635@linux.lan.towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091203172110.30fb0635@linux.lan.towertech.it>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 03, 2009 at 05:21:10PM +0100, Alessandro Zummo wrote:

> > user-space configuration:
> > 
> > $ mknod /dev/rtc0 c 254 0
> 
>  That's not guaranteed. 

Thanks, I've fixed that comment.

  Ralf
