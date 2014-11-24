Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 15:39:59 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:59977 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014431AbaKXOjwuq6Yh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Nov 2014 15:39:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 8A9F42E2C4;
        Mon, 24 Nov 2014 15:39:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id p7hQPD7D4D2Z; Mon, 24 Nov 2014 15:39:39 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 2DC7C2E2B6;
        Mon, 24 Nov 2014 15:39:39 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 16FF7766;
        Mon, 24 Nov 2014 15:39:39 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 0B44B39E;
        Mon, 24 Nov 2014 15:39:39 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 094FE3E34F;
        Mon, 24 Nov 2014 15:39:39 +0100 (CET)
Received: from [10.94.49.1] (10.94.49.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Mon, 24 Nov 2014 15:39:38
 +0100
Message-ID: <5473432A.8090803@axis.com>
Date:   Mon, 24 Nov 2014 15:39:38 +0100
From:   Niklas Cassel <niklas.cassel@axis.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
MIME-Version: 1.0
To:     "paul.burton@imgtec.com >> Paul Burton" <paul.burton@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: MIPS_MT_SMP selects MIPS_GIC_IPI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <niklas.cassel@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.cassel@axis.com
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

Hello


Since commit

0c2cb004b262987f7ab84d0c40b7bff74ed5d17b

config MIPS_MT_SMP

selects MIPS_GIC_IPI


I was wondering, GIC was introduced with 1004K,
surely not all MIPS_MT_SMP capable CPUs have a GIC?


I'm sorry if I'm missing something obvious :)
