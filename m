Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 11:46:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41934 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009901AbcBJKqcEYx5p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 11:46:32 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1AAkUJe012439;
        Wed, 10 Feb 2016 11:46:30 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1AAkTcP012438;
        Wed, 10 Feb 2016 11:46:29 +0100
Date:   Wed, 10 Feb 2016 11:46:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
Subject: Re: [PATCH 6/6] MIPS: Expose current_cpu_data.options through debugfs
Message-ID: <20160210104629.GA11091@linux-mips.org>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-7-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455051354-6225-7-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Feb 09, 2016 at 12:55:54PM -0800, Florian Fainelli wrote:

> Debugging a missing features in cpu-features-override.h, or a runtime feature
> set/clear in the vendor specific cpu_probe() function can be a little tedious,
> ease that by providing a debugfs entry representing the
> current_cpu_data.options bitmask.

Hm..  Bits in the options bitmaps are not an ABI, they come and sometimes
they go as well and manual decoding can be tedious to humans.  so I'm
wondering if something in /sys/devices/system/cpu would be more suitable.
It'd depend on just sysfs, not debugfs which is disabled in production
kernels.

Thoughts?

  Ralf
