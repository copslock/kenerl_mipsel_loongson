Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 16:25:40 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:64381 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491174Ab1EXOZh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2011 16:25:37 +0200
Received: by iyb39 with SMTP id 39so6473527iyb.36
        for <multiple recipients>; Tue, 24 May 2011 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=uCDWUZx5oOfCfie2Cgio0cNwcHlkb0glonmKvDynP7Q=;
        b=stcdEx+lNpdas/zeT8FSabwXhUl3aL8iwqpvCp5ufYfPuqo1298daMNzgKcX2AIbGA
         9SurPcFXKyyLejtDHdBHNGZM2FviIx0fusNu3GJmQLTqmWpLWoE94YiSC6X3IAW5Xig0
         9gON7F7Z2ybdFi+uKAaM0tr2eiRUXi1k8smII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Uq7DLmuGYtpRUoqiLRRl5iPDQ1CQqk5/W5+AKaJbZDS1TAKxUcE5R+JZYzGvvR5j5x
         DrhlpASu+Wm82bQ7XW1jHLVn2BoXB5SNNMuOe7SOjJPSe5t7h5WvrmbD7WzhXX4xMyjT
         qiCqQI/+zyutblf8dkJdNfe+r4+wzs2+d739Q=
Received: by 10.42.217.137 with SMTP id hm9mr10995983icb.196.1306247130317;
        Tue, 24 May 2011 07:25:30 -0700 (PDT)
Received: from [192.168.0.107] ([182.32.187.185])
        by mx.google.com with ESMTPS id gy41sm3395833ibb.56.2011.05.24.07.25.20
        (version=SSLv3 cipher=OTHER);
        Tue, 24 May 2011 07:25:29 -0700 (PDT)
Subject: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
From:   Wanlong Gao <wanlong.gao@gmail.com>
Reply-To: wanlong.gao@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Pengfei Zhang <zoppof.zhang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Linux kernel
Date:   Tue, 24 May 2011 22:25:12 +0800
Message-ID: <1306247112.2066.8.camel@Tux>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wanlong.gao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wanlong.gao@gmail.com
Precedence: bulk
X-list: linux-mips


> On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:
> 
> > Remove the resume and shutdown of i8259A from the sysdev_class
> > to the syscore_ops since these members had removed from the
> > structure sysdev_class.
> 
> I don't see why one would want to want to first call
> register_syscore_ops
> then sysdev_class_register and sysdev_register?
> 
Hi Ralf:
If these not moved to syscore_ops, building will get error.

Hi Thomas:
Does you mean that we can just remove the sysfs entry now ?


Thanks
Best regards

Wanlong Gao
