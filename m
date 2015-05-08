Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 21:42:11 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59719 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026572AbbEHTmKMQr6g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 21:42:10 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6CB5323;
        Fri,  8 May 2015 19:42:03 +0000 (UTC)
Date:   Fri, 8 May 2015 12:42:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-Id: <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
In-Reply-To: <1431113626-19153-1-git-send-email-emunson@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.com> wrote:

> mlock() allows a user to control page out of program memory, but this
> comes at the cost of faulting in the entire mapping when it is
> allocated.  For large mappings where the entire area is not necessary
> this is not ideal.
> 
> This series introduces new flags for mmap() and mlockall() that allow a
> user to specify that the covered are should not be paged out, but only
> after the memory has been used the first time.

Please tell us much much more about the value of these changes: the use
cases, the behavioural improvements and performance results which the
patchset brings to those use cases, etc.
