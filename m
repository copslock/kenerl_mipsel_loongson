Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 17:22:15 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49596 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3HWPWL0FyGV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 17:22:11 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRZ0040PPCD27B0@mailout2.w1.samsung.com>; Fri,
 23 Aug 2013 16:22:03 +0100 (BST)
X-AuditID: cbfec7f5-b7ef66d00000795a-f2-52177e1bde11
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id BD.F5.31066.B1E77125; Fri,
 23 Aug 2013 16:22:03 +0100 (BST)
Received: from [106.116.147.32] by eusync3.samsung.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPA id <0MRZ00BQTPCQLJ70@eusync3.samsung.com>; Fri,
 23 Aug 2013 16:22:03 +0100 (BST)
Message-id: <52177E19.3080106@samsung.com>
Date:   Fri, 23 Aug 2013 17:22:01 +0200
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-version: 1.0
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 2/5] clkdev: Fix race condition in clock lookup from
 device tree
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
 <1377270227-1030-3-git-send-email-s.nawrocki@samsung.com>
In-reply-to: <1377270227-1030-3-git-send-email-s.nawrocki@samsung.com>
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xq7rSdeJBBi2bRSymPnzCZvF+4zwm
        i54/lRZnm96wW3ROXMJusenxNVaLy7vmsFlMmDqJ3WLOnynMFrcv81oceLKczeLphItsFrcb
        V7BZXNqjYnH4TTurxfufjhZP1y1htlg/4zWLxcKGL+wWNyf8YHYQ8Whp7mHzWDnd2+Py9zfM
        Hjtn3WX3+PAxzmN2x0xWj/nTHzF7bFrVyeZx59oeNo+jK9cyeWxeUu+x+2sTo0ffllWMHp83
        yQXwRXHZpKTmZJalFunbJXBlHN/zn73gG3vF3pu/WBoYz7F1MXJySAiYSHzof8QCYYtJXLi3
        HiwuJLCUUWLuH1YI+xOjxL4dziA2r4CWxOa+h2D1LAKqEp/vfWQHsdkEDCV6j/YxgtiiAgES
        i5ecY4eoF5T4MfkeWL2IgIbElK7HYHFmgV4WiUOLjbsYOTiEBSIlZmwACnMBrWpklFjcPx/s
        Bk4BN4lrzfOYIep1JPa3TmODsOUlNq95yzyBUWAWkhWzkJTNQlK2gJF5FaNoamlyQXFSeq6R
        XnFibnFpXrpecn7uJkZIxH7dwbj0mNUhRgEORiUe3gnOYkFCrIllxZW5hxglOJiVRHifVosH
        CfGmJFZWpRblxxeV5qQWH2Jk4uCUamA89Z1jp1H5jYQnTTvYEzp8Kzh/v5tve/Uei8j+n3df
        SujeNJFWq78T/sHoWunS/byBl4J7Tjr6zfjyX2ejj+xrjnWXf7DquS+Vb2fQzlPUNwl0mDw5
        QtrVe3qlt8jXxScWRUid5O8y0WhI2Tn9Wotq7sxTt4SOb3bxLXkdt14ze8Xjw52uFcpKLMUZ
        iYZazEXFiQAP3jeLtgIAAA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.nawrocki@samsung.com
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

On 08/23/2013 05:03 PM, Sylwester Nawrocki wrote:
> There is currently a race condition in the device tree part of clk_get()
> function, since the pointer returned from of_clk_get_by_name() may become
> invalid before __clk_get() call. I.e. due to the clock provider driver
> remove() callback being called in between of_clk_get_by_name() and
> __clk_get().
> 
> Fix this by doing both the look up and __clk_get() operations with the
> clock providers list mutex held. This ensures that the clock pointer
> returned from __of_clk_get_from_provider() call and passed to __clk_get()
> is valid, as long as the clock supplier module first removes its clock
> provider instance and then does clk_unregister() on the corresponding
> clocks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Oops, I missed to add:

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
