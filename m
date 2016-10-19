Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 10:58:28 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991970AbcJSI6WVt91v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 10:58:22 +0200
Received: by mail-wm0-f68.google.com with SMTP id o81so2926442wma.3
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=na1xEiY7vwFkk2mtwTzhXScjGg35mMtciEEQOBLT21o=;
        b=oE0LfCjOczjTxKOPIZR1tCsr+UwAOD+Bljms1i16ebPzHiLEWudOeIv8R3N6SoVhc7
         XZkonaBh9jWN3FGOqi6YDDGFJm9dWKgJ4rxFjLNIh9VbBcg3QGOuD4Vadq/g9oOP/ATV
         etreg9sppNuydFDMlkF+iqoUp48N4xJcC2bnULoJ73/aV2DDoNPTha9Tw/ZoAeok7Fak
         yzLShRtclzvuV5Cfip2UgoOQOe3CdosDE9Beyi+dC9ORuEpndvY2UXQMJGNwy/IEEeeC
         4P9W3JKHhFyyXZuMuVTb2mq1O2+gr2VKMWtcpQVLdfAp6Mt7i5Y/LiHSulLN4YGldEPk
         PavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=na1xEiY7vwFkk2mtwTzhXScjGg35mMtciEEQOBLT21o=;
        b=ME8BI2v/uIXWZLQ1VmEXTEbcEapuv/17JJc8RUIWDpbAmiPu+RcXusU906uuebXERt
         whaaBUfWte6cb10YTptIODq2PPphaLS4a0ag24jIgUudrJIj3zv8nnIt6izLyHHXQK+1
         EYMUaibNbIZM0j5eA5AqhTJUZ9BlvvScyM2uCL58ZchfSbRR5uHeVYzJsQ0XmRlF8FnU
         smXJHIDcTnQrNhPhSqfqjUWDE8nPaLUuc6RP3OcSTg9DZ8aniUiq1HvHiV8wGkN1uHZ4
         Kd/MIuqvH3mSGGWShd+9d/6FEX3+riG9QHTBfiDrNOf9ldC8/cDQb8f2YDhyU1OvUBWh
         IExw==
X-Gm-Message-State: AA6/9RkZ2V7IiI2WbySikf3ae9m9efHyesx9n/1c7KLu1RBke/94ucm9R9758nGBiPL8tA==
X-Received: by 10.28.98.67 with SMTP id w64mr1725706wmb.50.1476867497041;
        Wed, 19 Oct 2016 01:58:17 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id wn5sm25840301wjb.42.2016.10.19.01.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 01:58:15 -0700 (PDT)
Date:   Wed, 19 Oct 2016 09:58:15 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
Message-ID: <20161019085815.GA22239@lucifer>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161018153050.GC13117@dhcp22.suse.cz>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstoakes@gmail.com
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

On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
> I am wondering whether we can go further. E.g. it is not really clear to
> me whether we need an explicit FOLL_REMOTE when we can in fact check
> mm != current->mm and imply that. Maybe there are some contexts which
> wouldn't work, I haven't checked.

This flag is set even when /proc/self/mem is used. I've not looked deeply into
this flag but perhaps accessing your own memory this way can be considered
'remote' since you're not accessing it directly. On the other hand, perhaps this
is just mistaken in this case?

> I guess there is more work in that area and I do not want to impose all
> that work on you, but I couldn't resist once I saw you playing in that
> area ;) Definitely a good start!

Thanks, I am more than happy to go as far down this rabbit hole as is helpful,
no imposition at all :)
