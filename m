Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 06:25:09 +0200 (CEST)
Received: from us01smtprelay-2.synopsys.com ([198.182.44.111]:41132 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816543AbaDHEZG35PQa convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Apr 2014 06:25:06 +0200
Received: from us01secmta1.synopsys.com (us01secmta1.synopsys.com [10.9.203.100])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 299D524E103C;
        Mon,  7 Apr 2014 21:24:57 -0700 (PDT)
Received: from us01secmta1.internal.synopsys.com (us01secmta1.internal.synopsys.com [127.0.0.1])
        by us01secmta1.internal.synopsys.com (Service) with ESMTP id 1C49927113;
        Mon,  7 Apr 2014 21:24:57 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by us01secmta1.internal.synopsys.com (Service) with ESMTP id 27AE527102;
        Mon,  7 Apr 2014 21:24:56 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1345C777;
        Mon,  7 Apr 2014 21:24:56 -0700 (PDT)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id CF883776;
        Mon,  7 Apr 2014 21:24:54 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Mon, 7 Apr 2014 21:23:51 -0700
Received: from IN01WEMBXA.internal.synopsys.com ([fe80::ed6f:22d3:d35:4833])
 by IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0158.001; Tue,
 8 Apr 2014 09:53:50 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Rob Herring <robherring2@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Chris Zankel <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 08/20] of/fdt: consolidate built-in dtb section variables
Thread-Topic: [PATCH 08/20] of/fdt: consolidate built-in dtb section
 variables
Thread-Index: AQHPT4qHMeYKD9X5AEShYbdSke0Yxg==
Date:   Tue, 8 Apr 2014 04:23:48 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230751ABA59@IN01WEMBXA.internal.synopsys.com>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
 <1396563423-30893-9-git-send-email-robherring2@gmail.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.213]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

Hi Rob,

On Friday 04 April 2014 03:47 AM, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>
> Unify the various architectures __dtb_start and __dtb_end definitions
> moving them into of_fdt.h.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-metag@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux@lists.openrisc.net
> Cc: linux-xtensa@linux-xtensa.org

Acked-by: Vineet Gupta <vgupta@synopsys.com>  # arch/arc bits

Thx,
-Vineet
