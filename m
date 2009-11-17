Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 14:10:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51529 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493002AbZKQNKi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 14:10:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHDAj3N024156;
	Tue, 17 Nov 2009 14:10:45 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHDAj8D024155;
	Tue, 17 Nov 2009 14:10:45 +0100
Date:	Tue, 17 Nov 2009 14:10:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	yanh@lemote.com, huhb@lemote.com
Subject: Re: [PATCH v1 2/3] MIPS: add basic options for CPUFreq support
Message-ID: <20091117131045.GB17252@linux-mips.org>
References: <cover.1258392631.git.wuzhangjin@gmail.com> <2baac080ae9d0abb943b44b0505a8759cdaa9a41.1258392631.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2baac080ae9d0abb943b44b0505a8759cdaa9a41.1258392631.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 01:32:58AM +0800, Wu Zhangjin wrote:

> Subject: [PATCH v1 2/3] MIPS: add basic options for CPUFreq support
> 
> This patch adds basic options for MIPS CPUFreq support.
> 
> Since MIPS Timer's frequency is relative to the processor's frequency,
> So, MIPS CPUFreq support not only need the processor's CPUFreq support
> but also need an external timer. otherwise, we will make the system time
> "mussy".

Thanks, queue for 2.6.33.

  Ralf
