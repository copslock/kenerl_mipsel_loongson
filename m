Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 23:00:15 +0100 (CET)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:50485 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbaKJWALwkvHS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 23:00:11 +0100
Received: by mail-pd0-f176.google.com with SMTP id ft15so8662308pdb.21
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 14:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=DOvHW3b41N9MIL2KbsYLOnh3H89QEr5vVcY6ZnLAyBg=;
        b=X1RfXZXmgdyDHJlCRENe959kM/BmkhGVMwza7PFO6mRTj+u4FUwtMbXIBTr0TFiWkF
         BvWnU1uiqmozvA4ae2u9J33wN/iYtmX6ugMgoscoVW13Uu6fWkFLSHBGzkf5hxYfZEv0
         35HbJReXEkMgIrJsJtQ/OKn41AnowvEZah4wGR0TOmhF+bkvwk1l2JBkNiuzyrfR5DYL
         OWpkJUwVdaDnvLqjZlr2CKlvMkhQk6ugH5Ej/RLbduDIWRQXFxQXC5TZIt5lvgj4YqBe
         bdgMGHfBKv4g8xJC29u1zjrg+FxTBLZR8XjuNskD2mWl/0+hb3hrCSQYzozHhqhCHDt4
         KqVw==
X-Gm-Message-State: ALoCoQnI0+kZZC65dqgk07c2bpy1KYT+T1/yfwUA2LgO+newmSoF7uJlZB1pn9dTrfS5qxb2uSTB
X-Received: by 10.66.90.230 with SMTP id bz6mr6963617pab.125.1415656805418;
        Mon, 10 Nov 2014 14:00:05 -0800 (PST)
Received: from localhost (c-67-183-17-239.hsd1.wa.comcast.net. [67.183.17.239])
        by mx.google.com with ESMTPSA id db7sm17471299pdb.27.2014.11.10.14.00.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 14:00:04 -0800 (PST)
From:   Kevin Hilman <khilman@kernel.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org,
        arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, nicolas.ferre@atmel.com,
        alexandre.belloni@free-electrons.com,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 04/14] genirq: Generic chip: Add big endian I/O accessors
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
        <1415342669-30640-5-git-send-email-cernekee@gmail.com>
Date:   Mon, 10 Nov 2014 14:00:02 -0800
In-Reply-To: <1415342669-30640-5-git-send-email-cernekee@gmail.com> (Kevin
        Cernekee's message of "Thu, 6 Nov 2014 22:44:19 -0800")
Message-ID: <7hy4riogwt.fsf@deeprootsystems.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <khilman@deeprootsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khilman@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Kevin Cernekee <cernekee@gmail.com> writes:

> Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
> the irqchip.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

I bisected a couple ARM boot failures in next-20141110 on atmel sama5 platforms down to
this patch, though I'm not quite yet sure how it's causing the failure.
I'm not getting any console output, so haven't been able to dig deeper
yet.  Maybe the atmel maintainers (Cc'd) can help dig.

I've confirmed that reverting $SUBJECT patch (commit
b79055952badbd73710685643bab44104f2509ea2) on top of next-20141110 gets
things booting again.

Also, it only happens with sama5_defconfig, not with multi_v7_defconfig.

Kevin
