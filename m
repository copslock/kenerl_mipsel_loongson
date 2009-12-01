Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 02:48:11 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59658 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493242AbZLABsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 02:48:07 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB11mMSI006308;
        Tue, 1 Dec 2009 01:48:22 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB11mJqA006306;
        Tue, 1 Dec 2009 01:48:19 GMT
Date:   Tue, 1 Dec 2009 01:48:19 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
Message-ID: <20091201014819.GA29728@linux-mips.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
 <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
 <1259558432.5516.8.camel@falcon.domain.org>
 <1259562294.5516.16.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259562294.5516.16.camel@falcon.domain.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 30, 2009 at 02:24:54PM +0800, Wu Zhangjin wrote:

> > > +config YEELOONG_HWMON
> > > +	tristate "Hardware Monitor Driver"
> > > +	select HWMON
> > 
> > Will use depend in the next version.
> > 
> 
> Sorry, This must be select, there is no other way to select this stuff.

Why that?

  Ralf
