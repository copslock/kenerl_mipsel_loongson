Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 17:21:16 +0100 (CET)
Received: from elettra.colt-to.towertech.it ([213.215.222.70]:47341 "EHLO
        elettra.colt-to.towertech.it" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493526AbZLCQVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 17:21:12 +0100
Received: from linux.lan.towertech.it (93-39-58-60.ip74.fastwebnet.it [93.39.58.60])
        by elettra.colt-to.towertech.it (Postfix) with ESMTPSA id E8EF8116649;
        Thu,  3 Dec 2009 17:21:10 +0100 (CET)
Date:   Thu, 3 Dec 2009 17:21:10 +0100
From:   Alessandro Zummo <a.zummo@towertech.it>
To:     rtc-linux@googlegroups.com
Cc:     wuzhangjin@gmail.com, Ralf Baechle <ralf@linux-mips.org>,
        Arnaud Patard <apatard@mandriva.com>,
        linux-mips@linux-mips.org, Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [rtc-linux] [PATCH v1 3/3] [loongson] RTC: Registration of
 Loongson RTC platform device
Message-ID: <20091203172110.30fb0635@linux.lan.towertech.it>
In-Reply-To: <a597312c16b5cf32621a25e8444d15d23726727f.1257383766.git.wuzhangjin@gmail.com>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
        <a597312c16b5cf32621a25e8444d15d23726727f.1257383766.git.wuzhangjin@gmail.com>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.95.2 at elettra
X-Virus-Status: Clean
Return-Path: <a.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Thu,  5 Nov 2009 09:24:10 +0800
Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> user-space configuration:
> 
> $ mknod /dev/rtc0 c 254 0

 That's not guaranteed. 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
