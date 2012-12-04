Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2012 16:54:53 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56085 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6831636Ab2LDPyvv20rQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Dec 2012 16:54:51 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qB4Fsmci019541;
        Tue, 4 Dec 2012 16:54:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qB4FskiT019540;
        Tue, 4 Dec 2012 16:54:46 +0100
Date:   Tue, 4 Dec 2012 16:54:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hillf Danton <dhillf@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Avoid Machine Check by flushing entire page range
 in huge_ptep_set_access_flags().
Message-ID: <20121204155446.GA19472@linux-mips.org>
References: <1354567466-23571-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354567466-23571-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35175
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Dec 03, 2012 at 12:44:26PM -0800, David Daney wrote:

Looks good and has survived my testing so far.  Applied.

Thanks David!

  Ralf
