Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 19:33:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45178 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008587AbcCVSdw1R7Uh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Mar 2016 19:33:52 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2MIXo0r008491;
        Tue, 22 Mar 2016 19:33:50 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2MIXoVU008489;
        Tue, 22 Mar 2016 19:33:50 +0100
Date:   Tue, 22 Mar 2016 19:33:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, rt@linutronix.de
Subject: Re: FROZEN transitions in hotplug notifier
Message-ID: <20160322183350.GC1670@linux-mips.org>
References: <alpine.DEB.2.11.1603221822560.30089@hypnos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603221822560.30089@hypnos>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52679
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

Hello Anna-Maria :)

On Tue, Mar 22, 2016 at 06:24:20PM +0100, Anna-Maria Gleixner wrote:

> the hotplug notifier in arch/mips/cavium-octeon/smp.c doesn't handle
> the corresponding FROZEN transitions. Is there a reason for it?

My guess would be bitrot.

David?

  Ralf
