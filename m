Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 20:22:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54530 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006760AbaHYSWfB8pgi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 20:22:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PIMVFg003932;
        Mon, 25 Aug 2014 20:22:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PIMUr5003931;
        Mon, 25 Aug 2014 20:22:30 +0200
Date:   Mon, 25 Aug 2014 20:22:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V4] MIPS: Loongson-3: Enable the COP2 usage
Message-ID: <20140825182230.GJ25892@linux-mips.org>
References: <1406768782-14644-1-git-send-email-chenhc@lemote.com>
 <CAAhV-H63fxcX5dUMBwsM7CyO+ot4kGz++YDq+n4-=g0qNBR0Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H63fxcX5dUMBwsM7CyO+ot4kGz++YDq+n4-=g0qNBR0Hg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42232
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

On Thu, Jul 31, 2014 at 09:13:37AM +0800, Huacai Chen wrote:

> 
> I found that the V3 of Loongson's patchset has been merged into
> mips-for-linux-next. But the 7th patch (this one) should be updated
> for preemptible kernel. The reason is nearly the same as
> http://www.linux-mips.org/archives/linux-mips/2014-07/msg00237.html.
> Thanks.

I'm marking this one as rejected because V3 plus
https://patchwork.linux-mips.org/patch/7515/ which are already applied
are identical.

Thanks,

  Ralf
