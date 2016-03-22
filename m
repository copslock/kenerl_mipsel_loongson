Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 18:24:22 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:45432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006654AbcCVRYVeGpma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 18:24:21 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1aiQ2X-0001Ur-0G; Tue, 22 Mar 2016 18:24:21 +0100
Date:   Tue, 22 Mar 2016 18:24:20 +0100 (CET)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, rt@linutronix.de
Subject: FROZEN transitions in hotplug notifier
Message-ID: <alpine.DEB.2.11.1603221822560.30089@hypnos>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <anna-maria@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anna-maria@linutronix.de
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

the hotplug notifier in arch/mips/cavium-octeon/smp.c doesn't handle
the corresponding FROZEN transitions. Is there a reason for it?

Thanks,
      Anna-Maria
