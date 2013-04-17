Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Apr 2013 11:13:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34161 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3DQJNfU5PAQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Apr 2013 11:13:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r3H9DM29009359;
        Wed, 17 Apr 2013 11:13:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r3H9D84i009351;
        Wed, 17 Apr 2013 11:13:08 +0200
Date:   Wed, 17 Apr 2013 11:13:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, x86@kernel.org, sparclinux@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/28] proc: Split kcore bits from linux/procfs.h into
 linux/kcore.h [RFC]
Message-ID: <20130417091308.GA9292@linux-mips.org>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk>
 <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36249
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

On Tue, Apr 16, 2013 at 07:26:01PM +0100, David Howells wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
