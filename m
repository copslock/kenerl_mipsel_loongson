Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 16:05:41 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45895 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862664AbaGVNGaI0tmr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 15:06:30 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id BD6414633B7
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 14:06:22 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NzeZyXfta3dm for <linux-mips@linux-mips.org>;
        Tue, 22 Jul 2014 14:06:20 +0100 (BST)
Received: from humdrum (unknown [10.24.1.221])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 59E57462A92
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 14:06:20 +0100 (BST)
Date:   Tue, 22 Jul 2014 14:06:17 +0100
From:   Rob Kendrick <rob.kendrick@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: EdgeRouter Pro supported?  Strange FP problems
Message-ID: <20140722130616.GJ30723@humdrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <rob.kendrick@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob.kendrick@codethink.co.uk
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

Hi,

I'm trying to build a kernel for an Ubiquiti EdgeRouter Pro (not a
Lite).  I'm using the current master from linux-mti, and this produces a
kernel that boots and has network support (but bizarrely not activity
LEDs) and USB support, which is good.  However, what I am seeing is
bizarre floating point behavior.

Is there a known issue with master on these Octeon2-based boards?
Should I be pointing my finger of blame at the compiler I've built
(using crosstool-ng) or my configuration of the kernel?

Is there a better choice of compiler and kernel to be using for these
boards?

Thanks for any input,
-- 
Rob Kendrick, Senior Consulting Developer                Codethink Ltd.
Telephone: +44 7880 657 193              302 Ducie House, Ducie Street,
http://www.codethink.co.uk/         Manchester, M1 2JW, United Kingdom.
