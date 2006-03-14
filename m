Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 12:32:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24512 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133528AbWCNMb4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2006 12:31:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2ECf0sM004621;
	Tue, 14 Mar 2006 12:41:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2ECf0KK004620;
	Tue, 14 Mar 2006 12:41:00 GMT
Date:	Tue, 14 Mar 2006 12:41:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is there a way to read cp0_performance in user space?
Message-ID: <20060314124100.GA4438@linux-mips.org>
References: <50c9a2250603131856n61c75573w99b4e5f4e3bbce10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250603131856n61c75573w99b4e5f4e3bbce10@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 14, 2006 at 10:56:57AM +0800, zhuzhenhua wrote:

> to test my deocder program, i want read cp0_performance, is there a
> way to do that in linux?

There is no interface to directly access the performance counter registers
from an application as it is a priviledged CPU resource.  You can
however use oprofile's kernel interfaces.

  Ralf
