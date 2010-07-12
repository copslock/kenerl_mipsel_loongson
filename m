Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2010 17:37:56 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63156 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491973Ab0GLPhv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jul 2010 17:37:51 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA70B6D57;
        Mon, 12 Jul 2010 11:37:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:content-type
        :content-transfer-encoding; s=sasl; bh=XtTp5PFhirzBhJTFmpLVkDdkm
        Js=; b=CVa9y5AUgAaGy694EAfnnGoYeLE6oedYU1PvLj+R7mZQ9qs1Jkp5m/JWA
        Ap15xWlcOSI/wAHubpVP+s76e4iOnTUs6V3267aoGD5KY/EwhIi9oAsGLxhZBWLK
        Uy9g7C1/e4Mh8oPgp04jy1KOFg5rfbiBIUf5aoAaA2P/fMwui0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=mukK7TwpAT3952G/L97
        /7eq3OGZ18ENab2yq7VmJINxYhZQTd5LN8oEDZzu9nkI8sLpVzyaMs/UaxykpkVY
        0ZTDATpntChY8oiTJnX3LgF9JYF42KjG0uD9iVGarVgbd9npYnXEjfkSxUu3nlti
        ncsLmsEZOYKHWtdPNFxCsMPU=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B63AB6D55;
        Mon, 12 Jul 2010 11:37:33 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2CFCB6D52; Mon, 12 Jul
 2010 11:37:28 -0400 (EDT)
Message-ID: <4C3B36B3.6010800@pobox.com>
Date:   Tue, 13 Jul 2010 00:37:23 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10)
 Gecko/20100527 Thunderbird/3.0.5
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>, ralf@linux-mips.org,
        macro@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: [PATCH 0/2] MIPS: cpu-feature-overrides patches
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 63886CA4-8DCB-11DF-81BE-DA91016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

Hi,

Here're CPU-feature-overrides patches for PowerTV, Malta and MIPSSim.

Along with these patches, I was going to consolidate irq_ffs() used in
platforms above, but it seems PowerTV's IRQ routines need some work, so
drop the relevant patches for now.

P.S. I don't feel a strong motivation to consolidate irq_ffs(), so you
don't have to take care of my comments.  If you have a chance, take a
look at it, thanks.

  Shinya


David VomLehn (1):
      MIPS: PowerTV: Provide cpu-feature-overrides.h

Shinya Kuribayashi (1):
      MIPS: Enable cpu_has_clo_clz for MIPS Technologies' platforms

 .../include/asm/mach-malta/cpu-feature-overrides.h |    2 +
 .../asm/mach-mipssim/cpu-feature-overrides.h       |    2 +
 .../asm/mach-powertv/cpu-feature-overrides.h       |   59 ++++++++++++++++++++
 3 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
