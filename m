Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 12:07:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57827 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013363AbaKKLHD5i8vF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 12:07:03 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABB72HB029408;
        Tue, 11 Nov 2014 12:07:02 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABB72tp029407;
        Tue, 11 Nov 2014 12:07:02 +0100
Date:   Tue, 11 Nov 2014 12:07:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for
 Loongson-3
Message-ID: <20141111110702.GA28822@linux-mips.org>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
 <20141111105748.GK27259@linux-mips.org>
 <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43991
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

On Tue, Nov 11, 2014 at 07:02:48PM +0800, Huacai Chen wrote:

> Loops_per_jiffy is set on startup and doesn't change later. It reflect
> the maximum value frequency, but for CPU hotplug, a new online CPU may
> not run at the maximum frequency (remain the old value before it is
> offline).

As suspected.  But what if a CPU is hotunplugged, then the clockrate
for all the CPUs changes and then the gets re-hotplugged into the system.
Wouldn't in that case the udelay_val be used?

  Ralf
