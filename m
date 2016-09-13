Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 18:03:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47180 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbcIMQCyaNiU8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2016 18:02:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8DG2qxH026069;
        Tue, 13 Sep 2016 18:02:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8DG2qSS026068;
        Tue, 13 Sep 2016 18:02:52 +0200
Date:   Tue, 13 Sep 2016 18:02:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: rb532: Fix undefined reference to setup_serial_port
Message-ID: <20160913160251.GC20655@linux-mips.org>
References: <1473092320-30019-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473092320-30019-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55128
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

On Mon, Sep 05, 2016 at 05:18:40PM +0100, Matt Redfearn wrote:

> If the rb532 machine is compiled without CONFIG_SERIAL_8250, the
> following linker error occurs
> 
> arch/mips/built-in.o: In function `setup_serial_port':
> (.init.text+0x20c): undefined reference to `early_serial_setup'
> 
> Fix this by wrapping registration of the rb532 uart in an ifdef
> CONFIG_SERIAL_8250.

This will still fail if CONFIG_SERIAL_8250 = m.

RB532 should be rewritten to use earl console rather than early_serial_setup
similar to https://git.linux-mips.org/cgit/ralf/linux.git/commit/?id=194d315da86af504559a8a21026360097575bd55
for example.

  Ralf
