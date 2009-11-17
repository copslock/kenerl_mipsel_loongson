Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 14:11:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51545 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492982AbZKQNKv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 14:10:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHDAxcu024163;
	Tue, 17 Nov 2009 14:10:59 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHDAxPd024162;
	Tue, 17 Nov 2009 14:10:59 +0100
Date:	Tue, 17 Nov 2009 14:10:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	yanh@lemote.com, huhb@lemote.com
Subject: Re: [PATCH v1 3/3] [loongson] 2f: add CPUFreq support
Message-ID: <20091117131059.GC17252@linux-mips.org>
References: <cover.1258392631.git.wuzhangjin@gmail.com> <098db5f99a601ad0f5853e7ca0a66200f351a86b.1258392631.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098db5f99a601ad0f5853e7ca0a66200f351a86b.1258392631.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 01:32:59AM +0800, Wu Zhangjin wrote:

> Subject: [PATCH v1 3/3] [loongson] 2f: add CPUFreq support
> 
> Loongson2f add a new capability to dynamicly scale cpu frequency. And
> when we put it into wait mode via setting the frequency as ZERO, it will
> wait there until an external interrupt take place, which will help
> saving power for us.
> 
> And as the last patch described, to enable this support, an external
> timer is needed to avoid getting wrong system time when using the MIPS
> Timer, 'Cause the MIPS Timer's frequency is half of the cpu frequency,
> when the cpu frequency is changed, the MIPS Timer will be not accuracy.
> 
> This version incorporates the feedback from "Dominik Brodowski
> <linux@dominikbrodowski.net>" to register transition notifier before
> register_driver().

Thanks, queue for 2.6.33.

  Ralf
