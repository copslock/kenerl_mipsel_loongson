Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 14:10:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51518 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492943AbZKQNKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 14:10:34 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHDAXAe024148;
	Tue, 17 Nov 2009 14:10:34 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHDASoX024146;
	Tue, 17 Nov 2009 14:10:28 +0100
Date:	Tue, 17 Nov 2009 14:10:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	yanh@lemote.com, huhb@lemote.com
Subject: Re: [PATCH v1 1/3] [loongson] lemote-2f: add cs5536 MFGPT timer
	support
Message-ID: <20091117131028.GA17252@linux-mips.org>
References: <cover.1258392631.git.wuzhangjin@gmail.com> <824cd0205789fb1332079a4f3ff3bb0fb9f446e2.1258392631.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824cd0205789fb1332079a4f3ff3bb0fb9f446e2.1258392631.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 01:32:57AM +0800, Wu Zhangjin wrote:

> Subject: [PATCH v1 1/3] [loongson] lemote-2f: add cs5536 MFGPT timer support
> 
> When we want to enable CPUFreq support for loongson2f, it need an
> external timer, this patch add it.
> 
> 'Cause the frequency of the MIPS Timer is half of the cpu frequency, if
> we use it with Cpufreq support, the sytem time will become not accuracy.
> 
> And we export the mfgpt0 counter disable/enable operations for the
> coming suspend support to suspend/resume the timer.

Thanks, queue for 2.6.33.

  Ralf
