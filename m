Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:45:46 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:33139 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6860015AbaFWJpFETS0H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:45:05 +0200
Received: (qmail 32575 invoked from network); 23 Jun 2014 09:45:03 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 23 Jun 2014 09:45:03 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 32219-02 for <linux-mips@linux-mips.org>;
 Mon, 23 Jun 2014 10:44:55 +0100 (BST)
Received: (qmail 32489 invoked by uid 599); 23 Jun 2014 09:44:55 -0000
Received: from unknown (HELO AcuExch.aculab.com) (10.202.163.4)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Mon, 23 Jun 2014 10:44:55 +0100
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Mon, 23 Jun 2014 10:44:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Markos Chandras' <markos.chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH 14/17] MIPS: bpf: Prevent kernel fall over for >=32bit
 shifts
Thread-Topic: [PATCH 14/17] MIPS: bpf: Prevent kernel fall over for >=32bit
 shifts
Thread-Index: AQHPjscu5VlynnjrkEO/YocR+d49Wpt+cUag
Date:   Mon, 23 Jun 2014 09:44:31 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1726096C@AcuExch.aculab.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
 <1403516340-22997-15-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1403516340-22997-15-git-send-email-markos.chandras@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

From: Markos Chandras
> Remove BUG_ON() if the shift immediate is >=32 to avoid
> kernel crashes due to malicious user input. Since the micro-assembler
> will not allow an immediate greater or equal to 32, we will use the
> maximum value which is 31. This will do the correct thing on either 32-
> or 64-bit cores since no 64-bit instructions are being used in JIT.

I'm not sure that bounding the shift to 31 bits 'is the correct thing'.
I'd have thought that emulating the large shift or masking the shift
to 5 bits are equally 'correct'.

...
>  {
>  	/* sa is 5-bits long */
> -	BUG_ON(sa >= BIT(5));
> +	if (sa >= BIT(5))
> +		sa = BIT(5) - 1;
>  	emit_instr(ctx, sll, dst, src, sa);
...

	David
