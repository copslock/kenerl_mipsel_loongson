Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 18:49:55 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32963 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008216AbbFDQtvw10AO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 18:49:51 +0200
Received: by padj3 with SMTP id j3so33045674pad.0
        for <linux-mips@linux-mips.org>; Thu, 04 Jun 2015 09:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1+p45wTk4nHSTyc769cJww1FX3PB+/XyfEgyJ8Knkhw=;
        b=fNt1w8cJVm3FrJ/Gvf1MSM5iKuNAjh81ar8tNxHy9eV6w8el9JfQYng4462zrIDCv2
         yyWj+1/QRn4zp9M4sbBD5LjKFE0qe6gdumJrx0I1samvcIBXNg0ntFQDk1F3G7FlYaxu
         6Gbd5VWFkevLm6cU2pT5/PZCRZTUSijqzUH3z+ftjteEEGRSapZNm0G2dyEl6/15+R3/
         EdHJd//TsX4RyPk+jAOL67u0i8Mp8Fg8LtWFH8pjfWKU55mspy0Ieyy/HCiVTbLrJ3tb
         ICo1JALoKWGUBQAS+yaOVSUezPknBVDEpdrTE500JaEMe3ZhQzUEYcBj7wEBBtdnPLuf
         sjSw==
X-Gm-Message-State: ALoCoQltqK4lK7aqSFkX4qZR8R+sgAgHLGvyjhP+fOi7aJgFeBa956YZAoar3KQpnCeDgUY5B/Ar
X-Received: by 10.70.90.103 with SMTP id bv7mr49727818pdb.160.1433436585462;
        Thu, 04 Jun 2015 09:49:45 -0700 (PDT)
Received: from Alexeis-MBP.westell.com (pool-96-238-218-245.snfcca.dsl-w.verizon.net. [96.238.218.245])
        by mx.google.com with ESMTPSA id bt16sm4319091pdb.91.2015.06.04.09.49.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 09:49:44 -0700 (PDT)
Message-ID: <557081A6.5010407@plumgrid.com>
Date:   Thu, 04 Jun 2015 09:49:42 -0700
From:   Alexei Starovoitov <ast@plumgrid.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] MIPS/BPF fixes for 4.3
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ast@plumgrid.com
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

On 6/4/15 3:56 AM, Markos Chandras wrote:
> Here are some fixes for MIPS/BPF. The first 5 patches do some cleanup
> and lay the groundwork for the final one which introduces assembly helpers
> for MIPS and MIPS64. The goal is to speed up certain operations that do
> not need to go through the common C functions. This also makes the test_bpf
> testsuite happy with all 60 tests passing. This is based in 4.1-rc6.

looks like these patches actually fix two real bugs, right?
If so, I think you probably want them in 'net' tree ?

Different arch maintainers take different stance towards bpf jit
changes. x86, arm and s390 are ok with them going through Dave's trees,
since often there are dependencies on bpf core parts.
So please state clearly what tree you want these patches to go in.

btw, in the net-next tree bpf testsuite has 246 tests and the last
ten are very stressful for JITs.
