Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 19:45:21 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:36400
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993912AbdH1RpNt2H03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2017 19:45:13 +0200
Received: by mail-qt0-x243.google.com with SMTP id e2so1024857qta.3
        for <linux-mips@linux-mips.org>; Mon, 28 Aug 2017 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=anbkQVw7X10o2caYTRaJPG4CDDlaf2zs/P7UPEynpaU=;
        b=WFXgQpp9sdRs+vE4Q9JEvcosVsc7D7zooJRhGJj91DkdkPbXEA/y2CxAh1CR6YaBjf
         LLA1UNXZUafaMgde36RwaMaomLokMTOZkpXtEkkY7honcbGopeRjiTsjz/bPdQZXE0lv
         DnzreplFxkFCX9Yk6S3J8/zuUK/6UX1EdenSJhI0Bu6g9yxDGFJwa3gVZpwRhBsmFrI3
         AJEf/9O6ebyv9wQdoznMgkWMlZa6EFlMqYsSp7KBnmLSnHELdK6hBD60Ysad7HMmcJzg
         tbWEOQExZOu1gAm9C5i0Zs7/XFCHju+hwzxBtQceBYZGtetcFZqSBf2VK2p8yEuLjPLk
         jTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=anbkQVw7X10o2caYTRaJPG4CDDlaf2zs/P7UPEynpaU=;
        b=IeGoLZ7nv0900eC3AvRk7ArwXqawBLfr1z+vXvxk4t2vVIphfb7Mgt9C6Xotb8WbPc
         PQqmo8wZz7RfTpiOYoIbZAOeAz+f0pRJ8wH8/ZBGeBgh9xIkmh8JFWShbb9GWtbc1vvS
         W8GweBI8gyF+MVgiUjFxsALGADxRiKQaSzaiQwlHSzZfq0bJNaF00IBiazhPGj2DMXGq
         RdX1RHy3M3h5E6pbs3y3/Z35CCUg65+XFXn6rwpwFpK7ZaL2q1Hxqix35HunG+le1QUO
         MiHBm9zhcEr0EMIDD0Ye2DOoEZ0WPdwwca4BKqfSzFW5PBHzsM1uGPGpb6VDwirb3iZZ
         oI7g==
X-Gm-Message-State: AHYfb5izKt4CPGe/bmdPlVaJHPuzYx1nDaoQKTWZsSwwqo08UQXwYL+7
        ffYr2T/rYnFg2A==
X-Received: by 10.200.54.250 with SMTP id b55mr1881448qtc.13.1503942306270;
        Mon, 28 Aug 2017 10:45:06 -0700 (PDT)
Received: from localhost (dhcp-ec-8-6b-ed-7a-cf.cpe.echoes.net. [72.28.26.219])
        by smtp.gmail.com with ESMTPSA id p21sm653787qta.36.2017.08.28.10.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 10:45:05 -0700 (PDT)
Date:   Mon, 28 Aug 2017 10:45:03 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "\"open list:LIBATA PATA DRIVERS\"" <linux-ide@vger.kernel.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] pata_octeon_cf: use of_property_read_{bool|u32}()
Message-ID: <20170828174502.GX491396@devbig577.frc2.facebook.com>
References: <20170827195613.904715064@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170827195613.904715064@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

On Sun, Aug 27, 2017 at 10:55:09PM +0300, Sergei Shtylyov wrote:
> The Octeon CF driver basically  open-codes of_property_read_{bool|u32}()
> using  of_{find|get}_property() calls in its  probe() method.  Using the
> modern DT APIs saves 2 LoCs and 16 bytes of object code (MIPS gcc 3.4.3).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
