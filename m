Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 12:05:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55482 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990845AbdDJKEyV7k4v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 12:04:54 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3AA4rri024238;
        Mon, 10 Apr 2017 12:04:53 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3AA4rXl024237;
        Mon, 10 Apr 2017 12:04:53 +0200
Date:   Mon, 10 Apr 2017 12:04:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2] MIPS: Malta: Fix i8259 irqchip setup
Message-ID: <20170410100453.GA24214@linux-mips.org>
References: <1491494289-22441-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491494289-22441-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57623
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

On Thu, Apr 06, 2017 at 04:58:09PM +0100, Matt Redfearn wrote:

Thanks, applied.

  Ralf
